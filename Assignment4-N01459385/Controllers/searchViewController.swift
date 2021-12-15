//
//  searchViewController.swift
//  Assignment4-N01459385
//
//  Created by Luiz Fernando Reis on 2021-12-08.
//

import UIKit

class searchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    lazy var results = [Info]()
    
    @IBOutlet weak var searchTable: UITableView!
    @IBOutlet weak var searchEntry: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg-pattern.jpeg")!)
    }
    
    @IBAction func searchClicked(_ sender: Any) {
        if let searchInput = searchEntry.text {
            if searchInput != "" {
                ServiceController.shared.getBoardgamesByName(name: searchInput) { resultsFromAPI in
                    DispatchQueue.main.async {
                        if !resultsFromAPI.isEmpty {
                            self.results = resultsFromAPI
                            self.searchTable.reloadData()
                        } else {
                            self.zeroError()
                        }
                    }
                }
            } else {
                inputError()
            }
        } else {
            zeroError()
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        searchTable.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath)
        let item = results[indexPath.row]
        let year = "\(item.year_published?.description ?? "Unknown")"
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = year

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedIndex = searchTable.indexPath(for: sender as! UITableViewCell)
        let bgDetailsVC = segue.destination as? BGDetailsViewController
        let item = results[selectedIndex!.row]
        bgDetailsVC!.result = item
    }
    
    let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
    
    func zeroError(){
        let alert = UIAlertController(title: "Error!", message: "0 results found", preferredStyle: .alert)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    func inputError(){
        let alert = UIAlertController(title: "Error!", message: "Search text can't be blank", preferredStyle: .alert)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }

}
