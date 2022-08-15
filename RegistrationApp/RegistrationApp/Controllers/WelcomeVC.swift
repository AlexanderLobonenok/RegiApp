//
//  WelcomeVC.swift
//  RegistrationApp
//
//  Created by Alexander Lobonenok on 10.08.22.
//

import UIKit

final class WelcomeVC: UIViewController {
    
    @IBOutlet private weak var infoLbl: UILabel!
    
    
    var userModel: UserModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction private func continueBtnAction() {
        guard let userModel = userModel else { return }
        UserDefaultsService.saveUserModel(userModel: userModel)
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func setupUI() {
        let name = userModel?.name ?? "User"
        infoLbl.text = "Hello \(name)! You have signed up successfully. Select the options bellow to stay updated with upcoming features and promotions."
    }
}
