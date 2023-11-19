//
//  WishClass.swift
//  isvolodinPW3
//
//  Created by Илья Володин on 18.11.2023.
//

import Foundation

struct Wishes {
    var array: [Wish]!
}

struct Wish {
    var text: String!
    
    init(_ text: String!) {
        self.text = text
    }
}

