import UIKit

protocol LoginViewProtocol: AnyObject {
}

class LoginViewController: UIViewController {
    var presenter: LoginPresenterProtocol?
    
    // MARK: UI Elements
    
    private let appLabel = UILabel()
    private let loginTextField = UITextField()
    private let passwordTextField = UITextField()
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
        view.backgroundColor = .white
        
        setupPolicyView()
        setupRegisterButton()
        setupTextFields()
        setupAppLabel()
        setupLayout()
    }
    
    func setupLayout() {
        let uiElements = [loginTextField, passwordTextField, appLabel, policyView, registerLabel]
        
        uiElements.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            appLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 256),
            appLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            loginTextField.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor),
            loginTextField.heightAnchor.constraint(equalToConstant: 48),
            loginTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginTextField.topAnchor.constraint(equalTo: appLabel.bottomAnchor, constant: 64),
            
            passwordTextField.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 48),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 20),
            
            policyView.heightAnchor.constraint(lessThanOrEqualToConstant: 100),
            policyView.widthAnchor.constraint(equalTo: view.widthAnchor),
            policyView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -64),
            policyView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            registerLabel.bottomAnchor.constraint(equalTo: policyView.topAnchor, constant: -16),
            registerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func setupTextFields() {
        loginTextField.textColor = ThemeColor.oppColor
        loginTextField.font = UIFont.systemFont(ofSize: 20)
        loginTextField.backgroundColor = UIColor.systemGray5
        loginTextField.layer.cornerRadius = 8
        loginTextField.placeholder = "Логин"
        loginTextField.indent(size: 16)
        
        passwordTextField.textColor = ThemeColor.oppColor
        passwordTextField.font = UIFont.systemFont(ofSize: 20)
        passwordTextField.backgroundColor = UIColor.systemGray5
        passwordTextField.layer.cornerRadius = 8
        passwordTextField.placeholder = "Пароль"
        passwordTextField.indent(size: 16)
    }
    
    func setupAppLabel() {
        appLabel.text = "Pickreel"
        appLabel.textColor = ThemeColor.generalColor
        appLabel.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
    }
    
    func setupRegisterButton() {
        registerLabel.textColor = ThemeColor.generalColor
        registerLabel.font = UIFont.systemFont(ofSize: 20)
        registerLabel.text = "Создать новый аккаунт"
        registerLabel.isUserInteractionEnabled = true
        let registerTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapRegisterButton))
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
            $0.textColor = ThemeColor.silentColor
            $0.font = UIFont.systemFont(ofSize: 16)
            $0.translatesAutoresizingMaskIntoConstraints = false
            policyView.addSubview($0)
        }
        
        secondPolicyLabel.textColor = ThemeColor.generalColor
        fourthPolicyLabel.textColor = ThemeColor.generalColor
        
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
    @objc private func didTapRegisterButton() {
        presenter?.didTapRegisterButton()
    }
}
