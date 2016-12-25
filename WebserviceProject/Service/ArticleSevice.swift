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
                var pagination = responseJson["PAGINATION"]
                Pagination.shared.curentPage = pagination["PAGE"].int!
                Pagination.shared.totalPage = pagination["TOTAL_PAGES"].int!
                var articles = [Article]()
                for art in responseJson["DATA"].array!{
                    articles.append(Article(article: art))
                }
                self.delegate?.didResponseData(articles: articles)
        }
        
    }
    
    //Post Data from view To Server
    func postData(data :[String: Any]) {
        let image = data["image"] as! UIImage
        let article = data["article"] as! Article
        uploadImage(image: image) { (url) in
            article.image = url
            self.uploadData(article: article, completion: { (response) in
                let responseJson = JSON(data: response.data!)
                let article = Article(article: responseJson["DATA"])
                self.delegate?.didResponseDataPost(articles: article)

            })
        }
        
    }

    private func uploadImage(image :UIImage , completion :@escaping ( _ result : String) -> Void){
        Alamofire.upload(multipartFormData: { (multipartFormData)
            in
            multipartFormData.append(UIImageJPEGRepresentation(image, 0.5)!, withName: "FILE",fileName:"jpg", mimeType: "image/jpeg")
            
        }, to: "http://120.136.24.174:1301/v1/api/uploadfile/single",method: .post){(dataEncodingResult)
            in
            switch dataEncodingResult{
            case .success(let upload ,_,_) :
                upload.responseJSON(completionHandler: { (response) in
                    
                    let responseData = response.result.value as! [String : Any]
                    let url = responseData["DATA"] as! String
                    completion(url)
                    
                })
                
            case .failure(let errorencoding):
                print(errorencoding)
                
            }
            
        }
    }
    
    
    func uploadData(article : Article, completion :@escaping ( _ result : DataResponse <Any>) -> Void)  {
        
        Alamofire.request("http://120.136.24.174:1301/v1/api/articles", method: .post, parameters: article.converToObject(), encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print("Post Success \(response)")
            completion(response)
        }
        
    }
    
    func deleteData(articleID : Int , completion :@escaping (_ status : Bool) -> Void) {
        
        Alamofire.request("http://120.136.24.174:1301/v1/api/articles/\(articleID)", method: .delete).responseJSON { (response) in
            print(" Success \(response)")
            let responseJson = JSON(data: response.data!)
            let code = responseJson["CODE"].string
            if code == "0000"{
               completion(true)
            }else {
               completion(true)
            }
           }
    }
    
}
