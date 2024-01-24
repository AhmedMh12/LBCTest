//
//  ListCategoriesViewController.swift
//  LBCTechnicalTest
//
//  Created by Ahmed on 21/01/2024.
//

import UIKit

protocol ListCategoriesVCDelegate: AnyObject {
    func didReturnWith(value: ProductCategory)
}

class ListCategoriesViewController: UITableViewController {
    var viewModel: ListCategoriesViewModel
    var categoriesDataSource: [CategoryTableCellViewModel] = []
    weak var delegate: ListCategoriesVCDelegate?
    
    let activityIndicator: UIActivityIndicatorView = {
            let indicator = UIActivityIndicatorView(style: .large)
            indicator.translatesAutoresizingMaskIntoConstraints = false
            indicator.hidesWhenStopped = true
            return indicator
        }()
    init(viewModel: ListCategoriesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Les catégories"
        self.setupTableView()
        bindViewModel()
        setNavigationBackButton()
    }
    
    func setNavigationBackButton() {
        let backbutton = UIButton(type: .custom)
        backbutton.setTitle("Annuler", for: .normal)
        backbutton.setTitleColor(backbutton.tintColor, for: .normal)
        backbutton.addTarget(self, action: #selector(buttonDismis), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)
    }
    
    @objc func buttonDismis(sender : UIButton!){
        self.navigationController?.popViewController(animated: false)
    }
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
        
        viewModel.categories.bind { [weak self] categories in
            guard let self = self,
                  let categories = categories else {
                return
            }
            self.categoriesDataSource = categories
            self.reloadTableView()
        }
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = .clear
        
        self.registerCells()
    }
    func registerCells() {
        tableView.register(CategoryTableCellView.self, forCellReuseIdentifier: "CategoryCell")

    }
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryTableCellView
        cell.configure(with: categoriesDataSource[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectCategory(productCategory: categoriesDataSource[indexPath.row].category)
    }
    func selectCategory(productCategory: ProductCategory) {
            delegate?.didReturnWith(value: productCategory)
        viewModel.poptoRootVC()
    }
}

