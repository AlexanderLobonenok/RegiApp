//
//  SignInVC.swift
//  RegistrationApp
//
//  Created by Alexander Lobonenok on 1.08.22.
//

import UIKit

class SignInVC: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var errorEmailLbl: UILabel!
    @IBOutlet weak var errorPasswordLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isLoggedUser()
        hideKeyboardWhenTappedAround()
    }
    
    @IBAction func signInAction() {
        
        if let email = emailTF.text,
           let pass = passwordTF.text,
           let userModel = UserDefaultsService.getUserModel(),
           email == userModel.email,
           pass == userModel.pass {
            performSegue(withIdentifier: "goToMain", sender: nil)
        }
    }
    
    private func isLoggedUser() {
        if let _ = UserDefaultsService.getUserModel() {
            performSegue(withIdentifier: "goToMain", sender: nil)
        }
        
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
