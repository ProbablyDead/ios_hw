//
//  Meal.swift
//  hw1
//
//  Created by Илья Володин on 15.10.2023.
//

import Foundation

struct Meal {
    var name: String
    var protein: Int?
    var fats: Int?
    var carbs: Int?
    var kcal: Int
    var star: Bool = false
    
    init(name: String, protein: Int, fats: Int, carbs: Int, kcal: Int) {
        self.name = name
        self.protein = protein
        self.fats = fats
        self.carbs = carbs
        self.kcal = kcal
        self.star = false
    }
}

#if DEBUG
extension Meal {
    static let sampleData = [
        Meal(name: "burger",
             protein: 11,
             fats: 10,
             carbs: 1,
             kcal: 40),
        Meal(name: "sandwich",
             protein: 1,
             fats: 0,
             carbs: 1,
             kcal: 4),
        Meal(name: "kok",
             protein: 100,
             fats: 110,
             carbs: 911,
             kcal: 44),
    ]
}
#endif
