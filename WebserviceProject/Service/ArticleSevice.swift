//
//  ArticleSevice.swift
//  WebserviceProject
//
//  Created by KSHRD on 12/23/16.
//  Copyright © 2016 KSHRD. All rights reserved.
//

import Foundation
import Alamofire

class ArticleService {
    
    func getData(page: Int , limit: Int){
        
        Alamofire.request("http://120.136.24.174:1301/v1/api/articles?page=1&limit=15",method:.get
            ).responseJSON{
                (response) in
                print(response.result.value)
                
            }
        
        print("Hello")
    }


}
