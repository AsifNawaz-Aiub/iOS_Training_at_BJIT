//
//  HomeViewController.swift
//  Md Asif Nawaz 30018
//
//  Created by BJIT on 26/1/23.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    var viewModel: HomeViewModel = .init()
    var cellViewDataSource: [Article] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        setupBinder()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getAllNews()
    }

    func configView() {
        title = "Top News"
        view.backgroundColor = .systemBackground
        setupTableView()
    }

    func setupBinder() {
        viewModel.isLoading.bind { [weak self] isLoading in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if isLoading == true {
                    self.activityIndicator.startAnimating()
                } else if isLoading == false { self.activityIndicator.stopAnimating()
                }
            }
        }
        viewModel.cellViewDataSource.bind { [weak self] cellViewDataSource in
            guard let self = self else { return }
            self.cellViewDataSource = cellViewDataSource
            self.reloadTable()
        }
    }

    func navigateToNewsDetailView(article: Article) {
        let newsDetailViewModel = NewsDetailViewModel(article: article)
        let newsDetailViewController = NewsDetailViewController(viewModel: newsDetailViewModel)
        newsDetailViewController.loadViewIfNeeded()
        navigationController?.pushViewController(newsDetailViewController, animated: true)
    }
    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}
