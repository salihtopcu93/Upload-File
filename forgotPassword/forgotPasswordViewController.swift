//
//  forgotPasswordViewController.swift
//  forgotPassword
//
//  Created by raSe on 9.11.2017.
//  Copyright © 2017 raSe. All rights reserved.
//

import UIKit
import Firebase


class forgotPasswordViewController: UIViewController {
    
    
    @IBOutlet weak var emailField: UITextField!
    

    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func reset(_ sender: Any) {
        
        if (emailField.text == nil)
        {
            print("lütfen mail adresinizi giriniz")
        }
        else
        {
            

            print( emailField.text!)
            Auth.auth().sendPasswordReset(withEmail: emailField.text!) { (error) in
                if(error != nil)
                {
                    print(error!.localizedDescription)
                }
                else
                {
                    print("--------TEBRİKLER---------")
                }
                self.emailField.text = ""
            }
        }
        
        
    }
        }
        
        
     
    
    



