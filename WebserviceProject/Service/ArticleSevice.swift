//
//  ArticleSevice.swift
//  WebserviceProject
//
//  Created by KSHRD on 12/23/16.
//  Copyright © 2016 KSHRD. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ArticleService {
    
    var delegate : ArticleServiceProtocol?
    
    func getData(page: Int , limit: Int){
      
         Alamofire.request("http://120.136.24.174:1301/v1/api/articles?page=\(page)&limit=\(limit)",method:.get).responseJSON{ (response) in
                
                let responseJson = JSON(data : response.data!)
                var articles = [Article]()
                for art in responseJson["DATA"].array!{
                    articles.append(Article(article: art))
                }
                self.delegate?.didResponseData(articles: articles)
        }
        
    }
}

