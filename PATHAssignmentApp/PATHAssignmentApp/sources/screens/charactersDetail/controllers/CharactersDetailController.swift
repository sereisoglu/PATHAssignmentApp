//
//  CharactersDetailController.swift
//  PATHAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 1.01.2022.
//

import UIKit

final class CharactersDetailController: UITableViewController {
    private let viewModel: CharactersDetailViewModel
    
    init(viewModel: CharactersDetailViewModel) {
        self.viewModel = viewModel
        
        super.init(style: .grouped)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Detail"
        navigationItem.largeTitleDisplayMode = .never
        
        view.backgroundColor = Color.backgroundDefault.value
        tableView.backgroundColor = Color.backgroundDefault.value
        
        tableView.registerCell(CharactersDetailCell.self)
        tableView.registerCell(ComicsCell.self)
        
        tableView.alwaysBounceVertical = true
//        tableView.separatorStyle = .none
        
        setUpRightBarButtonItems()
        
        viewModel.delegate = self
        
        viewModel.fetchData()
    }
    
    private func setUpRightBarButtonItems() {
        navigationItem.rightBarButtonItems = [
            .init(
                image: viewModel.isFavorite ? Icon.starFill.value : Icon.star.value,
                style: .plain,
                target: self,
                action: #selector(handleFavoriteButton)
            )
        ]
    }
    
    @objc
    private func handleFavoriteButton() {
//        isFavorite.toggle()
//
//        if isFavorite {
//            CoreDataManager.shared.createNews(data: data)
//        } else {
//            CoreDataManager.shared.deleteNews(id: data.id)
//        }
        
        setUpRightBarButtonItems()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension CharactersDetailController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return viewModel.comics?.count ?? 0
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(for: indexPath) as CharactersDetailCell
            
            cell.setData(
                imageUrl: viewModel.data.thumbnail?.imageUrl,
                nameText: viewModel.data.name ?? "No name",
                descriptionText: viewModel.data.description
            )
            
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(for: indexPath) as ComicsCell
            
            if let data = viewModel.comics?[safe: indexPath.row] {
                cell.setData(
                    imageUrl: data.thumbnail?.imageUrl,
                    nameText: data.title ?? "No name",
                    descriptionText: data.description
                )
            }
            
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            guard let urlString = viewModel.comics?[safe: indexPath.row]?.url else {
                return
            }
            
            BrowserUtility.openInsideOfApp(urlString: urlString, delegate: self)
            
        default:
            return
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension CharactersDetailController: CharactersDetailViewModelDelegate {
    func getDataForCharactersDetailViewModel(error: ErrorModel?) {
        guard error == nil else {
            print(error?.message ?? "")

            AlertControllerUtility.present(
                title: error?.title ?? "API Error",
                message: error?.message ?? "An error has occurred.",
                delegate: self
            )

            tableView.reloadData()

            return
        }

//        tableView.separatorStyle = viewModelState == .data ? .singleLine : .none

        tableView.reloadData()
    }
}
