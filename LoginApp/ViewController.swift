//
//  ViewController.swift
//  LoginApp
//
//  Created by Pixel on 04/12/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        
        // Do any additional setup after loading the view.
    }

}

