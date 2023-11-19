//
//  WishMakerViewModel.swift
//  isvolodinPW3
//
//  Created by Илья Володин on 17.11.2023.
//

import Foundation

class WishMakerViewModel {
    private enum Constants {
        static let wishesKey = "wishes"
    }
    
    var bindWishMakerViewModelToController : (() -> ()) = {}
    private let defaults = UserDefaults.standard
    
    private(set) var wishes: Wishes! {
        didSet {
            bindWishMakerViewModelToController()
            defaults.set(wishes.array.map{ $0.text }, forKey: Constants.wishesKey)
        }
    }
    
    init() {
        updateData()
    }
    
    func addWish(text: String) {
        wishes.array.append(Wish(text))
    }
    
    func updateData() {
        let data = defaults.array(forKey: Constants.wishesKey) as? [String]
        wishes = Wishes(array: data?.map { Wish($0) })
    }
}
