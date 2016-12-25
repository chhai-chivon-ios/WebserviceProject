//
//  ArticlePresenterProtocol.swift
//  WebserviceProject
//
//  Created by KSHRD on 12/23/16.
//  Copyright © 2016 KSHRD. All rights reserved.
//

import Foundation

protocol ArticlePresenterProtocol {
    
    func ResponseArticle(articles : [Article])
    func didResponseDataPost(articles : Article)
}

extension ArticlePresenterProtocol {
    func didResponseDataPost(articles : Article) {  }
    func ResponseArticle(articles : [Article]) { }
}
