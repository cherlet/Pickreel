import UIKit

protocol LoginViewProtocol: AnyObject {
}

class LoginViewController: UIViewController {
    var presenter: LoginPresenterProtocol?
    
    // MARK: UI Elements
    
    private let appLabel = UILabel()
    private let emailTextField = UITextField()
    //private let loginTextField = UITextField()
    private let passwordTextField = UITextField()
    private let submitButton = UIButton()
    private let registerLabel = UILabel()
    private let policyView = UIView()
    private let secondPolicyLabel = UILabel()
    private let fourthPolicyLabel = UILabel()
    
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
}

// MARK: Module
extension LoginViewController: LoginViewProtocol {
}

// MARK: Setup
private extension LoginViewController {
    func initialize() {
        view.backgroundColor = ThemeColor.background
        setupPolicyView()
        setupButtons()
        setupTextFields()
        setupAppLabel()
        setupLayout()
    }
    
    func setupLayout() {
        let uiElements = [emailTextField, passwordTextField, submitButton, appLabel, policyView, registerLabel]
        
        uiElements.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            appLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 256),
            appLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            emailTextField.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 48),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextField.topAnchor.constraint(equalTo: appLabel.bottomAnchor, constant: 64),
            
            passwordTextField.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 48),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            
            submitButton.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor),
            submitButton.heightAnchor.constraint(equalToConstant: 48),
            submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            submitButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            
            policyView.heightAnchor.constraint(lessThanOrEqualToConstant: 100),
            policyView.widthAnchor.constraint(equalTo: view.widthAnchor),
            policyView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -64),
            policyView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            registerLabel.bottomAnchor.constraint(equalTo: policyView.topAnchor, constant: -16),
            registerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func setupTextFields() {
        emailTextField.textColor = ThemeColor.opp
        emailTextField.font = UIFont.systemFont(ofSize: 20)
        emailTextField.backgroundColor = UIColor.systemGray5
        emailTextField.layer.cornerRadius = 8
        emailTextField.placeholder = "Email"
        emailTextField.indent(size: 16)
        emailTextField.delegate = self
        
        passwordTextField.textColor = ThemeColor.opp
        passwordTextField.font = UIFont.systemFont(ofSize: 20)
        passwordTextField.backgroundColor = UIColor.systemGray5
        passwordTextField.layer.cornerRadius = 8
        passwordTextField.placeholder = "Пароль"
        passwordTextField.indent(size: 16)
        passwordTextField.isSecureTextEntry = true
        passwordTextField.delegate = self
    }
    
    func setupAppLabel() {
        appLabel.text = "Pickreel"
        appLabel.textColor = ThemeColor.general
        appLabel.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
    }
    
    func setupButtons() {
        submitButton.isEnabled = false
        submitButton.backgroundColor = ThemeColor.general?.withAlphaComponent(0.5)
        submitButton.setTitle("Войти", for: .normal)
        submitButton.titleLabel!.font = UIFont.systemFont(ofSize: 20)
        submitButton.layer.cornerRadius = 8
        submitButton.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        
        registerLabel.textColor = ThemeColor.general
        registerLabel.font = UIFont.systemFont(ofSize: 20)
        registerLabel.text = "Создать новый аккаунт"
        registerLabel.isUserInteractionEnabled = true
        let registerTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleRegister))
        registerLabel.addGestureRecognizer(registerTapGestureRecognizer)
    }
    
    func setupPolicyView() {
        let firstPolicyLabel = UILabel()
        let thirdPolicyLabel = UILabel()
        let labels = [firstPolicyLabel, secondPolicyLabel, thirdPolicyLabel, fourthPolicyLabel]
        
        firstPolicyLabel.text = "Создавая аккаунт, вы принимаете"
        secondPolicyLabel.attributedText = NSAttributedString(string: " Условия", attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
        thirdPolicyLabel.text = " и "
        fourthPolicyLabel.attributedText = NSAttributedString(string: "Политику конфиденциальности", attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
        
        labels.forEach {
            $0.textColor = ThemeColor.silent
            $0.font = UIFont.systemFont(ofSize: 16)
            $0.translatesAutoresizingMaskIntoConstraints = false
            policyView.addSubview($0)
        }
        
        secondPolicyLabel.textColor = ThemeColor.general
        fourthPolicyLabel.textColor = ThemeColor.general
        
        NSLayoutConstraint.activate([
            firstPolicyLabel.topAnchor.constraint(equalTo: policyView.topAnchor),
            firstPolicyLabel.centerXAnchor.constraint(equalTo: policyView.centerXAnchor),
            
            secondPolicyLabel.topAnchor.constraint(equalTo: firstPolicyLabel.bottomAnchor),
            secondPolicyLabel.leadingAnchor.constraint(equalTo: policyView.leadingAnchor, constant: 32),
            
            thirdPolicyLabel.topAnchor.constraint(equalTo: firstPolicyLabel.bottomAnchor),
            thirdPolicyLabel.leadingAnchor.constraint(equalTo: secondPolicyLabel.trailingAnchor),
            
            fourthPolicyLabel.topAnchor.constraint(equalTo: firstPolicyLabel.bottomAnchor),
            fourthPolicyLabel.leadingAnchor.constraint(equalTo: thirdPolicyLabel.trailingAnchor),
        ])
    }
    
    // MARK: Actions
    @objc private func handleSignIn() {
        if let email = emailTextField.text, let password = passwordTextField.text {
            presenter?.handleSignIn(email, password)
        }
    }
    
    @objc private func handleRegister() {
        presenter?.handleRegister()
    }
}

// MARK: UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let emailValid = isEmailValid(emailTextField.text ?? "")
        let passwordValid = isPasswordValid(passwordTextField.text ?? "")
        
        if emailValid && passwordValid {
            submitButton.isEnabled = true
            submitButton.backgroundColor = ThemeColor.general
        } else {
            submitButton.isEnabled = false
            submitButton.backgroundColor = ThemeColor.general?.withAlphaComponent(0.5)
        }
    }
    
    func isEmailValid(_ email: String) -> Bool {
        return email.contains("@") && !email.isEmpty
    }
    
    func isPasswordValid(_ password: String) -> Bool {
        return password.count >= 6
    }
}
