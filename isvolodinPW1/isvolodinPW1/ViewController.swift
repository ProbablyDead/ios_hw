//
//  ViewController.swift
//  isvolodinPW1
//
//  Created by Илья Володин on 13.11.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var hatView: UIView!
    @IBOutlet weak var visorView: UIView!
    @IBOutlet var skinView: [UIView]!
    @IBOutlet var eyesView: [UIView]!
    @IBOutlet weak var mouthView: UIView!
    @IBOutlet var sweaterView: [UIView]!
    @IBOutlet var pantsView: [UIView]!
    @IBOutlet var shoesView: [UIView]!
    @IBOutlet weak var blinkButton: UIButton!
    @IBOutlet weak var changeOutfitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    private func changeColor(part: [UIView], color: UIColor? = UIColor.random()) {
        for i in part { i.backgroundColor = color }
    }
    
    private func changeOutfitColor() {
        changeColor(part: [ hatView ])
        changeColor(part: [ visorView ], color: hatView.backgroundColor?.darker())
        changeColor(part: sweaterView)
        changeColor(part: pantsView)
        changeColor(part: shoesView)
    }
    
    private func changeOutfit() {
        changeOutfitColor()
        hatView.changeShape()
    }
    
    @objc func unblink(eye: Int) {
        eyesView[eye].changeShape(radius: UIView.openEyeShape)
    }
    
    private func blink(eye: Int) {
        eyesView[eye].changeShape(radius: UIView.closedEyeShape)
    }
    
    @IBAction func changeOutfitButtonWasPressed(_ sender: Any) {
        changeOutfitButton.isEnabled = false
        
        UIView.animate(withDuration: 3.49, animations: {
            self.changeOutfit()
        },
                       completion: { [weak self] _ in
            self?.changeOutfitButton.isEnabled = true
        }
        )
    }
    
    @IBAction func blinkButtonWasPressed(_ sender: Any) {
        let eye = Int.random(in: 0...1)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.blink(eye: eye)
        },
                       completion: { [weak self] _ in
            self?.unblink(eye: eye)
        }
        )
        
    }
}


extension UIView {
    static let closedEyeShape = 9.0
    static let openEyeShape = 0.0
    
    func changeShape(radius: CGFloat = .random(in: 0...25)) {
        self.layer.cornerRadius = radius
    }
}

extension UIColor {
    static func random() -> UIColor {
        UIColor(
            displayP3Red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1
        )
    }
    
    func lighter(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: abs(percentage) )
    }
    
    func darker(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: -1 * abs(percentage) )
    }
    
    private func adjust(by percentage: CGFloat = 30.0) -> UIColor? {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: min(red + percentage/100, 1.0),
                           green: min(green + percentage/100, 1.0),
                           blue: min(blue + percentage/100, 1.0),
                           alpha: alpha)
        } else {
            return nil
        }
    }
}
