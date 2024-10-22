//
// CharacterListViewController.swift


import UIKit
import Core

class CharacterListViewController: UITableViewController, InstantiableType {
    
    // MARK: - Properties
    var viewModel: CharacterListViewModelType!
    
    // MARK: - View cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        print("enter into VC")
    }
    
}
