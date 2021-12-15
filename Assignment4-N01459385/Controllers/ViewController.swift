//
//  ViewController.swift
//  Assignment4-N01459385
//
//  Created by Luiz Fernando Reis on 2021-12-08.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var top100Button: UIButton!
    @IBOutlet weak var searchByNameButton: UIButton!
    @IBOutlet weak var yourCollectionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg-pattern.jpeg")!)
    }

}

