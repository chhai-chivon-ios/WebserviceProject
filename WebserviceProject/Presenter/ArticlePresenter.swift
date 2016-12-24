//
//  ArticlePresenter.swift
//  WebserviceProject
//
//  Created by KSHRD on 12/23/16.
//  Copyright © 2016 KSHRD. All rights reserved.
//

import Foundation


class ArticlePresenter {
    
    var articleService : ArticleService
    var delegate : ArticlePresenterProtocol?
    
    init() {
        articleService = ArticleService()
        articleService.delegate = self
    }
    
    func getData(page: Int ,limit : Int )  {
         articleService.getData(page: page, limit: limit)
    }
    
}

extension ArticlePresenter : ArticleServiceProtocol{
    
    internal func didResponseData(articles: [Article]) {
        //print("Number of : \(articles.count)")
        self.delegate?.ResponseArticle(articles: articles)
    }

}
