//
//  CharactersDetailController.swift
//  PATHAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 1.01.2022.
//

import UIKit
import MarvelAPI

final class CharactersDetailController: UITableViewController {
    let viewModel: CharactersDetailViewModel
    
    weak var coordinator: CharactersDetailCoordinator?
    
    init(
        viewModel: CharactersDetailViewModel,
        coordinator: CharactersDetailCoordinator
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
        
        navigationItem.title = "Detail"
        navigationItem.largeTitleDisplayMode = .never
        
        view.backgroundColor = Color.backgroundDefault.value
        tableView.backgroundColor = Color.backgroundDefault.value
        tableView.alwaysBounceVertical = true
        tableView.separatorStyle = .none
        tableView.sectionFooterHeight = 20
        tableView.sectionHeaderHeight = .zero
        
        tableView.registerCell(CharactersDetailCell.self)
        tableView.registerCell(ComicsCell.self)
        tableView.registerCell(InformingCell.self)
        
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
        switch viewModel.state {
        case .data:
            return 2
        case .emptyOrError,
             .loading:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewModel.state {
        case .data:
            switch section {
            case 0:
                return 1
            case 1:
                return viewModel.comics?.count ?? 0
            default:
                return 0
            }
        case .emptyOrError,
             .loading:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.state {
        case .data:
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
                        dateText: DateUtility.stringFormat(convertType: .monthAndDayAndYear, dateString: data.date),
                        descriptionText: data.description
                    )
                }
                
                return cell
                
            default:
                return UITableViewCell()
            }
            
        case .emptyOrError,
             .loading:
            let cell = tableView.dequeueReusableCell(for: indexPath) as InformingCell
            
            cell.setState(viewModel.state)
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard viewModel.state == .data,
              indexPath.section == 1,
              let urlString = viewModel.comics?[safe: indexPath.row]?.url else {
            return
        }
        
        BrowserUtility.openInsideOfApp(urlString: urlString, delegate: self)
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
        
        tableView.separatorStyle = viewModel.state == .data ? .singleLine : .none

        tableView.reloadData()
    }
}
