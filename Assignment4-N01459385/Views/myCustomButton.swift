//
//  myCustomButton.swift
//  Assignment4-N01459385
//
//  Created by Luiz Fernando Reis on 2021-12-14.
//

import UIKit

class myCustomButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
       // layer
        super.init(coder: coder)
        layer.cornerRadius = layer.frame.height / 3
    }

}
