//
//  RegisterViewController.swift
//  LoginApp
//
//  Created by Pixel on 07/12/20.
//

import UIKit
//import Firebase
//import FirebaseAuth
import Alamofire

class RegisterViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var efield: UITextField!
    
    @IBOutlet weak var pfield: UITextField!
   
    @IBOutlet weak var pcfield: UITextField!
    
    @IBOutlet weak var nfield: UITextField!
    
    @IBOutlet weak var idField: UITextField!

    @IBAction func login(_ sender: Any) {

    }

    override func viewDidLoad() {
        
        
        super.viewDidLoad()

        idField.text = "ios"
        efield.delegate = self
        pfield.delegate = self
        pcfield.delegate = self
        nfield.delegate = self
        idField.delegate = self
        
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        efield.resignFirstResponder()
        pfield.resignFirstResponder()
        pcfield.resignFirstResponder()
        nfield.resignFirstResponder()
        idField.resignFirstResponder()
        
        return true
        
    }
    
    
    @IBAction func signUp(_ sender: Any) {
                
        guard (efield.text != nil) else {
            return
        }
        
        guard (pfield.text != nil) else {
            return
        }
        
        guard (pcfield.text != nil) else {
            return
        }
        
        guard (nfield.text != nil) else {
            return
        }
        
        guard (idField.text != nil) else {
            return
        }

        callRegister()

    }
    
    
    func callRegister() {
        
        
        let url_Name = "http://demozab.com/criptomonedas/mobileapi/api/register"
        
        
        let parameters = [

            "email" : efield.text,
            "password" : pfield.text,
            "password_confirmation" : pcfield.text,
            "username" : nfield.text,
            "mobiletype" : idField.text,
            
        ]
        
        if self.efield.text == "" || self.pfield.text == "" || self.pcfield.text == "" || self.nfield.text == "" || self.idField.text == ""  {
        
                       //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
        
                       let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
        
                       let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                       alertController.addAction(defaultAction)
        
                       self.present(alertController, animated: true, completion: nil)
        
                   }
        else {
        
        AF.request( url_Name, method: .post, parameters: parameters,  headers: nil ).responseJSON{ (response) in
           
            
            print(response.result)
          
            print(response.response?.statusCode)
            
            
            guard let data = response.data else {return}
            if response.response?.statusCode == 200{
            do{
            
                let token = try JSONDecoder().decode(Register.self, from: data)

                if  token.success {
                    
                    let alert = UIAlertController(title: "Login", message: token.message, preferredStyle: .alert)
                    
                    let alertAction = UIAlertAction(title: "ok", style: .cancel){
                        UIAlertController in
                        
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "loginVc")
                         self.navigationController?.pushViewController(vc!, animated: true)
                        
                    }
                    alert.addAction(alertAction)
                    
                    self.present(alert, animated: true, completion: nil)
                    
                    //self.alert(title: "Error while connecting", message: token.message)
   
                }
                else{
                    
                    self.alert(title: "ERROR", message: token.message)
                    }
            }
    catch{
        self.alert(title: "ERROR", message: "SIGNIN AGAIN")
            }
            
            }
            else{

                guard let data = response.data else {return}
                do{

                    let token = try JSONDecoder().decode(Login.self, from: data)

                                    print(Login.self)

                                    //Alert message for message from server


                    self.alert(title: "ERROR", message: token.message)
            }

                catch{
                    
                    self.alert(title: "name", message: "hi")
                }
            }
    }
        }
}
    }
