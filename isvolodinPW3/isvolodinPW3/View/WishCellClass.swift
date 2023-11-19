//
//  WirittenWishCellClass.swift
//  isvolodinPW3
//
//  Created by Илья Володин on 18.11.2023.
//

import Foundation
import UIKit
import PinLayout

// MARK: - WrittenWishCell
final class WrittenWishCell: UITableViewCell {
    static let reuseID: String = "WrittenWishCell"
    
    private enum WrapConstants {
        static let wrapColor: UIColor = .red
        static let wrapTextColor: UIColor = .white
        static let wrapRadius: CGFloat = 10
        static let xOffset: CGFloat = 10
        static let yOffset: CGFloat = 10
    }
    
    private let wishLabel: UILabel = UILabel()
    
    // MARK: Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with wish:String) {
        wishLabel.text = wish
        wishLabel.textColor = WrapConstants.wrapTextColor
    }
    
    private func configureUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        let wrap: UIView = UIView()
        addSubview(wrap)
        
        wrap.backgroundColor = WrapConstants.wrapColor
        
        wrap.pin.vertically(WrapConstants.yOffset)
        wrap.pin.horizontally(WrapConstants.xOffset)
        
        wrap.addSubview(wishLabel)
        
        wishLabel.pin.vertically()
        wishLabel.pin.horizontally()
    }
}

final class AddWishCell: UITableViewCell {
    static let reuseID: String = "AddWishCell"
    
    private enum Constants {
        static let buttonText: String = "Add"
        
        static let xOffset: CGFloat = 10
        static let yOffset: CGFloat = 10
    }
    
    private let textView: UITextView = UITextView()
    private let buttonView: UIButton = UIButton()
    private var actionWithText: ((String) -> ())?
    
    // MARK: Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with wish: String, funcForButton: @escaping ((String) -> ())) {
        textView.text = wish
        actionWithText = funcForButton
        contentView.isUserInteractionEnabled = false
        isEditing = false
    }
    
    private func configureUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        configureButtonView()
        configureTextView()
        
    }
    
    private func configureTextView() {
        addSubview(textView)
        
        textView.backgroundColor = .white
        textView.isUserInteractionEnabled = true
 
        textView.pin.left(Constants.xOffset).top(Constants.yOffset).before(of: buttonView).bottom()
    }
    
    private func configureButtonView() {
        addSubview(buttonView)
        
        buttonView.setTitle(Constants.buttonText, for: .normal)
        
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        
        buttonView.pin.right(Constants.xOffset).top(Constants.yOffset).sizeToFit()
        buttonView.backgroundColor = UIColor.red.darker()
        buttonView.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    @objc
    private func buttonAction(_ sender: UIButton) {
        if textView.hasText {
            actionWithText?(textView.text)
        }
    }
}

