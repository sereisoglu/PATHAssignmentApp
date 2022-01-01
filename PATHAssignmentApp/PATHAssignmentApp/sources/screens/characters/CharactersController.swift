//
//  CharactersController.swift
//  PATHAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 31.12.2021.
//

import UIKit

final class CharactersController: UITableViewController {
    private let viewModel: CharactersViewModel
    
    init() {
        viewModel = CharactersViewModel()
        
        super.init(style: .grouped)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Characters"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.backgroundColor = Color.backgroundDefault.value
        tableView.backgroundColor = Color.backgroundDefault.value
        
        tableView.register(CharacterCell.self, forCellReuseIdentifier: "cellId")
        
        tableView.alwaysBounceVertical = true
        tableView.keyboardDismissMode = .interactive
        
        viewModel.delegate = self
        viewModel.fetchData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CharactersController: CharactersViewModelDelegate {
    func getDataForCharactersViewModel(error: ErrorModel?) {
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension CharactersController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.characters?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! CharacterCell
        
        if let item = viewModel.characters?[indexPath.row] {
            cell.setData(imageUrl: item.imageUrl, nameText: item.name ?? "No name", descriptionText: item.description)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
