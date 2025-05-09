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
        viewModel.getProducts()
    }
    
    // MARK: Collection View Setup
    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: ProductCell.identifier)
        collectionView.collectionViewLayout = createLayout(isGrid: false)
    }
    
    // MARK: ViewModel Binding
    private func bindViewModel() {
        viewModel.$products
            .receive(on: DispatchQueue.main)
            .sink { [weak self] products in
                self?.collectionView.reloadData()
            }
            .store(in: &cancellables)
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

// MARK: - CollectionView DataSource + Delegate

extension ProductsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.identifier, for: indexPath) as? ProductCell else {
            return UICollectionViewCell()
        }
        let product = viewModel.products[indexPath.item]
        return cell
    }
}
