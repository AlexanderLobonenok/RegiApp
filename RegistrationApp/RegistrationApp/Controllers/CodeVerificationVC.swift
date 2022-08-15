//
//  CodeVerificarionVC.swift
//  RegistrationApp
//
//  Created by Alexander Lobonenok on 7.08.22.
//

import UIKit

class CodeVerificationVC: UIViewController {


    @IBOutlet private weak var infoLbl: UILabel!
    @IBOutlet private weak var errorLbl: UILabel! { didSet {
        errorLbl.isHidden = true}}
    
    
    var userModel: UserModel?
    let secretCode = Int.random(in: 100000...999999)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDataAndUI()
    }
    

    @IBAction func secretCodeTFAction(_ sender: UITextField) {
        guard let code = (sender.text),
              let codeInt = Int(code),
              codeInt == secretCode else {
            let isHidden = sender.text!.count >= 6
            errorLbl.isHidden = !isHidden
            return
            
        }
        errorLbl.isHidden = true
        performSegue(withIdentifier: "goToWelcomeVC", sender: nil)
    }
    
    private func setupDataAndUI() {
        let email = userModel?.email ?? "your email"
        infoLbl.text = "Please enter code \(secretCode) from \(email)"
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? WelcomeVC
        else { return }
        vc.userModel = userModel
    }
}
