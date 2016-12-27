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
    
    func updateData(data : [String: Any],cheeck : Bool)  {
        articleService.updateData(data: data,cheeck : cheeck)
    }
    func deleteData(articleID : Int , completion :@escaping (_ status : Bool) -> Void) {
        articleService.deleteData(articleID: articleID, completion:{(status) in
        completion(status)
        })
        
    }

    
}

extension ArticlePresenter : ArticleServiceProtocol{
    
    func didResponseDataUpdate(articles: Article) {
        self.delegate?.didResponseDataUpdate(articles: articles)
    }

    func didResponseData(articles: [Article]) {
        //print("Number of : \(articles.count)")
        self.delegate?.ResponseArticle(articles: articles)
    }
    
    func didResponseDataPost(articles: Article) {
        self.delegate?.didResponseDataPost(articles: articles)
    }
    
    
}
