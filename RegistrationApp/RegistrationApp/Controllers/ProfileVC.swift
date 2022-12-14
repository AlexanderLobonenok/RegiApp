//
//  ProfileVC.swift
//  RegistrationApp
//
//  Created by Alexander Lobonenok on 11.08.22.
//

import UIKit

protocol EditDelegate {
    func update (meaningOne: String, meaningTwo:String, meaningThree: String)
}

final class ProfileVC: UIViewController, EditDelegate {
    
    func update(meaningOne: String, meaningTwo: String, meaningThree: String) {
        emailLbl.text = meaningOne
        nameLbl.text = meaningTwo
        passLbl.text = meaningThree
    }
    
    var user: UserModel?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
// MARK:- Outlet
    @IBOutlet private weak var emailLbl: UILabel!
    
    @IBOutlet private weak var nameLbl: UILabel!
    
    @IBOutlet private weak var passLbl: UILabel!
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? EditUserDataVC {
            vc.email = emailLbl.text!
            vc.name = nameLbl.text!
            vc.password = passLbl.text!
            vc.delegate = self
        }
    }
    
    @IBAction func logOutAction(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)

    }
    
    @IBAction func deleteAccountAction() {
        UserDefaultsService.cleanUserDefauls()
                navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func editUserDataBtnAction() {
           performSegue(withIdentifier: "goToEditUserDataVC", sender: nil)
    }

    
    private func setupUI() {
        
        let user = UserDefaultsService.getUserModel()
        emailLbl.text = user?.email
        nameLbl.text = user?.name
        passLbl.text = user?.pass
    }
    
}
