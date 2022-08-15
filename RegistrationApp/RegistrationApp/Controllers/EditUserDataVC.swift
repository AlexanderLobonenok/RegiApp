//
//  EditUserDataVC.swift
//  RegistrationApp
//
//  Created by Alexander Lobonenok on 15.08.22.
//

import UIKit

final class EditUserDataVC: UIViewController {
    
        @IBOutlet private weak var editedEmailTF: UITextField!
        
        @IBOutlet private weak var editedUserNameTF: UITextField!
        
        @IBOutlet private weak var editedPasswordTF: UITextField!
        
        @IBAction private func goEdit() {
            navigationController?.popViewController(animated: true)
            delegate?.update(meaningOne: editedEmailTF.text!, meaningTwo: editedUserNameTF.text!, meaningThree: editedPasswordTF.text!)
            
            dismiss(animated: true, completion: nil)
        }
    
        var email = ""
        var name = ""
        var password = ""


        var delegate: EditDelegate?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            editedEmailTF.text = email
            editedUserNameTF.text = name
            editedPasswordTF.text = password
        

        // Do any additional setup after loading the view.
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
