//
//  NewsDetailViewModel.swift
//  Md Asif Nawaz 30018
//
//  Created by BJIT on 27/1/23.
//

import Foundation
import SDWebImage

class NewsDetailViewModel {
    var article: Article
    var imageURL: String?
    var title: String
    init(article: Article) {
        self.article = article
        imageURL = article.urlToImage
        title = article.title
    }
}
