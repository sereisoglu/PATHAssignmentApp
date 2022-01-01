//
//  BrowserUtility.swift
//  PATHAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 1.01.2022.
//

import UIKit
import SafariServices

final class BrowserUtility {
    static func openInsideOfApp(urlString: String, delegate: UIViewController?) {
        guard let url = URL(string: urlString),
              let delegate = delegate else {
            return
        }
        
        let safariController = SFSafariViewController(url: url)
        delegate.present(safariController, animated: true, completion: nil)
    }
}
