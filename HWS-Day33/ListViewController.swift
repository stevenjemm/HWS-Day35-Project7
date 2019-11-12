//
//  ListViewController.swift
//  HWS-Day33
//
//  Created by Steven Jemmott on 10/11/2019.
//  Copyright © 2019 Lagom Exp. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
    private let reuseIdentifier = "cellId"
    var petitions = [Petition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Our list of news"
        configureTableView()
        
        let urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
            }
        }
        
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
    }
    
    fileprivate func configureTableView() {
        tableView.backgroundColor = .systemBackground
//        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableFooterView = UIView()
    }
    
    // MARK: - TableView Delegate & Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.accessoryType = .disclosureIndicator
        
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        
        return cell
    }
}

import SwiftUI

struct ListPreview: PreviewProvider {
    static var previews: some View {
        ListContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ListContainerView: UIViewControllerRepresentable {
        func makeUIViewController(context: UIViewControllerRepresentableContext<ListPreview.ListContainerView>) -> UIViewController {
            let navController = UINavigationController(rootViewController: ListViewController())
            return navController
        }
        
        func updateUIViewController(_ uiViewController: ListPreview.ListContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ListPreview.ListContainerView>) {
            
        }
    }
}
