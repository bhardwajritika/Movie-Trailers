//
//  SearchViewController.swift
//  Netflix-Clone
//
//  Created by Tarun Sharma on 09/01/26.
//

import UIKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always

    }
 

}
