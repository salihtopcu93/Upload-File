//
//  signUpViewController.swift
//  forgotPassword
//
//  Created by raSe on 9.11.2017.
//  Copyright © 2017 raSe. All rights reserved.
//

import UIKit
import Firebase

class signUpViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passField: UITextField!
    
    @IBOutlet weak var pass2Field: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func signUp(_ sender: Any) {
        
        if(passField.text != pass2Field.text)
        {
            print("şifre tekrarı uyuşmuyor")
        }
        
      else if(!(emailField.text?.isEmpty)! && !(passField.text?.isEmpty)! && !(pass2Field.text?.isEmpty)!)
        {
            Auth.auth().createUser(withEmail: emailField.text!, password: passField.text!, completion: { (user, error) in
                
                if(error != nil)
                {
                    print(error!.localizedDescription)
                }
                else
                {
                    print("--------TEBRİKLER---------")
                }
                self.emailField.text = ""
                self.passField.text = ""
                self.pass2Field.text = ""
            })
            


        }
    
    }
    
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
