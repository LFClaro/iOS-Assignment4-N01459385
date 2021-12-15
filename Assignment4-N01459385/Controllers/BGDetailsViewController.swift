//
//  BGDetailsViewController.swift
//  Assignment4-N01459385
//
//  Created by Luiz Fernando Reis on 2021-12-08.
//

import UIKit
import FontAwesome
import CoreData

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

class BGDetailsViewController: UIViewController {
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    @IBOutlet weak var playerIcon: UILabel!
    @IBOutlet weak var minPlayers: UILabel!
    @IBOutlet weak var maxPlayers: UILabel!
    @IBOutlet weak var timeIcon: UILabel!
    @IBOutlet weak var minTime: UILabel!
    @IBOutlet weak var maxTime: UILabel!
    
    @IBOutlet weak var descLabel: UILabel!
    
    var result : Info?
    
    var boardGame : BoardGame = BoardGame()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg-pattern.jpeg")!)
        
        nameLabel.text = result?.name ?? "ERROR"
        yearLabel.text = "(\(result?.year_published?.description ?? "Unknown"))"
        
        playerIcon.font = UIFont.fontAwesome(ofSize: 20, style: .solid)
        playerIcon.text = String.fontAwesomeIcon(name: .dice)
        minPlayers.text = "\(result?.min_players?.description ?? "0")"
        maxPlayers.text = "\(result?.max_players?.description ?? "0")"
        
        timeIcon.font = UIFont.fontAwesome(ofSize: 20, style: .solid)
        timeIcon.text = String.fontAwesomeIcon(name: .clock)
        minTime.text = "\(result?.min_playtime?.description ?? "0")"
        maxTime.text = "\(result?.max_playtime?.description ?? "0")"
        
        descLabel.attributedText = result?.description.htmlToAttributedString
        
        ServiceController.shared.getImage(url: result?.images.original ?? "") {
            result in
            switch result{
            case .success(let img) :
                DispatchQueue.main.async {
                    self.bgImage.image = img
                }
            case .failure(let error) :
                print (error)
            }
        }
    }
    
    
    @IBAction func addNewBG(_ sender: Any) {
        if let boardGameId = self.result?.id {
            if (CoreDataService.shared.getAllBGContaining(str: boardGameId).isEmpty) {
                let alert = UIAlertController.init(title: "Add New Game", message: "Do you want to add this Board Game to your collection?", preferredStyle: .alert)
                
                let action = UIAlertAction.init(title: "Yes!", style: .default) { (action) in
                    if let boardGameName = self.result?.name {
                        CoreDataService.shared.insertNewBoardGame(name: boardGameName, id: boardGameId)
                        self.performSegue(withIdentifier: "showCollection", sender: self)
                    }
                }
                
                let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
                
                alert.addAction(action)
                alert.addAction(cancelAction)
                present(alert, animated: true, completion: nil)
            } else {
                existsError()
            }
        }
    }
    
    func existsError(){
        let alert = UIAlertController(title: "Error!", message: "This Board Game is already in your collection!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}
