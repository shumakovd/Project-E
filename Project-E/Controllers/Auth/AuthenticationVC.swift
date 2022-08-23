//
//  AuthenticationVC.swift
//  Project-E
//
//  Created by Shumakov Dmytro on 23.08.2022.
//

import UIKit


class AuthenticationVC: BasicVC {
    
    // MARK: - IBOutlets
    @IBOutlet private var nameTextField: UITextField!
    @IBOutlet private var emailTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    
    @IBOutlet private var authButton: UIButton!
    
    // MARK: - Properties
    
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Call Methods
        configureUI()
        hideKeyboardWhenTappedAround()
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        authButton.setRoundedLine()
        
        nameTextField.setBottomLine(.normal)
        emailTextField.setBottomLine(.normal)
        passwordTextField.setBottomLine(.normal)
    }
    
    private func handleRequiredData() {
        
        var auth = true
        
        if nameTextField.text?.count ?? 0 < 2 {
            auth = false
            nameTextField.textFieldError()
        } else {
            nameTextField.setBottomLine(.normal)
        }
        
        if emailTextField.isValidEmail() {
            emailTextField.setBottomLine(.normal)
        } else {
            auth = false
        }
        
        if passwordTextField.text?.count ?? 0 < 6 {
            auth = false
            passwordTextField.textFieldError()
        } else {
            passwordTextField.setBottomLine(.normal)
        }
        
        if auth {
            startIndicator()
            checkIfUserExist()
        }
        
    }
    
    private func checkIfUserExist() {
        let email = emailTextField.text ?? ""
        FirebaseManager.shared.authIfUserWithThisEmailExist(email: email, completion: { result in
            if result {
                self.authentication()
            } else {
                self.stopIndicator()
                self.emailTextField.textFieldError()
                Utils.dismissAlert(title: "Error", message: "User with this email already existed", completion: nil)
            }
        })
    }
    
    
    private func authentication() {
        var parameters: [String: Any] = [:]
        
        let name = nameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
                                
        parameters["name"] = name
        parameters["email"] = email
        parameters["teacher"] = false
        parameters["password"] = password
        
        parameters["date"] = Date().dateNowToString()
        
        FirebaseManager.shared.authWithEmail(parameters: parameters, completion: { result in
            if result {
                // save user to cache
                // stopIndicator()
                // go to next screen
            } else {
                // popup with problem
            }
        })
        
        /*
         save user to cache + USerDefaults
         */
        
        /*
         // SignUp success! go to MainStorybouard
         UserDefaults.standard.set(true, forKey: "status")
         Switcher.mainVC()
         */
    }
    
   
    // UITextField View When the Keyboard Appears
    @objc override func keyboardWillShow(notification: NSNotification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= 10  //keyboardSize.height
            }
        }
    }
          
    @objc override func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func authAction(_ sender: UIButton) {
        sender.bounce()
        handleRequiredData()
    }
    
    @IBAction func goToLoginAction(_: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func privacyAction(_: Any) {
        if let url = URL(string: AppSettings.shared.privacyPolicyURL ?? "") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func ofertaAction(_: Any) {
        if let url = URL(string: AppSettings.shared.termsOfUseURL ?? "") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func restaurantBannerAction(_ sender: UIButton) {
        sender.bounce()
    }
    
}


extension AuthenticationVC {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AuthenticationVC.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}


extension AuthenticationVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        switch textField {
        case nameTextField:
            let components =  string.components(separatedBy: CharacterSet.letters.inverted)
            let filtered = components.joined()
            
            let count = nameTextField.text?.count ?? 0
            if count > 16 {
                nameTextField.deleteBackward()
            }
                        
            return string == filtered ? true : false
            
        case emailTextField:
           
            return true
                    
        case passwordTextField:
            let count = passwordTextField.text?.count ?? 0
            if count > 16 {
                passwordTextField.deleteBackward()
            }
                        
            return true

        default:
            return false
        }
    
    }
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameTextField:
            emailTextField.becomeFirstResponder()
            return true
        case emailTextField:
            passwordTextField.becomeFirstResponder()
            return true
        case passwordTextField:
            handleRequiredData()
            return true
        default:
            return false
        }
    }
}
