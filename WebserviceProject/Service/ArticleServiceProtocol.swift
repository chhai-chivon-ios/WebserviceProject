//
//  ArticleServiceProtocol.swift
//  WebserviceProject
//
//  Created by KSHRD on 12/23/16.
//  Copyright © 2016 KSHRD. All rights reserved.
//

import Foundation

protocol ArticleServiceProtocol {
    
    func didResponseData(articles : [Article])
    func didResponseDataPost(articles : Article)
}

