//
//  Model.swift
//  KindleBasic
//
//  Created by Hoe Zhan Hui on 4/26/17.
//  Copyright © 2017 VMax. All rights reserved.
//

import UIKit

class Book {
    let title: String
    let author: String
    let image: UIImage
    let pages: [Page]
    let coverImageUrl: String
    
//    init(title: String, author: String, image: UIImage, pages: [Page]) {
//        self.title = title
//        self.author = author
//        self.image = image
//        self.pages = pages
//        self.coverImageUrl = ""
//    }
    
    //?? "" --> return empty string if cannot unwrap to string
    init(dictionary: [String:Any]) {
        self.title = dictionary["title"] as? String ?? ""
        self.author = dictionary["author"] as? String ?? ""
        self.image = #imageLiteral(resourceName: "steve_jobs")
        
        self.coverImageUrl = dictionary["coverImageUrl"] as? String ?? ""
        
        var bookPages = [Page]()    //way to declare a Page Array --> use () after []
        
        if let pagesDictionary = dictionary["pages"] as? [[String: Any]] {
          
            for pageDictionary in pagesDictionary {
                
                if let pageText = pageDictionary["text"] as? String {
                    let page = Page(number: 1, text: pageText)
                    bookPages.append(page)
                }
                
            }
        }
        pages = bookPages
    }
}

class Page {
    let number: Int
    let text: String
    
    init(number: Int, text: String) {
        self.number = number
        self.text = text
    }
}
