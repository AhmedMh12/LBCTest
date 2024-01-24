//
//  ProductTableViewCell.swift
//  LBCTechnicalTest
//
//  Created by Ahmed on 15/01/2024.
//

import Foundation
import UIKit

class ProductTableViewCell : UITableViewCell {
    // MARK: - PROPERTIES
    
    private var viewModel: ProductTableCellViewModel!


    override func prepareForReuse() {
        super.prepareForReuse()
        self.viewModel = nil
        urgentImage.isHidden = true
        itemImage.image = UIImage(named:"image-not-found")
        categoryLabel.text = nil
        categoryLabel.backgroundColor = .white
        itemPriceLabel.text = nil
        itemNameLabel.text = nil
        itemDateLabel.text = nil
        itemDescriptionLabel.text = nil
        self.backgroundColor = .white
    }

    private let itemPriceLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 12)
        lbl.textAlignment = .right
        lbl.numberOfLines = 0
        return lbl
    }()

    private let itemNameLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 10)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()

    let categoryLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .darkGray
        lbl.font = UIFont.boldSystemFont(ofSize: 10)
        lbl.textAlignment = .left
        lbl.numberOfLines = 1
        lbl.layer.cornerRadius = 3
        lbl.clipsToBounds = true
        return lbl
    }()

    let itemDateLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .darkGray
        lbl.font = UIFont.systemFont(ofSize: 8)
        lbl.textAlignment = .right
        lbl.numberOfLines = 0
        return lbl
    }()
    private let itemDescriptionLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 8)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()

    private let itemImage : UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 10
        return imgView
    }()

    private let urgentImage : UIImageView = {
        let imgView = UIImageView(image: UIImage(named:"urgent"))
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        return imgView
    }()

    // MARK: - INIT
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        self.layer.cornerRadius = 5
        self.backgroundColor = .white
        addSubview(itemImage)
        addSubview(urgentImage)
        addSubview(itemNameLabel)
        addSubview(itemDateLabel)
        addSubview(itemPriceLabel)
        addSubview(itemDescriptionLabel)
        addSubview(categoryLabel)

        itemImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop:paddingSize, paddingLeft: paddingSize, paddingBottom: 0, paddingRight: 0, width: imageSize, height: imageSize, enableInsets: true)
        urgentImage.anchor(top: topAnchor, left: leftAnchor, bottom: itemPriceLabel.topAnchor, right: nil, paddingTop:2, paddingLeft:0, paddingBottom: 0, paddingRight: 0, width: smallImageSize, height: smallImageSize, enableInsets: true)
        itemNameLabel.anchor(top: topAnchor, left: itemImage.rightAnchor, bottom: nil, right: itemDateLabel.leftAnchor, paddingTop: marginSize, paddingLeft: paddingSize, paddingBottom: 0, paddingRight: marginSize, width: 0, height: 0, enableInsets: true)
        categoryLabel.anchor(top: itemNameLabel.bottomAnchor, left: itemImage.rightAnchor, bottom: nil, right: itemPriceLabel.leftAnchor, paddingTop: paddingSize, paddingLeft: paddingSize, paddingBottom: 0, paddingRight: -paddingSize, width: 0, height: 0, enableInsets: true)
        itemPriceLabel.anchor(top: nil, left: categoryLabel.rightAnchor, bottom: itemImage.bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: paddingSize, paddingBottom: 0, paddingRight: paddingSize, width: 0, height: 0, enableInsets: true)
        itemDateLabel.anchor(top: categoryLabel.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: sizeWithRatio(10), paddingLeft: paddingSize, paddingBottom: 0, paddingRight: paddingSize, width: sizeWithRatio(40), height: 0, enableInsets: true)
        itemDescriptionLabel.anchor(top: itemPriceLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: marginSize, paddingLeft: paddingSize, paddingBottom: marginSize, paddingRight: paddingSize, width: 0 , height: 0, enableInsets: true)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // Injection de dépendance
    func configure(with viewModel: ProductTableCellViewModel) {
        self.viewModel = viewModel
        setView()
    }
    func setView() {
        if let url =  viewModel.images_url?["small"]{
            itemImage.loadImageUsingCache(withUrl: url)
        }
        urgentImage.isHidden = !viewModel.is_urgent
        itemNameLabel.text = viewModel.title
        itemPriceLabel.text = "\(String(format: "%g", viewModel.price)) €"
        categoryLabel.text = "Vehicle"
    }

}
