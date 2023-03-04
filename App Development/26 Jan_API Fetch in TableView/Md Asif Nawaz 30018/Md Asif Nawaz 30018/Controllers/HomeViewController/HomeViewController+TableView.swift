//
//  HomeViewController+TableView.swift
//  Md Asif Nawaz 30018
//
//  Created by BJIT on 26/1/23.
//

import Foundation
import UIKit

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        registerCells()
    }

    func registerCells() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    func numberOfSections(in _: UITableView) -> Int {
        viewModel.numberOfSection()
    }

    func reloadTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        100
    }

    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // cell.setupCell(viewModel: moviesDataSource[indexPath.row])
        cell.selectionStyle = .none
        cell.textLabel?.text = "News Title - \(cellViewDataSource[indexPath.row].title)"
        // cell.detailTextLabel?.text = self.cellViewDataSource[indexPath.row].description
        return cell
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = cellViewDataSource[indexPath.row]
        navigateToNewsDetailView(article: article)
    }
}

// as? MovieTableViewCell else {
//    return UITableViewCell()
// }
