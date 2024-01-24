//
//  ProductDetailsViewController.swift
//  LBCTechnicalTest
//
//  Created by Ahmed on 24/01/2024.
//
import UIKit

class ProductDetailsViewController: UIViewController {
    
    var product: Product?
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.red
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    var viewModel: ProductDetailsViewModel
    
    init(viewModel: ProductDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateUI()
        setupNavigationBar()
    }
    private func setupNavigationBar() {
        navigationItem.title = "Details"
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .default
        view.backgroundColor = UIColor.white
        UINavigationBar.appearance().barTintColor = UIColor.white
        // Create a back button without title
        let backbutton = UIButton(type: .custom)
        backbutton.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        backbutton.setImage(UIImage(named: "back"), for: .normal)
        backbutton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)
    }
    
    @objc private func backButtonTapped() {
        viewModel.poptoRootVC()
    }
    private func setupUI() {
        view.backgroundColor = .white
        
        // Add ScrollView
        view.addSubview(scrollView)
        scrollView.backgroundColor = .white
        // Add subviews to scrollView
        scrollView.addSubview(productImageView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(priceLabel)
        scrollView.addSubview(descriptionLabel)
        scrollView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: true)
        
        
        productImageView.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: nil, right: nil, paddingTop:paddingSize, paddingLeft: paddingSize, paddingBottom: 0, paddingRight: 0, width: imageFullSize, height: imageFullSize, enableInsets: true)
        //urgentImage.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft:0, paddingBottom: 0, paddingRight: 0, width: smallImageSize, height: smallImageSize, enableInsets: true)
        titleLabel.anchor(top: productImageView.bottomAnchor, left: productImageView.leftAnchor, bottom: nil, right: productImageView.rightAnchor, paddingTop: marginSize, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: true)
        //itemDateLabel.anchor(top: itemNameLabel.bottomAnchor, left: itemImage.leftAnchor, bottom: nil, right: nil, paddingTop: marginSize, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: true)
        priceLabel.anchor(top: titleLabel.bottomAnchor, left: nil, bottom: nil, right:  productImageView.rightAnchor, paddingTop: marginSize, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: true)
        descriptionLabel.anchor(top: priceLabel.bottomAnchor, left: productImageView.leftAnchor, bottom: scrollView.bottomAnchor, right:  productImageView.rightAnchor, paddingTop: marginSize, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: true)
    }
    
    private func updateUI() {
        guard let product = product else { return }
        
        if let url =  product.images_url?["thumb"]{
            productImageView.loadImageUsingCache(withUrl: url)
        }
        titleLabel.text = product.title
        priceLabel.text = "\(String(format: "%g", product.price)) €"
        descriptionLabel.text = product.description
    }
}
