//
//  ForgotViewController.swift
//  LoginApp
//
//  Created by Pixel on 16/12/20.
//

import UIKit

class ForgotViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var forgot: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        forgot.resignFirstResponder()
        
        
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
