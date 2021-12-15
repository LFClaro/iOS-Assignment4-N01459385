//
//  myCollectionViewController.swift
//  Assignment4-N01459385
//
//  Created by Luiz Fernando Reis on 2021-12-14.
//

import UIKit
import CoreData

class myCollectionViewController: UICollectionViewController {
    lazy var results = [Info]()
    
    var allBoardGames = [BoardGame]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg-pattern.jpeg")!)
        allBoardGames = CoreDataService.shared.getAllBoardGames()
        collectionView.reloadData()
        
//        (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.estimatedItemSize = CGSize(width: 50, height: 50)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return allBoardGames.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! myCustomCollectionViewCell
        let item = allBoardGames[indexPath.row]
        
        ServiceController.shared.getBoardgamesById(id: item.id ?? "") {
            resultsFromAPI in
            DispatchQueue.main.async {
                if !resultsFromAPI.isEmpty {
                    self.results = resultsFromAPI
                    ServiceController.shared.getImage(url: self.results[0].images.small ?? "") {
                        result in
                        switch result{
                        case .success(let img) :
                            DispatchQueue.main.async {
                                cell.itemImg?.image = img
                            }
                        case .failure(let error) :
                            print (error)
                        }
                    }
                } else {
                    self.zeroError()
                }
            }
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let details = UIAlertAction.init(title: "Details", style: .default) { (action) in
            self.performSegue(withIdentifier: "showFromCollection", sender: self.allBoardGames[indexPath.row].id)
        }
        
        let delete = UIAlertAction.init(title: "Delete", style: .destructive) { (action) in
            CoreDataService.shared.deleteBoardGame(toDelete: self.allBoardGames[indexPath.row])
            self.allBoardGames = CoreDataService.shared.getAllBoardGames()
            collectionView.reloadData()
        }
        
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
        
        let alert = UIAlertController.init(title: "Board Game Options", message: "Please select an option", preferredStyle: .alert)
        
        alert.addAction(details)
        alert.addAction(delete)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        ServiceController.shared.getBoardgamesById(id: sender as! String) {
            resultsFromAPI in
            DispatchQueue.main.async {
                if !resultsFromAPI.isEmpty {
                    self.results = resultsFromAPI
                    let bgDetailsVC = segue.destination as? BGDetailsViewController
                    let item = self.results[0]
                    bgDetailsVC!.result = item
                } else {
                    self.zeroError()
                }
            }
        }
    }
    
    func zeroError(){
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        let alert = UIAlertController(title: "Error!", message: "0 results found", preferredStyle: .alert)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }
    */

}
