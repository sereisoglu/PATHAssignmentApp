//
//  CharactersController.swift
//  PATHAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 31.12.2021.
//

import UIKit
import MarvelAPI

final class CharactersController: UITableViewController {
    enum State {
        case `default`
        case search
    }
    
    private var state: State = .default
    
    let viewModel: CharactersViewModel
    let searchResultsViewModel: CharactersSearchResultsViewModel
    
    weak var coordinator: CharactersCoordinator?
    
    private var viewModelState: InformingState {
        switch state {
        case .default:
            return viewModel.state
        case .search:
            return searchResultsViewModel.state
        }
    }
    
    private var viewModelData: PaginationModel<CharacterModel>? {
        switch state {
        case .default:
            return viewModel.data
        case .search:
            return searchResultsViewModel.data
        }
    }
    
    private var timer: Timer?
    
    private lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchBar.placeholder = "Search for characters"
        controller.obscuresBackgroundDuringPresentation = false
        controller.searchBar.delegate = self
        return controller
    }()
    
    init(
        viewModel: CharactersViewModel,
        searchResultsViewModel: CharactersSearchResultsViewModel,
        coordinator: CharactersCoordinator
    ) {
        self.viewModel = viewModel
        self.searchResultsViewModel = searchResultsViewModel
        self.coordinator = coordinator
        
        if #available(iOS 13.0, *) {
            super.init(style: .insetGrouped)
        } else {
            super.init(style: .grouped)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Characters"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        view.backgroundColor = Color.backgroundDefault.value
        tableView.backgroundColor = Color.backgroundDefault.value
        tableView.alwaysBounceVertical = true
        tableView.keyboardDismissMode = .interactive
        tableView.separatorStyle = .none
        
        tableView.registerHeader(CharactersHeaderView.self)
        tableView.registerHeader(UITableViewHeaderFooterView.self)
        tableView.registerCell(CharactersCell.self)
        tableView.registerCell(InformingCell.self)
        tableView.registerFooter(FooterCell.self)
        
        viewModel.delegate = self
        searchResultsViewModel.delegate = self
        
        viewModel.fetchData()
    }
    
    deinit {
        timer?.invalidate()
        timer = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension CharactersController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewModelState {
        case .data:
            return viewModelData?.items.count ?? 0
            
        case .emptyOrError,
             .loading:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModelState {
        case .data:
            let cell = tableView.dequeueReusableCell(for: indexPath) as CharactersCell
            
            if let item = viewModelData?.items[safe: indexPath.item] {
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
            
            cell.setState(viewModelState)
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard viewModelState == .data,
              let data = viewModelData?.items[safe: indexPath.item] else {
            return
        }
        
        coordinator?.goToDetail(data: data)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch viewModelState {
        case .data:
            return UITableView.automaticDimension
            
        case .emptyOrError,
             .loading:
            return 300
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch state {
        case .default:
            let header = tableView.dequeueReusableHeader()
            
            return header
        case .search:
            let header = tableView.dequeueReusableHeader() as CharactersHeaderView
            
            if let itemCount = viewModelData?.itemCount {
                header.setData(text: "Search (\(itemCount))")
            } else {
                header.setData(text: "Search")
            }
            
            return header
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch state {
        case .default:
            return Space.pt10.value
        case .search:
            return Space.pt10.value + FontType.title3.value.lineHeight + Space.pt10.value
        }
    }
}

// MARK: - Pagination

extension CharactersController {
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableFooter() as FooterCell
        
        footer.setData(animating: !(viewModelData?.isDonePaginating ?? true))
        
        return footer
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard viewModelState == .data,
              viewModelData?.items.isNotEmpty ?? false,
              !(viewModelData?.isDonePaginating ?? true) else {
            return .zero
        }
        
        return 200
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let count = viewModelData?.items.count ?? 0
        
        guard viewModelState == .data,
              count > 0,
              !(viewModelData?.isPaginating ?? true),
              !(viewModelData?.isDonePaginating ?? true),
              indexPath.item >= count - 1 else {
            return
        }
        
        switch state {
        case .default:
            viewModel.fetchDataForPagination()
        case .search:
            searchResultsViewModel.fetchDataForPagination()
        }
    }
}

// MARK: - CharactersViewModelDelegate

extension CharactersController: CharactersViewModelDelegate {
    func getDataForCharactersViewModel(error: ErrorModel?) {
        guard state == .default else {
            return
        }
        
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
        
        tableView.separatorStyle = viewModelState == .data ? .singleLine : .none
        
        tableView.reloadData()
    }
}

// MARK: - CharactersSearchResultsViewModelDelegate

extension CharactersController: CharactersSearchResultsViewModelDelegate {
    func getDataForCharactersSearchResultsViewModel(error: ErrorModel?) {
        guard state == .search else {
            return
        }
        
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

        tableView.separatorStyle = viewModelState == .data ? .singleLine : .none

        tableView.reloadData()
    }
}

// MARK: - UISearchBarDelegate

extension CharactersController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {
            return
        }
        
        state = .search
        
        tableView.separatorStyle = .none
        
        searchResultsViewModel.fetchData(query: text)
        
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        state = .default
        
        searchResultsViewModel.reset()
        
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(
            withTimeInterval: 0.25,
            repeats: false,
            block: { [weak self] _ in
                guard let self = self else {
                    return
                }
                
                if searchText == "" {
                    self.searchBarCancelButtonClicked(searchBar)
                } else {
                    self.searchBarSearchButtonClicked(searchBar)
                }
            }
        )
    }
}
