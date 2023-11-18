//
//  WirittenWishCellClass.swift
//  isvolodinPW3
//
//  Created by Илья Володин on 18.11.2023.
//

import Foundation
import UIKit

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
    
    // MARK: - Lifecycle
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
        wrap.pin.right()
        
        wrap.addSubview(wishLabel)
        
        wishLabel.pin.vertically(WrapConstants.yOffset/2)
        wishLabel.pin.horizontally(WrapConstants.xOffset/2)
    }
}
