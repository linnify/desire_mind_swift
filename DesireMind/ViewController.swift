//
//  ViewController.swift
//  DesireMind
//
//  Created by Vlad Rusu on 26/04/2020.
//  Copyright © 2020 Linnify. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        WishesService().list { (response) in
            switch response {
            case .success(let wishes):
                print(wishes)
            case .error(let error):
                print(error)
            }
        }
        
    }


}

