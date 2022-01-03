//
//  FavoritesController.swift
//  PATHAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 31.12.2021.
//

import UIKit

final class FavoritesController: UITableViewController {
    let viewModel: FavoritesViewModel
    
    weak var coordinator: FavoritesCoordinator?
    
    init(
        viewModel: FavoritesViewModel,
        coordinator: FavoritesCoordinator
    ) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        
        if #available(iOS 13.0, *) {
            super.init(style: .insetGrouped)
        } else {
            super.init(style: .grouped)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.backgroundColor = Color.backgroundDefault.value
        tableView.backgroundColor = Color.backgroundDefault.value
        tableView.alwaysBounceVertical = true
        tableView.separatorStyle = .none
        
        tableView.registerCell(CharactersCell.self)
        tableView.registerCell(InformingCell.self)
        
        viewModel.delegate = self
        
        viewModel.fetchData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension FavoritesController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewModel.state {
        case .data:
            return viewModel.characters.count
            
        case .emptyOrError,
             .loading:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.state {
        case .data:
            let cell = tableView.dequeueReusableCell(for: indexPath) as CharactersCell
            
            if let item = viewModel.characters[safe: indexPath.item] {
                cell.setData(
                    imageUrl: item.imageUrl,
                    nameText: item.name,
                    descriptionText: item.description
                )
            }
            
            return cell
            
        case .emptyOrError,
             .loading:
            let cell = tableView.dequeueReusableCell(for: indexPath) as InformingCell
            
            cell.setState(viewModel.state)
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard viewModel.state == .data,
              let data = viewModel.characters[safe: indexPath.item] else {
            return
        }
        
        coordinator?.goToDetail(data: data)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch viewModel.state {
        case .data:
            return UITableView.automaticDimension
            
        case .emptyOrError,
             .loading:
            return 300
        }
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(
            style: .destructive,
            title: "Delete"
        ) { _, indexPath in
            self.viewModel.delete(index: indexPath.row)
        }
        
        return [
            deleteAction
        ]
    }
}

// MARK: - FavoritesViewModelDelegate

extension FavoritesController: FavoritesViewModelDelegate {
    func getDataForFavoritesViewModel() {
        tableView.separatorStyle = viewModel.state == .data ? .singleLine : .none
        
        tableView.reloadData()
    }
}
