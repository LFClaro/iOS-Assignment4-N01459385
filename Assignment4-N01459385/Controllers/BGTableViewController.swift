//
//  BGTableViewController.swift
//  Assignment4-N01459385
//
//  Created by Luiz Fernando Reis on 2021-12-08.
//

import UIKit

class BGTableViewController: UITableViewController {
    lazy var results = [Info]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg-pattern.jpeg")!)

        ServiceController.shared.getAllBoardgames { resultsFromAPI in
            DispatchQueue.main.async {
                self.results = resultsFromAPI
                self.tableView.reloadData()
            }
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = results[indexPath.row]
        let year = "\(item.year_published?.description ?? "Unknown")"
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = year

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedIndex = tableView.indexPath(for: sender as! UITableViewCell)
        let bgDetailsVC = segue.destination as? BGDetailsViewController
        let item = results[selectedIndex!.row]
        bgDetailsVC!.result = item
    }
}
