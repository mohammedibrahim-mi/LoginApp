//
//  CameraViewController.swift
//  LoginApp
//
//  Created by Pixel on 15/12/20.
//

import UIKit
import Alamofire

class CameraViewController: UIViewController,UITextFieldDelegate {

    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var done: UIButton!
    let userDefault = UserDefaults()
    
    @IBOutlet weak var kycid: UITextField!
    @IBOutlet weak var frontid: UITextField!
    let image = UIImagePickerController ()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        kycid.delegate = self
        frontid.delegate = self
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        
        // Do any additional setup after loading the view.
    }

    @IBAction func but(_ sender: Any) {
         
        let alert = UIAlertController(title: "Camera Access", message: "Select your choice", preferredStyle: .actionSheet)
        
        
        let actionf = UIAlertAction(title: "Camera", style: .default) {
            
          UIAlertAction in
            
            print("camera")
            
            
            self.image.delegate = self
            
            self.image.sourceType = .camera
            
            self.image.allowsEditing = true
            
            self.present(self.image, animated: true, completion: nil)
       
        }
        
        let actions = UIAlertAction(title: "Gallery", style: .default) {
            
            UIAlertAction in
            print("Gallery")
            
            
            self.image.delegate = self
            
            self.image.sourceType = .photoLibrary
            
            self.image.allowsEditing = true
            
            self.present(self.image, animated: true, completion: nil)
            
        }

        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
        alert.addAction(actionf)
        
        alert.addAction(actions)
        
        alert.addAction(cancel)
        
        
        present(alert, animated: true, completion: nil)
               
    }
   
    
    // api funtion
        

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        kycid.resignFirstResponder()
        frontid.resignFirstResponder()
        
        return true
    }
    
    
    
    @IBAction func butDone(_ sender: Any) {
        
        
        callingApi()
        
        
    }
    
    
    func callingApi(){

        let url_Name = "http://demozab.com/criptomonedas/mobileapi/api/front_upload_id"



        
        let token_String = userDefault.value(forKey: "Tokens") as? String
        
        
        let headers : HTTPHeaders =   [.authorization("bearer \(token_String ?? "")")]


    let parameters = ["kycid" : kycid.text ,
                      "front_upload_id" : frontid.text ]

        AF.request( url_Name, method: .post, parameters: parameters,  headers: headers ).responseJSON{ (response) in


            print(response.result)


            print(response.response?.statusCode)

            if response.response?.statusCode == 200{


                let alertController = UIAlertController(title: "THANK YOU", message: "YOUR REGISTRATION IS SUCCESSFULLY DONE.", preferredStyle: .alert)

                let defaultAction = UIAlertAction(title: "OK", style: .cancel)

                alertController.addAction(defaultAction)

                self.present(alertController, animated: true, completion: nil)


            }

            else{


                print("Error ")

                let alertController = UIAlertController(title: "SOMETHING WRONG", message: "UPLOAD AGAIN.", preferredStyle: .alert)

                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)

                self.present(alertController, animated: true, completion: nil)
            }

            }

        }




}
   
extension CameraViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      
        
        var selectedImage : UIImage
        
        if let  editedImage = info[.editedImage] as! UIImage? {
            
            
           selectedImage = editedImage
            
            self.imgView.image = editedImage
            
            picker.dismiss(animated: true)
            
            
            
        }
        else if let orginalImage = info[.editedImage] as! UIImage? {
            
            selectedImage = orginalImage
             
             self.imgView.image = orginalImage
             
             picker.dismiss(animated: true)
   
        }
        
        else{
            
            print("error")
        }
 
    }
    

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        
        print("error")
        
  
    }
  
}


