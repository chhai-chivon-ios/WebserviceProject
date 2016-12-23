//
//  Artitcle.swift
//  WebserviceProject
//
//  Created by KSHRD on 12/22/16.
//  Copyright © 2016 KSHRD. All rights reserved.
//

import Foundation
import SwiftyJSON

class Article{
    
    var id : Int?
    var title : String?
    var description : String?
    var image : String?
    
    init() {
        self.id = 0
        self.title = ""
        self.image = ""
        self.description = ""
        self.image = ""
    }
    init(article  :JSON) {
        self.id = article["ID"].int
        self.title = article["TITLE"].string
        self.description = article["DESCRIPTION"].string
        self.image = article["IMAGE"].string
    }
}




