//
//  ViewController.swift
//  isvolodinPW3
//
//  Created by Илья Володин on 17.11.2023.
//

import Foundation
import UIKit

final class WishMakerViewController: UIViewController {
    private enum ColorsStrings {
        static let redStr = "red"
        static let greenStr = "green"
        static let blueStr = "blue"
        static let alphaStr = "alpha"
        static let formatStringForValues = "%.2f"
        static let redValueString = "Red: " + formatStringForValues
        static let greenValueString = "Green: " + formatStringForValues
        static let blueValueString = "Blue: " + formatStringForValues
    }
    
    private enum Constants {
        static let startBackgroundColor = UIColor.random()
        
        static let appTitle = "HW2 colors"
        static let description = "Here is my hw 2"
        static let foldButtonName = "..."
        static let addWishButtonName = "Add wish"
        
        static let min: Double = 0
        static let max: Int = 1
        
        static let foldingTime: TimeInterval = 1
        static let foldButtonOffset: CGFloat = 237
        static let slidersFoldingOffset: CGFloat = 337
    }
    
    private enum Markup {
        static let titleFontSize: CGFloat = 40
        static let titleLeadingLabelConstant: CGFloat = 20
        static let titleTopConstant: CGFloat = 20
        
        static let descriptionFontSize: CGFloat = 23
        static let descriptionLeadingLabelConstant: CGFloat = 20
        static let descriptionTopConstant: CGFloat = 30
        
        static let foldButtonRightConstant: CGFloat = -10
        static let foldButtonBottomConstant: CGFloat = -5
        
        static let addWishButtonSidesConstant: CGFloat = 19
        static let addWishButtonBottomConstant: CGFloat = -30
        
        static let cornerRadius: CGFloat = 10
        
        static let slidersConstant: CGFloat = -10
        static let bottomSliderConstant: CGFloat = -20
    }
    
    private var WishMakerViewModel: WishMakerViewModel!
    
    private var titleView: UILabel = UILabel()
    private var descriptionView: UILabel = UILabel()
    private var sliders: [CustomSlider]?
    private var foldButton: UIButton?
    private var addWishButton: UIButton = UIButton(type: .system)
    private var folded: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = Constants.startBackgroundColor
        
        configureTitle()
        configureDescription()
        configureAddWishButton()
        configureSliders()
        configurefoldButton()
    }
    
    private func configureTitle() {
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.text = Constants.appTitle
        titleView.font = UIFont.boldSystemFont(ofSize: Markup.titleFontSize)
        titleView.textColor = UIColor.random()
        titleView.layer.masksToBounds = true
        titleView.layer.cornerRadius = Markup.cornerRadius
        
        view.addSubview(titleView)
        NSLayoutConstraint.activate([
            titleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Markup.descriptionLeadingLabelConstant),
            titleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Markup.descriptionTopConstant)
        ])
    }
    
    private func configureDescription() {
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        descriptionView.text = Constants.description
        descriptionView.font = UIFont.systemFont(ofSize: Markup.descriptionFontSize)
        descriptionView.layer.masksToBounds = true
        descriptionView.layer.cornerRadius = Markup.cornerRadius
        descriptionView.backgroundColor = titleView.backgroundColor?.darker()
        
        view.addSubview(descriptionView)
        NSLayoutConstraint.activate([
            descriptionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Markup.titleLeadingLabelConstant),
            descriptionView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: Markup.titleTopConstant)
        ])
    }
    
    private func configureSliders() {
        let colors = Dictionary(uniqueKeysWithValues: zip([ColorsStrings.redStr, ColorsStrings.greenStr, ColorsStrings.blueStr, ColorsStrings.alphaStr], (self.view.backgroundColor?.cgColor.components)!))
        
        let redSlider = CustomSlider(title: String(format: ColorsStrings.redValueString, colors[ColorsStrings.redStr]!), min: Constants.min, max: Constants.max, color: colors[ColorsStrings.redStr]!)
        redSlider.translatesAutoresizingMaskIntoConstraints = false
        redSlider.backgroundColor = view.backgroundColor
        
        let greenSlider = CustomSlider(title: String(format: ColorsStrings.greenValueString, colors[ColorsStrings.greenStr]!), min: Constants.min, max: Constants.max, color: colors[ColorsStrings.greenStr]!)
        greenSlider.translatesAutoresizingMaskIntoConstraints = false
        greenSlider.backgroundColor = view.backgroundColor
        
        let blueSlider = CustomSlider(title: String(format: ColorsStrings.blueValueString, colors[ColorsStrings.blueStr]!), min: Constants.min, max: Constants.max, color: colors[ColorsStrings.blueStr]!)
        blueSlider.translatesAutoresizingMaskIntoConstraints = false
        blueSlider.backgroundColor = view.backgroundColor
        
        sliders = [redSlider, greenSlider, blueSlider]
        
        view.addSubview(blueSlider)
        NSLayoutConstraint.activate([
            blueSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            blueSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blueSlider.bottomAnchor.constraint(equalTo: addWishButton.topAnchor, constant: Markup.bottomSliderConstant)
        ])
        
        blueSlider.valueChanged = { [weak self] value in
            let newColor = UIColor(
                red: colors[ColorsStrings.redStr]!, green: colors[ColorsStrings.greenStr]!, blue: value, alpha: colors[ColorsStrings.alphaStr]!
            )
            self?.view.backgroundColor = newColor
            for slider in self!.sliders! { slider.backgroundColor = newColor }
            self?.titleView.backgroundColor = newColor.darker()
            blueSlider.titleView.text = String(format: ColorsStrings.blueValueString, value)
            self?.descriptionView.backgroundColor = newColor.darker()
            self?.addWishButton.backgroundColor = newColor.darker()
            self?.foldButton?.backgroundColor = newColor.darker()
            self?.addWishButton.setTitleColor(newColor, for: .normal)
        }

        view.addSubview(greenSlider)
        NSLayoutConstraint.activate([
            greenSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            greenSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            greenSlider.bottomAnchor.constraint(equalTo: blueSlider.topAnchor, constant: Markup.slidersConstant)
        ])
        
        greenSlider.valueChanged = { [weak self] value in
            let newColor = UIColor(
                red: colors[ColorsStrings.redStr]!, green: value, blue: colors[ColorsStrings.blueStr]!, alpha: colors[ColorsStrings.alphaStr]!
            )
            self?.view.backgroundColor = newColor
            for slider in self!.sliders! { slider.backgroundColor = newColor }
            greenSlider.titleView.text = String(format: ColorsStrings.greenValueString, value)
            self?.titleView.backgroundColor = newColor.darker()
            self?.descriptionView.backgroundColor = newColor.darker()
            self?.addWishButton.backgroundColor = newColor.darker()
            self?.foldButton?.backgroundColor = newColor.darker()
            self?.addWishButton.setTitleColor(newColor, for: .normal)
        }
        
        view.addSubview(redSlider)
        NSLayoutConstraint.activate([
            redSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            redSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            redSlider.bottomAnchor.constraint(equalTo: greenSlider.topAnchor, constant: Markup.slidersConstant)
        ])
        
        redSlider.valueChanged = { [weak self] value in
            let newColor = UIColor(
                red: value, green: colors[ColorsStrings.greenStr]!, blue: colors[ColorsStrings.blueStr]!, alpha: colors[ColorsStrings.alphaStr]!
            )
            self?.view.backgroundColor = newColor
            for slider in self!.sliders! { slider.backgroundColor = newColor }
            redSlider.titleView.text = String(format: ColorsStrings.redValueString, value)
            self?.titleView.backgroundColor = newColor.darker()
            self?.descriptionView.backgroundColor = newColor.darker()
            self?.addWishButton.backgroundColor = newColor.darker()
            self?.foldButton?.backgroundColor = newColor.darker()
            self?.addWishButton.setTitleColor(newColor, for: .normal)
        }
        
    }
    
    private func configurefoldButton() {
        foldButton = {
            let control = UIButton()
            control.backgroundColor = self.view.backgroundColor?.darker()
            control.setTitle(Constants.foldButtonName, for: .normal)
            control.clipsToBounds = false
            control.translatesAutoresizingMaskIntoConstraints = false
            control.layer.cornerRadius = Markup.cornerRadius
            control.addTarget(self, action: #selector(foldButtonAction), for: .touchUpInside)
            control.tag = 1
            return control
        }()
        
        view.addSubview(foldButton!)
        foldButton!.rightAnchor.constraint(equalTo: view.rightAnchor, constant: Markup.foldButtonRightConstant).isActive = true
        foldButton!.bottomAnchor.constraint(equalTo: self.sliders!.first!.topAnchor, constant: Markup.foldButtonBottomConstant).isActive = true
    }

    @objc
    private func foldButtonAction(_ sender: UIButton) {
        let slidersOffset = self.folded ? -Constants.slidersFoldingOffset: Constants.slidersFoldingOffset
        
        UIView.animate(withDuration: Constants.foldingTime, animations: {
            for slider in self.sliders! {
                slider.frame.origin.y += slidersOffset
            }
            self.foldButton!.frame.origin.y += self.folded ? -Constants.foldButtonOffset: Constants.foldButtonOffset
        }, completion: nil)
        
        self.folded = !self.folded
    }
    
    private func configureAddWishButton() {
        view.addSubview(addWishButton)
        addWishButton.clipsToBounds = true
        addWishButton.translatesAutoresizingMaskIntoConstraints = false
        addWishButton.setTitle(Constants.addWishButtonName, for: .normal)
        addWishButton.layer.cornerRadius = Markup.cornerRadius
        addWishButton.backgroundColor = view.backgroundColor?.darker()
        addWishButton.setTitleColor(view.backgroundColor, for: .normal)
        addWishButton.addTarget(self, action: #selector(addWishButtonAction), for: .touchUpInside)
        
        addWishButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Markup.addWishButtonSidesConstant).isActive = true
        addWishButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Markup.addWishButtonSidesConstant).isActive = true
        addWishButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Markup.addWishButtonBottomConstant).isActive = true
    }
    
    @objc
    private func addWishButtonAction(_ sender: UIButton) {
        present(WishStoringViewController(), animated: true)
    }
}

final class CustomSlider: UIView {
    private enum ConstantStrings {
        static let error = "init(coder:) has not been implemented"
    }
    
    private enum Markup {
        static let titleTopConstant: CGFloat = 10
        static let titlelLeadingConstant: CGFloat = 10
        
        static let sliderBottomConstant: CGFloat = -10
        static let sliderLeadingConstant: CGFloat = 20
    }
    
    var valueChanged: ((Double) -> Void)?
    var slider = UISlider()
    var titleView = UILabel()
    
    init(title: String, min: Double, max: Int, color: CGFloat) {
        super.init(frame: .zero)
        titleView.text = title
        slider.minimumValue = Float(min)
        slider.maximumValue = Float(max)
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        slider.value = Float(color)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(ConstantStrings.error)
    }
    
    private func configureUI() {
        translatesAutoresizingMaskIntoConstraints = false
        
        for view in [slider, titleView] {
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            titleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleView.topAnchor.constraint(equalTo: topAnchor, constant: Markup.titleTopConstant),
            titleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Markup.titlelLeadingConstant),
            
            slider.centerXAnchor.constraint(equalTo: centerXAnchor),
            slider.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            slider.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Markup.sliderBottomConstant),
            slider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Markup.sliderLeadingConstant)
        ])
    }
    
    @objc
    private func sliderValueChanged() {
        valueChanged?(Double(slider.value))
    }
    
}

extension UIColor {
    private enum Constants {
        static let defaultPercentage = 30.0
        static let multiplier = 0xff0000
        static let divider: Float = 255.0
        static let alpha: CGFloat = 1
    }
    
    // MARK: return color, set using RGB
    static private func UIColorFromRGB(_ rgbValue: Int) -> UIColor! {
        return UIColor(
            red: CGFloat((Float((rgbValue & Constants.multiplier) >> 16)) / Constants.divider),
            green: CGFloat((Float((rgbValue & (Constants.multiplier >> 8)) >> 8)) / Constants.divider),
            blue: CGFloat((Float((rgbValue & (Constants.multiplier >> 16)) >> 0)) / Constants.divider),
            alpha: Constants.alpha)
    }
    
    // MARK: return a random hex value
    static private func randomHex() -> Int {
        Int(arc4random_uniform(UInt32(UInt16.max)))
    }
    
    // MARK: get random color
    static func random() -> UIColor {
        UIColorFromRGB(randomHex())
    }
            
   // MARK: default parameter for adjust method
    
    // MARK: make color lighter by percent
    func lighter(by percentage: CGFloat = Constants.defaultPercentage) -> UIColor? {
        return self.adjust(by: abs(percentage) )
    }
    
    // MARK: make color darker by percent
    func darker(by percentage: CGFloat = Constants.defaultPercentage) -> UIColor? {
        return self.adjust(by: -1 * abs(percentage) )
    }
    
    // MARK: change color brightness
    private func adjust(by percentage: CGFloat = Constants.defaultPercentage) -> UIColor? {
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
 
