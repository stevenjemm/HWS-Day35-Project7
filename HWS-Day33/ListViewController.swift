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
    var filteredPetitions = [Petition]()
    var infoType: PetitionType!
    
    enum AlertType {
        case error, credit, filter
    }
    
    init(infoType: PetitionType) {
        self.infoType = infoType
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Our list of news"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(showCredit))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(showFilter))
        
        configureTableView()
        
        let urlString: String
        
        switch infoType {
        case .mostRecent:
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        case .popular:
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        case .none:
            urlString = ""
        }
         
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
        showError()
        
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            filteredPetitions = petitions
            tableView.reloadData()
    }
    }
    
    @objc func showCredit() {
        showAlert(title: "Give credit", message: "This data comes from the We The People API of the Whitehouse.", type: .credit)
    }
    
    func showError() {
        showAlert(title: "Loading Error", message: "There was a problem loading the feed. Please check your connection and try again.", type: .error)
    }
    
    @objc func showFilter() {
        showAlert(title: "Filter", message: "Please select a term to use to filter your list", type: .filter)
    }
    
    func showAlert(title: String, message: String, type: AlertType) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        var textField: UITextField? = UITextField()
        switch type {
        case .filter:
            ac.addTextField { (alertTextField) in
                textField = alertTextField
                alertTextField.placeholder = "Enter your search term"
            }
            
            ac.addAction(.init(title: "Reset", style: .default, handler: { _ in
                self.filteredPetitions = self.petitions
                self.tableView.reloadData()
            }))
        case .error, .credit:
            break
        }
        
        ac.addAction(.init(title: "OK", style: .default, handler: { action in
            if let textField = textField, let text = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !text.isEmpty {
                self.filteredPetitions = self.petitions.filter({ return $0.title.lowercased().contains(text.lowercased())})
                print("Petitions: ", self.filteredPetitions)
                self.tableView.reloadData()
            }
        }))
            
        present(ac, animated: true, completion: nil)
    }
    
    fileprivate func configureTableView() {
        tableView.backgroundColor = .systemBackground
//        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableFooterView = UIView()
    }
    
    // MARK: - TableView Delegate & Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPetitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        cell.accessoryType = .disclosureIndicator
        
        let petition = filteredPetitions[indexPath.row]
        cell.detailTextLabel?.text = petition.body
        cell.textLabel?.text = petition.title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = filteredPetitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

import SwiftUI

struct ListPreview: PreviewProvider {
    static var previews: some View {
        ListContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ListContainerView: UIViewControllerRepresentable {
        func makeUIViewController(context: UIViewControllerRepresentableContext<ListPreview.ListContainerView>) -> UIViewController {
            let navController = UINavigationController(rootViewController: ListViewController(infoType: .mostRecent))
            return navController
        }
        
        func updateUIViewController(_ uiViewController: ListPreview.ListContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ListPreview.ListContainerView>) {
            
        }
    }
}
