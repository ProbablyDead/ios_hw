//
//  WishStoringViewController.swift
//  isvolodinPW3
//
//  Created by Илья Володин on 17.11.2023.
//

import Foundation
import PinLayout
import UIKit

final class WishStoringViewController: UIViewController {
    
    // MARK: - Constants
    private enum Constants {
        static let startBackgroundColor: UIColor = UIColor.white
        static let tableCornerRadius: CGFloat = 10
        static let lineCornerRadius: CGFloat = 4
    }
    
    private enum Markup {
        static let lineWidth: CGFloat = 30
        static let lineY: CGFloat = 10
        static let lineHeight: CGFloat = 8
        static let tableOffset: CGFloat = 10
    }
    
    // MARK: - Fields
    private let table: UITableView = UITableView(frame: .zero)
    private let wishArray: [String] = ["tmp wish"]
    
    // MARK: - Methods
    override func viewDidLoad() {
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = Constants.startBackgroundColor
        configureLine()
        configureTable()
    }
    
    private func configureLine() {
        let rect = CGRect(x: view.center.x - Markup.lineWidth/2, y: Markup.lineY, width: Markup.lineWidth, height: Markup.lineHeight)
        let line = UIView(frame: rect)
        line.backgroundColor = view.backgroundColor?.darker()
        line.layer.cornerRadius = Constants.lineCornerRadius
        
        view.addSubview(line)
    }
    
    private func configureTable() {
        view.addSubview(table)
        table.backgroundColor = .red
        table.dataSource = self
        table.separatorStyle = .none
        table.layer.cornerRadius = Constants.tableCornerRadius
        
        table.pin.left(Markup.tableOffset).right(Markup.tableOffset).top(2*Markup.lineY + Markup.lineHeight).bottom(Markup.tableOffset)
        
        table.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseID)
    }
    
}

// MARK: - UITableViewDataSource
extension WishStoringViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        wishArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WrittenWishCell.reuseID, for: indexPath)
        guard let wishCell = cell as? WrittenWishCell else { return cell }
       
        wishCell.configure(with: wishArray[indexPath.row])
        
        return wishCell
    }
}
