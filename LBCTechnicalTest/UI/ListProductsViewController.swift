//
//  ListProductsViewController.swift
//  LBCTechnicalTest
//
//  Created by Ahmed on 15/01/2024.
//

import Foundation
import UIKit

class ListProductsViewController : UIViewController,UITableViewDelegate, UITableViewDataSource,ListCategoriesVCDelegate {
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    var ProductsFilters: [Product] = []
    let searchController = UISearchController()
    var productsTableView = UITableView()
    //ViewModel
    var viewModel: ListProductsViewModel
    
    //Variables:
    var productsDataSource: [ProductTableCellViewModel] = []
    var items: [String] = []
    init(viewModel: ListProductsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ListProductsViewModel(coordinator: MainCoordinator(navigationController: self.navigationController))
        self.navigationBarView()
        self.tableUser()
        self.setupTableView()
        viewModel.getData()
        bindViewModel()
    }
    
    
    
    func tableUser() {
        view.addSubview(productsTableView)
        productsTableView.translatesAutoresizingMaskIntoConstraints = false
        productsTableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        productsTableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        productsTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        productsTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        productsTableView.register(ProductTableViewCell.self, forCellReuseIdentifier: "productCell")
        
    }
    
    func navigationBarView(){
        navigationItem.title = "Le boncoin"
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .default
        view.backgroundColor = UIColor.white
        UINavigationBar.appearance().barTintColor = UIColor.white
        
        let filterBtn = UIButton(type: .custom)
        filterBtn.setImage(UIImage(named: "filter"), for: .normal)
        filterBtn.setTitleColor(filterBtn.tintColor, for: .normal)
        filterBtn.addTarget(self, action: #selector(openfilterView), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: filterBtn)
    }
    
    @objc func openfilterView(sender : UIButton!){
        let listCategoriesVC = ListCategoriesViewController(viewModel: ListCategoriesViewModel(coordinator: self.viewModel.coordinator!))
        listCategoriesVC.delegate = self
        viewModel.openFilterVC(listCategoriesVC: listCategoriesVC)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.getData()
    }
    
    func bindViewModel() {
        viewModel.isLoadingData.bind { [weak self] isLoading in
            guard let isLoading = isLoading else {
                return
            }
            DispatchQueue.main.async {
                if isLoading {
                    self?.activityIndicator.startAnimating()
                } else {
                    self?.activityIndicator.stopAnimating()
                }
            }
        }
        
        viewModel.products.bind { [weak self] products in
            guard let self = self,
                  let products = products else {
                return
            }
            self.productsDataSource = products
            self.reloadTableView()
        }
    }
    
    
    
    func setupTableView() {
        self.productsTableView.delegate = self
        self.productsTableView.dataSource = self
        self.productsTableView.backgroundColor = .clear
        self.registerCells()
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.productsTableView.reloadData()
        }
    }
    
    func registerCells() {
        self.productsTableView.register(ProductTableViewCell.self, forCellReuseIdentifier: "productCell")
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:"productCell" , for: indexPath) as? ProductTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: productsDataSource[indexPath.row])
        cell.categoryLabel.text = viewModel.retriveCategoryName(withId: productsDataSource[indexPath.row].category_id)
        cell.itemDateLabel.text = viewModel.convertDateString(productsDataSource[indexPath.row].creation_date, fromFormat: dateFormat, toFormat: convertedDateFormat)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = productsDataSource[indexPath.row]
        viewModel.openProductDetails(product: item.product)
    }
    
    func didReturnWith(value: ProductCategory) {
        self.viewModel.dataSource =  self.viewModel.getProductsWithCategory(withId: value.id)
        self.viewModel.mapProductData()
    }
}
