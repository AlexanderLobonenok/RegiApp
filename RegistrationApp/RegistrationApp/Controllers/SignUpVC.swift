//
//  SignUpVC.swift
//  RegistrationApp
//
//  Created by Alexander Lobonenok on 7.08.22.
//

import UIKit

final class SignUpVC: UIViewController {
    
    // MARK: - IBOutlets
    
    ///Email
    @IBOutlet private weak var emailTF: UITextField!
    @IBOutlet private weak var errorEmailLbl: UILabel!
    ///Name
    @IBOutlet private weak var nameTF: UITextField!
    ///Password
    @IBOutlet private weak var passwordTF: UITextField!
    @IBOutlet private weak var errorPasswordLbl: UILabel!
    ///Password indicator
    @IBOutlet private var passwordIndicatorViews: [UIView]!
    ///Confirm password
    @IBOutlet private weak var confirmPasswordTF: UITextField!
    @IBOutlet private weak var errorConfirmPasswordLbl: UILabel!
    ///Continue button
    @IBOutlet private weak var continueBtn: UIButton!
    ///scrollView
    @IBOutlet private weak var scrollView: UIScrollView!
    
    
    // MARK: - Properties
    
    private var isValidEmail = false { didSet { updateContinueBtnState() }}
    private var isConfPass = false { didSet { updateContinueBtnState() }}
    private var passwordStrength: PasswordStrength = .veryWeak { didSet { updateContinueBtnState() }}

    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        startKeyboardObserver()
    }
    
    // MARK: - Functions
    
    @IBAction func emailTFAction(_ sender: UITextField) {
        if let email = sender.text,
           !email.isEmpty,
           VerificationService.isValidEmail(email: email) {
            isValidEmail = true
        } else {
            isValidEmail = false
        }
        errorEmailLbl.isHidden = isValidEmail
    }

    @IBAction func passTFAction(_ sender: UITextField) {
        if let passText = sender.text,
           !passText.isEmpty {
            passwordStrength = VerificationService.isValidPassword(pass: passText)
        }
        errorPasswordLbl.isHidden = passwordStrength != .veryWeak
        setupPasswordIndicatorViews()
    }
    
    @IBAction func confPassTFAction(_ sender: UITextField) {
        if let confPassText = sender.text,
           !confPassText.isEmpty,
           let passText = passwordTF.text,
           !passText.isEmpty {
            isConfPass = VerificationService.isPassCofirm(pass1: passText,
                                                          pass2: confPassText)
        } else {
            isConfPass = false
        }
        errorConfirmPasswordLbl.isHidden = isConfPass
    }
    
    @IBAction func signInBtnAction() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func continueBtnAction() {
        if let email = emailTF.text,
           let pass = passwordTF.text {
           let userModel = UserModel(name: nameTF.text, email: email, pass: pass)
           performSegue(withIdentifier: "goToCodeVerificationVC", sender: userModel)
        }
    }
    
    
    // MARK: - Functions

    private func setupPasswordIndicatorViews() {
        passwordIndicatorViews.enumerated().forEach { index, view in
            if index <= (passwordStrength.rawValue - 1) {
                view.alpha = 1
            } else {
                view.alpha = 0.1
            }
        }
    }
    
    private func updateContinueBtnState() {
        continueBtn.isEnabled = isValidEmail && isConfPass && passwordStrength != .veryWeak
    }
    
    ///Keyboard observers
    
    private func startKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardSize =
            (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else { return }
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc private func keyboardWillHide() {
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let codeVerificationVC = segue.destination as? CodeVerificationVC,
            let userModel = sender as? UserModel {
            codeVerificationVC.userModel = userModel
            
        }
    }
}
