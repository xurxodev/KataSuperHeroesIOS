//
//  SuperHeroesViewController.swift
//  KataSuperHeroes
//
//  Created by Pedro Vicente Gomez on 12/01/16.
//  Copyright © 2016 GoKarumi. All rights reserved.
//

import UIKit
import BothamUI
import MarvelAPIClient

class SuperHeroesViewController: KataSuperHeroesViewController, BothamTableViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyCaseView: UILabel!

    var dataSource: BothamTableViewDataSource<SuperHero, SuperHeroTableViewCell>!
    var delegate: UITableViewDelegate!

    override func viewDidLoad() {
        tableView.dataSource = dataSource
        tableView.delegate = delegate
        tableView.tableFooterView = UIView()
        tableView.accessibilityLabel = "SuperHeroesTableView"
        tableView.accessibilityIdentifier = "SuperHeroesTableView"
        configureNavigationBarBackButton()
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        MarvelAPIClient.configureCredentials(
            publicKey: "bf1f5d5f088f59478a3f68324fd1face",
            privateKey: "d3fa0b1bad53d48b8bac7b9d4a02a860d24caca0")

        let charactersAPIClient = MarvelAPIClient.charactersAPIClient
        charactersAPIClient.getAll(offset: 0, limit: 10) { response in
            print("Get characters by offset and limit:")
            let characters = response.value?.characters
            print(characters?[0].name ?? "")
        }
    }

    func showEmptyCase() {
        emptyCaseView.isHidden = false
    }

    func openSuperHeroDetailScreen(_ superHeroDetailViewController: UIViewController) {
        navigationController?.push(viewController: superHeroDetailViewController)
    }

    fileprivate func configureNavigationBarBackButton() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
    }
}
