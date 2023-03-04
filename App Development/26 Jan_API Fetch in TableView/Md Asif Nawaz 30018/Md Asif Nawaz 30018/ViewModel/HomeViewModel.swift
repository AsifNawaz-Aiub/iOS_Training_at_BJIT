//
//  HomeViewModel.swift
//  Md Asif Nawaz 30018
//
//  Created by BJIT on 26/1/23.
//

import Foundation

class HomeViewModel {
    var isLoading: Observable<Bool> = Observable(false)
    var dataSource: NewsModel?
    var cellViewDataSource: Observable<[Article]> = Observable([Article]())
    func numberOfSection() -> Int {
        return 1
    }

    func numberOfRows(in _: Int) -> Int {
        return cellViewDataSource.value.count
    }

    func getAllNews() {
        if isLoading.value == true {
            return
        }
        isLoading.value = true
        NetworkManager.shared.getNews(category: "All News", completed: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .failure(error):
                print(error)
                if error == .unableToComplete {
                    DispatchQueue.main.async {
                        // self.present( Constants.showAlert(msg: "Check your network connection"), animated: true)
                        NetworkManager.shared.isPaginating = false
                    }
                }
            case let .success(news):
                self.dataSource = news
                self.isLoading.value = false
                if let dataSource = self.dataSource {
                    self.cellViewDataSource.value = dataSource.articles
                }
            }
        })
    }
}
