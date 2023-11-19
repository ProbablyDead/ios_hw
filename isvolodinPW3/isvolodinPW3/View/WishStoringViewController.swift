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
        
        static let numberOfSections: Int = 2
        
        static let defaultText: String = "New wish"
    }
    
    private enum Markup {
        static let lineWidth: CGFloat = 30
        static let lineY: CGFloat = 10
        static let lineHeight: CGFloat = 8
        static let tableOffset: CGFloat = 10
        static let tableBottomOffset: CGFloat = 100
    }
    
    // MARK: - Fields
    private let table: UITableView = UITableView(frame: .zero)
    private var viewModel: WishMakerViewModel!
    private var data: [[String]]!
    
    // MARK: - Methods
    override func viewDidLoad() {
        configureViewModel()
        configureUI()
    }
    
    private func configureViewModel() {
        viewModel = WishMakerViewModel()
        viewModel.bindWishMakerViewModelToController = {
            self.updateData()
        }
        viewModel.updateData()
    }
    
    private func updateData() {
        data = [ viewModel.wishes.array.map{ $0.text }, [Constants.defaultText] ]
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
        table.translatesAutoresizingMaskIntoConstraints = false
        table.layer.cornerRadius = Constants.tableCornerRadius
        
        table.pin.left(Markup.tableOffset).right(Markup.tableOffset).top(2*Markup.lineY + Markup.lineHeight).bottom(Markup.tableBottomOffset)
        
        table.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseID)
        table.register(AddWishCell.self, forCellReuseIdentifier: AddWishCell.reuseID)
    }
    
}

// MARK: - UITableViewDataSource
extension WishStoringViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        Constants.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? data[0].count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: WrittenWishCell.reuseID, for: indexPath)
            guard let wishCell = cell as? WrittenWishCell else { return cell }
            
            wishCell.configure(with: data[indexPath.section][indexPath.row])
            
            return wishCell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: AddWishCell.reuseID, for: indexPath)
            guard let addCell = cell as? AddWishCell else { return cell }
            
            addCell.configure(with: data[indexPath.section][indexPath.row], funcForButton: addWish(text:))
            
            return addCell
        default:
            return UITableViewCell()
        }
        
    }
    
    private func addWish(text: String) {
        viewModel.addWish(text: text)
        table.reloadData()
    }
    
}

