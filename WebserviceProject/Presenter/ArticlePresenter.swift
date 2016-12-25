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
    
    func postData(data : [String: Any])  {
         articleService.postData(data: data)
    }
    
    func deleteData(articleID : Int , completion :@escaping (_ status : Bool) -> Void) {
        print("Prensenter")
        articleService.deleteData(articleID: articleID, completion:{(status) in
        completion(status)
        print("My Status  \(status)")
        })
        
    }

    
}

extension ArticlePresenter : ArticleServiceProtocol{
    
    func didResponseData(articles: [Article]) {
        //print("Number of : \(articles.count)")
        self.delegate?.ResponseArticle(articles: articles)
    }
    
    func didResponseDataPost(articles: Article) {
        self.delegate?.didResponseDataPost(articles: articles)
    }
    
    
}
