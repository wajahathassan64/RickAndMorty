//
// CharacterListViewController.swift


import UIKit
import Core
import UIToolKit

class CharacterListViewController: UITableViewController, InstantiableType {
    
    // MARK: - Properties
    var viewModel: CharacterListViewModelType!
    
    private struct Constants {
        static let title = "Characters"
    }
    
    // MARK: - View cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindViews()
        viewModel.onViewAppear()
    }
    
}

private extension CharacterListViewController {
    func bindViews() {
        viewModel.reloadCallback = { [weak self] in self?.tableView.reloadData() }
    }
}

private extension CharacterListViewController {
    
    func setupViews() {
        setupNavigationBar()
        setupTableView()
    }
    
    func setupNavigationBar() {
        title = Constants.title
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CharacterTableViewCell.reuseIdentifier)
        tableView.register(CharacterTableHeaderView.self, forHeaderFooterViewReuseIdentifier: CharacterTableHeaderView.reuseIdentifier)
    }
    
}

// MARK: - Table view data source & delegate
extension CharacterListViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = viewModel.cellViewModelForRow(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellViewModel.reuseIdentifier)
        cell?.configure(with: cellViewModel)
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel.willDisplayCell(for: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerViewModel = viewModel.headerViewModel(for: section)
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerViewModel.reuseIdentifier)
        header?.configure(with: headerViewModel)
        return header
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectedRow(at: indexPath)
    }
}
