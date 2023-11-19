//
//  WishMakerViewModel.swift
//  isvolodinPW3
//
//  Created by Илья Володин on 17.11.2023.
//

import Foundation

class WishMakerViewModel {
    var bindWishMakerViewModelToController : (() -> ()) = {}
    
    private(set) var wishes: Wishes! {
        didSet {
            bindWishMakerViewModelToController()
        }
    }
    
    init() {
        updateData()
    }
    
    func addWish(text: String) {
        wishes.array.append(Wish(text))
    }
    
    func updateData() {
        wishes = Wishes(array: [Wish("tmp wish"), Wish("another wish"), Wish("and one else"), Wish("last one, I promise!")])
    }
}
