//
//  LoginViewController.swift
//  LoginApp
//
//  Created by Pixel on 07/12/20.
//

import UIKit
import Alamofire
//import Firebase
//import FirebaseAuth

class LoginViewController: UIViewController,UITextFieldDelegate {

    
    @IBOutlet weak var gifView: UIImageView!
   
    @IBOutlet weak var eField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var pField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
  
    
    @IBOutlet weak var remember: UITextField!
    
    
    @IBOutlet weak var dtype: UITextField!
    
    
    @IBOutlet weak var did: UITextField!
    
    
    @IBOutlet weak var dtoken: UITextField!
    
    var userDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        remember.delegate = self
        did.delegate = self
        dtype.delegate = self
        dtoken.delegate = self
        
        
        
        emailTextField.text = "paula@mailinator.com"
        passwordTextField.text = "Admin@123"
        remember.text = "1"
        did.text = "1"
        dtype.text = "ios"
        dtoken.text = "dsfsdfdsfdsfdsfdsf"
        
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
  
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        remember.resignFirstResponder()
        did.resignFirstResponder()
        dtype.resignFirstResponder()
        dtoken.resignFirstResponder()
        return true
        
    }
    
    
    
    
    @IBAction func signUp(_ sender: Any) {
        
        
        guard let vcc = self.storyboard?.instantiateViewController(withIdentifier: "register") else { return  }
        navigationController?.pushViewController(vcc, animated: false)
        
        
    }
    
    
    //userDefaults.setValue(label.text, forKey: "token")

    @IBAction func loginAction(_ sender: Any) {

        guard (emailTextField != nil) else {
            return
        }
        
        guard (passwordTextField != nil) else {
            return
        }
        
        callingApi()
        
        
        
        
        

    
}


    func callingApi()  {
               
        
        let url_Name = "http://demozab.com/criptomonedas/mobileapi/api/login"
       
       // let headers : HTTPHeaders =   [.contentType("application/json"),.authorization("bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9kZW1vemFiLmNvbVwvbGlvd2FsbGV0XC9wdWJsaWNcL2FwaVwvbG9naW4iLCJpYXQiOjE2MDc2NzMwMjEsImV4cCI6MTYwNzY3NjYyMSwibmJmIjoxNjA3NjczMDIxLCJqdGkiOiJaS3F3SVplRnh5TFhibDdPIiwic3ViIjo1OCwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.7OxdMReXRM52naxqhA3XmI-OVhp4ZO0cPq4i34JWRgc")]
        
        
        let parameters = [

            "email" : emailTextField.text,
            "password" : passwordTextField.text,
            "remember_me" : remember.text,
            "device_type" : dtype.text,
            "device_token" : dtoken.text,
            "device_id" : did.text
            

        ]
        
        if self.emailTextField.text == "" || self.passwordTextField.text == "" || self.remember.text == "" || self.dtype.text == "" || self.dtoken.text == "" || self.did.text == "" {
        
                       //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
        
                       let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
        
                       let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                       alertController.addAction(defaultAction)
        
                       self.present(alertController, animated: true, completion: nil)
        
                   }
        else {
            
        
        AF.request( url_Name, method: .post, parameters: parameters,  headers: nil ).responseJSON {
            (response) in
           
          print(response.result)       /////////
//
//            print(response.response?.statusCode)    //////////
         
            
            //decode json
           // guard let data = response.data else {return}
           
//            let token = try JSONDecoder().decode(Login.self, from: data)
//                var tok = token.success
//
//                if response.response?.statusCode == 200  && tok == true {
         
            
            
            
            
            
            
            
            guard let data = response.data else {return}

        //    if response.response?.statusCode == 200{
            
            print(data)
            
         
            do{
            
                let token = try JSONDecoder().decode(Login.self, from: data)
            
                print(token)
                
                print(token.success) ///////////////

                if  token.success {

                    let alert = UIAlertController(title: "Login", message: token.message, preferredStyle: .alert)

                    let alertAction = UIAlertAction(title: "ok", style: .cancel){
                        UIAlertController in

                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "kycid")
                         self.navigationController?.pushViewController(vc!, animated: true)
                    }

                    alert.addAction(alertAction)

                    self.present(alert, animated: true, completion: nil)

                    //self.alert(title: "Error while connecting", message: token.message)

                    self.userDefault.setValue(token.result?.accessToken, forKey: "Tokens")

           //     print(self.userDefault.value(forKey: "Tokens"))     ////////////

                }
//
                else{
                    
                    print("dwr")
                    guard let data = response.data else {return}
                    let token = try JSONDecoder().decode(Login.self, from: data)
                    print(token)
                    self.alert(title: "ERROR", message: token.message)
                    
                    }
           
            }
   
            catch{
                self.alert(title: "ERROR", message: "SIGN IN AGAIN")
                
              
      
//
//        print(token)
        ///////////////////////////
        

            }
            
            }
//            else{
//
//                guard let data = response.data else {return}
//                do{
//
//                    let token = try JSONDecoder().decode(Login.self, from: data)
//
//                                    print(Login.self)
//
//                                    //Alert message for message from server
//
//
//                                     let alert = UIAlertController(title: "error", message: token.message, preferredStyle: .alert)
//
//                                    let alertAction = UIAlertAction(title: "ok", style: .cancel){
//                                        UIAlertController in
//
//
//
//
//                                    }
//                                     alert.addAction(alertAction)
//
//                                     self.present(alert, animated: true, completion: nil)
//            }
//
//                catch{
//                    print("error")
//                }
                
            //}
            // ////////////////////////////
            
            
            
//
//            if response.response?.statusCode == 200   {
//
//
//
//
//
//                          let vc = self.storyboard?.instantiateViewController(withIdentifier: "kycid")
//               self.navigationController?.pushViewController(vc!, animated: true)
//
//
//                guard let data = response.data else {return}
//                do{
//                let token = try JSONDecoder().decode(Login.self, from: data)
//
//                print(Login.self)
//
//
//                    let alert = UIAlertController(title: "Login", message: token.message, preferredStyle: .actionSheet)
//
//                    let alertAction = UIAlertAction(title: "ok", style: .cancel){
//                        UIAlertController in
//
//                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "kycid")
//                         self.navigationController?.pushViewController(vc!, animated: true)
//
//                    }
//                    alert.addAction(alertAction)
//
//                    self.present(alert, animated: true, completion: nil)
//
//                    //self.alert(title: "Error while connecting", message: token.message)
//
//                self.userDefault.setValue(token.result.accessToken, forKey: "Tokens")
//
//                print(self.userDefault.value(forKey: "Tokens"))
//
//                }
//                catch{
//
//                    print("Error Login")
//
//
//                }
//
//
//            }
            
           // else{
//            guard let data = response.data else {return}
//            do{
//
//
//
//
//
//                let token = try JSONDecoder().decode(Login.self, from: data)
//
//                print(Login.self)
//
//                //Alert message for message from server
//
//
//                 let alert = UIAlertController(title: "error", message: token.message, preferredStyle: .actionSheet)
//
//                let alertAction = UIAlertAction(title: "ok", style: .cancel){
//                    UIAlertController in
//
//
//
//
//                }
//                 alert.addAction(alertAction)
//
//                 self.present(alert, animated: true, completion: nil)
//                //store token using userDefault
//
//                self.userDefault.setValue(token.result.accessToken, forKey: "Tokens")
//
//                print(self.userDefault.value(forKey: "Tokens"))
//
//               // self.label.text = token.token
//
////                let vc = self.storyboard?.instantiateViewController(withIdentifier: "kycid")
////                self.navigationController?.pushViewController(vc!, animated: true)
//            }
//            catch{
//
//                print("Error Login")
//
//                let alertController = UIAlertController(title: "Error", message: "Error Login.", preferredStyle: .alert)
//
//                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//                alertController.addAction(defaultAction)
//
//                self.present(alertController, animated: true, completion: nil)
//
//            }
//            }
//                        }
//
//
//    }


//field.text = userDefaults.value(forKey: "token") as? String




        }
        

        }
    }




extension UIViewController{
    
    func alert( title : String , message : String ){
        
        let aler = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alerAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        aler.addAction(alerAction)
        present(aler, animated: true, completion: nil)
        
        
    }
    
}

