//
//  AlertControllerUtility.swift
//  PATHAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 1.01.2022.
//

import UIKit

final class AlertControllerUtility {
    static func present(
        title: String,
        message: String,
        buttonTitle: String = "OK",
        handler: ((UIAlertAction) -> Void)? = nil,
        delegate: UIViewController
    ) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        alertController.addAction(
            UIAlertAction(title: buttonTitle, style: .default, handler: handler)
        )
        
        delegate.present(alertController, animated: true, completion: nil)
    }
}
