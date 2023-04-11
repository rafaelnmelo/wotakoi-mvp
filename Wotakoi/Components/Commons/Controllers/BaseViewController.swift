//
//  BaseViewController.swift
//  Wotakoi
//
//  Created by Rafael Melo on 11/04/23.
//  Copyright © 2023 Rafael Nunes. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK: Loading
    
    func showActivityIndicator() {
        ActivityIndicatorView.showActivityIndicatorView(onView: self.navigationController?.view ?? self.view)
    }
    
    func removeActivityIndicator() {
        ActivityIndicatorView.removeActivityIndicatorView()
    }
    
    //MARK: Alert
    
    private func getAlert(title: String, message: String) -> UIAlertController {
        return UIAlertController(title: title,
                                 message: message,
                                 preferredStyle: .alert)
    }
    
    func showAlert(title: String, message: String) {
        let alert = getAlert(title: title, message: message)
        alert.addAction(UIAlertAction(title: "Ok",
                                      style: .default,
                                      handler: { (alert) in }))
        self.present(alert, animated: true, completion: nil)
    }
}
