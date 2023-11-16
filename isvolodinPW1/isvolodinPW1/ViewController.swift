//
//  ViewController.swift
//  isvolodinPW1
//
//  Created by Илья Володин on 13.11.2023.
//

import UIKit

// MARK: - View controller for story board
class ViewController: UIViewController {
    // MARK:  All views
    @IBOutlet weak var hatView: UIView!
    @IBOutlet weak var visorView: UIView!
    @IBOutlet var skinView: [UIView]!
    @IBOutlet var eyesView: [UIView]!
    @IBOutlet weak var mouthView: UIView!
    @IBOutlet var sweaterView: [UIView]!
    @IBOutlet var pantsView: [UIView]!
    @IBOutlet var shoesView: [UIView]!
    
    // MARK: Buttons
    @IBOutlet weak var blinkButton: UIButton!
    @IBOutlet weak var changeOutfitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // MARK: Change color of an array of views
    private func changeColor(part: [UIView], color: UIColor? = UIColor.random()) {
        for i in part { i.backgroundColor = color }
    }
    
    // MARK: Change color for all of views in storyboard
    private func changeOutfitColor() {
        changeColor(part: [ hatView ])
        changeColor(part: [ visorView ], color: hatView.backgroundColor?.darker())
        changeColor(part: sweaterView)
        changeColor(part: pantsView)
        changeColor(part: shoesView)
    }
    
    // MARK: Change outfit (colors of clouthes and a shape of hat)
    private func changeOutfit() {
        changeOutfitColor()
        hatView.changeShape()
    }
    
    // MARK: Change the shapes of a certain eye to closed ones
    private func blink(eye: Int) {
        eyesView[eye].changeShape(radius: UIView.closedEyeShape)
    }
     
    // MARK: Change the shapes of a certain eye to open ones
    @objc func unblink(eye: Int) {
        eyesView[eye].changeShape(radius: UIView.openEyeShape)
    }
   
    // MARK: Handler of "change outfit" button
    @IBAction func changeOutfitButtonWasPressed(_ sender: Any) {
        changeOutfitButton.isEnabled = false
        let changeColorAnimationTime = 3.5
        
        UIView.animate(withDuration: changeColorAnimationTime, animations: {
            self.changeOutfit()
        },
                       completion: { [weak self] _ in
            self?.changeOutfitButton.isEnabled = true
        }
        )
    }
    
    // MARK: Handler of "blink" button
    @IBAction func blinkButtonWasPressed(_ sender: Any) {
        let eye = Int.random(in: 0...1)
        let blinkAnimationTime = 0.5
        
        UIView.animate(withDuration: blinkAnimationTime, animations: {
            self.blink(eye: eye)
        },
                       completion: { [weak self] _ in
            self?.unblink(eye: eye)
        }
        )
        
    }
}


// MARK: - Extecsion of the view, that contains default shapes for eyes and the function, changing them
extension UIView {
    static let closedEyeShape = 9.0
    static let openEyeShape = 0.0
    
    // MARK: change shape of view
    func changeShape(radius: CGFloat = .random(in: 0...25)) {
        self.layer.cornerRadius = radius
    }
}

// MARK: - Extension of the color
extension UIColor {
    // MARK: return color, set using RGB
    static private func UIColorFromRGB(_ rgbValue: Int) -> UIColor! {
        return UIColor(
            red: CGFloat((Float((rgbValue & 0xff0000) >> 16)) / 255.0),
            green: CGFloat((Float((rgbValue & 0x00ff00) >> 8)) / 255.0),
            blue: CGFloat((Float((rgbValue & 0x0000ff) >> 0)) / 255.0),
            alpha: 1.0)
    }
    
    // MARK: return a random hex value
    static private func randomHex() -> Int {
        let hex = arc4random_uniform(UInt32(UInt16.max))
        print(String(format: "%06X", hex))
        return Int(hex)
    }
    
    // MARK: get random color
    static func random() -> UIColor {
        UIColorFromRGB(randomHex())
    }
    
    // MARK: default parameter for adjust method
    static private let defaultPercentage = 30.0
    
    // MARK: make color lighter by percent
    func lighter(by percentage: CGFloat = defaultPercentage) -> UIColor? {
        return self.adjust(by: abs(percentage) )
    }
    
    // MARK: make color darker by percent
    func darker(by percentage: CGFloat = defaultPercentage) -> UIColor? {
        return self.adjust(by: -1 * abs(percentage) )
    }
    
    // MARK: change color brightness
    private func adjust(by percentage: CGFloat = defaultPercentage) -> UIColor? {
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
