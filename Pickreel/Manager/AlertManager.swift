import UIKit

class AlertManager {
    static func deleteAccountAlert(on vc: UIViewController, completion: @escaping ((UIAlertAction) -> Void)) {
        let title = "Удаление аккаунта"
        let message = "Вы уверены что хотите удалить аккаунт? Его уже нельзя будет восстановить"
        let deleteAction = AlertAction(title: "Удалить", style: .destructive, handler: completion)
        let cancelAction = AlertAction(title: "Назад", style: .cancel, handler: nil)
        
        showAlert(on: vc, title: title, message: message, actions: [cancelAction, deleteAction])
    }
}

// MARK: - Alert Constructor
private extension AlertManager {
    struct AlertAction {
        let title: String
        let style: UIAlertAction.Style
        let handler: ((UIAlertAction) -> Void)?
    }
    
    static func showAlert(on vc: UIViewController, title: String, message: String? = nil, actions: [AlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        actions.forEach { action in
            alert.addAction(UIAlertAction(title: action.title, style: action.style, handler: action.handler))
        }
        
        DispatchQueue.main.async {
            vc.present(alert, animated: true)
        }
    }
}
