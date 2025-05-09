//
//  ProductsViewController.swift
//  ProductsList
//
//  Created by Yousuf Abdelfattah on 08/05/2025.
//

import UIKit

class ProductsViewController: BaseViewController {
    
    var viewModel: ProductsViewModel
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var isGridLayout = false
    
    private lazy var layoutToggleControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["List", "Grid"])
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(toggleLayout), for: .valueChanged)
        return control
    }()
    
    // MARK: Init with ViewModel
    init(viewModel: ProductsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "ProductsViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = layoutToggleControl
        configureCollectionView()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.viewWillAppear()
        
    }
}

// MARK: - Setup UI

extension  ProductsViewController {
    // MARK: Collection View Setup
    private func configureCollectionView() {
        collectionView.register(UINib(nibName: ProductCell.identifier, bundle: nil), forCellWithReuseIdentifier: ProductCell.identifier)
        collectionView.collectionViewLayout = createLayout(isGrid: false)
    }
    
    
    // MARK: Layout Toggle
    @objc private func toggleLayout() {
        isGridLayout = layoutToggleControl.selectedSegmentIndex == 1
        collectionView.setCollectionViewLayout(createLayout(isGrid: isGridLayout), animated: true)
    }
    
    private func createLayout(isGrid: Bool) -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let padding: CGFloat = 16
        let spacing: CGFloat = 12
        
        if isGrid {
            let columns: CGFloat = 2
            let totalSpacing = (columns - 1) * spacing + 2 * padding
            let itemWidth = (view.frame.width - totalSpacing) / columns
            layout.itemSize = CGSize(width: itemWidth, height: itemWidth + 60)
        } else {
            layout.itemSize = CGSize(width: view.frame.width - 2 * padding, height: 100)
        }
        
        layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        return layout
    }
}

// MARK: - ViewModel Binding

extension ProductsViewController {
    
    private func bindViewModel() {
        viewModel.errorMessagePublisher
            .filter { !$0.isEmpty }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                guard let self = self else { return }
                self.showError(message: error)
            }
            .store(in: &cancellables)
        
        viewModel.isLoadingPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                guard let self = self else { return }
                isLoading ? self.showLoading() : self.hideLoading()
            }
            .store(in: &cancellables)
        
        viewModel.$products
            .receive(on: DispatchQueue.main)
            .sink { [weak self] products in
                guard let self = self else { return }
                self.collectionView.reloadData()
            }
            .store(in: &cancellables)
    }
}
