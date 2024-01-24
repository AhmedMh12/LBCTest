//
//  CategoryTableCellView.swift
//  LBCTechnicalTest
//
//  Created by Ahmed on 21/01/2024.
//

import UIKit

class CategoryTableCellView: UITableViewCell {
    
    private var viewModel: CategoryTableCellViewModel!
    
    let namelabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0 // Set to 0 for multiline labels
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }

    private func setupLayout() {
        contentView.addSubview(namelabel)

        NSLayoutConstraint.activate([
            namelabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            namelabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            namelabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            namelabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    func configure(with viewModel: CategoryTableCellViewModel) {
        self.viewModel = viewModel
        setView()
    }
    func setView() {
        namelabel.text = viewModel.name
    }
}

