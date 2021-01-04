//
//  KycViewController.swift
//  LoginApp
//
//  Created by Pixel on 07/12/20.
//

import UIKit
import Alamofire

class KycViewController: UIViewController ,UIPickerViewDelegate, UIPickerViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    //reteive token
    //field.text = userDefaults.value(forKey: "token") as? String
    var datePicker = UIDatePicker()
    let userDefault = UserDefaults.standard
    @IBOutlet weak var fName: UITextField!
    @IBOutlet weak var lName: UITextField!
    @IBOutlet weak var dob: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var country: UITextField!
    @IBOutlet weak var idType: UITextField!
    @IBOutlet weak var idNumber: UITextField!
    @IBOutlet weak var idExp: UITextField!
    @IBOutlet weak var device: UITextField!
    let proof = ["Aadhar ID","Passport","Voters ID","Drivers ID"]
  
    
    // Picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return proof.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return proof[row]
    }

    
    //outlets
    @IBOutlet weak var uipicker: UIPickerView!
   
//    @IBOutlet weak var imageView: UIImageView!
//
//    var imagePicker: UIImagePickerController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dob.delegate = self
        
        
        
        fName.delegate = self
        lName.delegate = self
        city.delegate = self
        country.delegate = self
        idType.delegate = self
        idNumber.delegate = self
        idExp.delegate = self
        device.delegate = self
        
        
        
        fName.text = "paul"
        lName.text = "la"
        city.text = "Madurai"
        country.text = "2"
        idType.text = "passport"
        idNumber.text = "243"
        idExp.text = "22-02-2021"
        device.text = "ios"
        
        

        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func doneBut(_ sender: Any) {
                      
        guard  (fName.text != nil) else {return}
        guard  (lName.text != nil) else {return}
        guard  (dob.text != nil) else {return}
        guard  (city.text != nil) else {return}
        guard  (country.text != nil) else {return}
        guard  (idType.text != nil) else {return}
        guard  (idNumber.text != nil) else {return}
        guard  (idExp.text != nil) else {return}
     
       // guard  (emailField.text != nil) else {return}
      callingApi()
  
    }
       
    func callingApi()  {

        let url_Name = "http://demozab.com/criptomonedas/mobileapi/api/updatekyc"
        //Retrieve token
        let token_String = userDefault.value(forKey: "Tokens") as? String
//        print(token_String)
        
       // let tokenString  = userDefaults.value(forKey: "token") as? String
        
     //   print(token_String)
        
    //    print("token")
        
        let headers : HTTPHeaders =   [.authorization("bearer \(token_String ?? "")")]
        
//        print(headers)
        
        let parameters = [

            "first_name" : fName.text,
            "last_name" : lName.text,
            "dob" : dob.text,
            "city" : city.text,
            "country" : country.text,
            "id_type" : idType.text,
            "id_number" : idNumber.text,
            "id_exp" : idExp.text,
            "device": device.text
        ]
        
        

        if self.fName.text == "" || self.lName.text == "" || self.dob.text == "" || self.city.text == "" || self.country.text == "" || self.idType.text == "" || self.idNumber.text == "" || self.idExp.text == ""  {
        
                       //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
                       let alertController = UIAlertController(title: "Error", message: "Please enter an Full Details.", preferredStyle: .alert)
        
                       let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                       alertController.addAction(defaultAction)
        
                       self.present(alertController, animated: true, completion: nil)
                   }
        else {
        
        AF.request( url_Name, method: .post, parameters: parameters,  headers: headers ).responseJSON{ (response) in

            print(response.result)
            print(response.response?.statusCode)
            guard let data = response.data else {return}
            
            if ((response.response?.statusCode) == 200){
                
                do{
                let token = try JSONDecoder().decode(Kyc.self, from: data)
                    if  token.success {
                        
                        let alert = UIAlertController(title: "Login", message: token.message, preferredStyle: .alert)
                        
                        let alertAction = UIAlertAction(title: "ok", style: .cancel){
                            UIAlertController in
                            
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "camera")
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
                    
                    self.alert(title: "ERROR", message: "FILL DETAILS AGAIN")
                }
            }
        }
        }
}
}

extension KycViewController : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
        self.dateCall()
    }
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        fName.resignFirstResponder()
        lName.resignFirstResponder()
        city.resignFirstResponder()
        country.resignFirstResponder()
        idType.resignFirstResponder()
        idNumber.resignFirstResponder()
        idExp.resignFirstResponder()
        device.resignFirstResponder()
        return true
        
    }
 
}

extension KycViewController{
    func dateCall(){
        
        
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(Self.dateChange(datePicker:)), for: .valueChanged )
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.viewGes(tapGesture:)))
        
        view.addGestureRecognizer(tapGesture)
        
        datePicker.preferredDatePickerStyle = .wheels
        
        dob.inputView = datePicker

     }
     
    @objc func viewGes(tapGesture :  UITapGestureRecognizer)   {

            view.endEditing(true)

        }
        
        
        @objc func dateChange(datePicker : UIDatePicker)
        {
            
            if let dates = dob.inputView as?  UIDatePicker{

                        let dateFormatter = DateFormatter()
                        dateFormatter.dateStyle = .medium
//            let dateformat = DateFormatter()
//
//            dateformat.dateFormat = ""
            dob.text = dateFormatter.string(from: datePicker.date)
            
            view.endEditing(true)

        }
        
//        @objc func dateHandler(dates : UIDatePicker){
//        print(dates.date)
        
    }

}
