import UIKit

protocol RegisterViewProtocol: AnyObject {
    func show()
    func hide()
}

class RegisterViewController: UIViewController {
    var presenter: RegisterPresenterProtocol?

    // MARK: UI Elements
    private let formView = UIView()
    private let dimmedView = UIView()
    private let submitButton = UIButton()
    private let cancelButton = UIButton()
    private let separatorLine = UIView()
    private let verticalSeparatorLine = UIView()
    private let emailTextField = UITextField()
    private let loginTextField = UITextField()
    private let passwordTextField = UITextField()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
}

// MARK: Module 
extension RegisterViewController: RegisterViewProtocol {
    func show() {
        UIView.animate(withDuration: 0.28) {
            self.dimmedView.alpha = 0.6
            self.formView.alpha = 1
        }
    }
    
    func hide() {
        UIView.animate(withDuration: 0.28) {
            self.dimmedView.alpha = 0
            self.formView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
            self.removeFromParent()
        }
    }
}

// MARK: Setup
private extension RegisterViewController {
    func initialize() {
        view.backgroundColor = .clear
        setupView()
        setupLayout()
        setupTextFields()
        setupButtons()
    }
    
    func setupLayout() {
        let uiElements = [emailTextField, loginTextField, passwordTextField, separatorLine, verticalSeparatorLine, submitButton, cancelButton]
        
        [dimmedView, formView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        uiElements.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            formView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            formView.widthAnchor.constraint(equalToConstant: 360),
            formView.heightAnchor.constraint(equalToConstant: 264),
            formView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            formView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            emailTextField.widthAnchor.constraint(lessThanOrEqualTo: formView.widthAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 48),
            emailTextField.leadingAnchor.constraint(equalTo: formView.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: formView.trailingAnchor, constant: -20),
            emailTextField.topAnchor.constraint(equalTo: formView.topAnchor, constant: 16),
            
            loginTextField.widthAnchor.constraint(lessThanOrEqualTo: formView.widthAnchor),
            loginTextField.heightAnchor.constraint(equalToConstant: 48),
            loginTextField.leadingAnchor.constraint(equalTo: formView.leadingAnchor, constant: 20),
            loginTextField.trailingAnchor.constraint(equalTo: formView.trailingAnchor, constant: -20),
            loginTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            
            passwordTextField.widthAnchor.constraint(lessThanOrEqualTo: formView.widthAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 48),
            passwordTextField.leadingAnchor.constraint(equalTo: formView.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: formView.trailingAnchor, constant: -20),
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 16),
            
            cancelButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            cancelButton.leadingAnchor.constraint(equalTo: formView.leadingAnchor, constant: 32),
            cancelButton.widthAnchor.constraint(equalToConstant: 100),
            cancelButton.heightAnchor.constraint(equalToConstant: 40),
            
            submitButton.centerYAnchor.constraint(equalTo: cancelButton.centerYAnchor),
            submitButton.trailingAnchor.constraint(equalTo: formView.trailingAnchor, constant: -32),
            submitButton.widthAnchor.constraint(equalToConstant: 100),
            submitButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupTextFields() {
        emailTextField.textColor = ThemeColor.oppColor
        emailTextField.font = UIFont.systemFont(ofSize: 20)
        emailTextField.backgroundColor = UIColor.systemGray5
        emailTextField.layer.cornerRadius = 8
        emailTextField.placeholder = "Email"
        emailTextField.indent(size: 16)
        
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
    
    func setupView() {
        formView.backgroundColor = ThemeColor.backgroundColor
        formView.layer.cornerRadius = 16
        formView.clipsToBounds = true
        formView.alpha = 0
        
        dimmedView.backgroundColor = .black
        dimmedView.alpha = 0
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapCancel))
        dimmedView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func setupButtons() {
        submitButton.setTitle("Создать", for: .normal)
        submitButton.setTitleColor(ThemeColor.backgroundColor, for: .normal)
        submitButton.backgroundColor = ThemeColor.generalColor
        submitButton.addTarget(self, action: #selector(didTapSubmitButton), for: .touchUpInside)
        submitButton.layer.cornerRadius = 8
        
        cancelButton.setTitle("Отмена", for: .normal)
        cancelButton.setTitleColor(ThemeColor.backgroundColor, for: .normal)
        cancelButton.backgroundColor = ThemeColor.contrastColor
        cancelButton.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
        cancelButton.layer.cornerRadius = 8
    }
    
    // MARK: Actions
    
    @objc private func didTapSubmitButton() {
        presenter?.didTapSubmitButton()
    }
    
    @objc private func didTapCancel() {
        presenter?.didTapCancel()
    }
}
