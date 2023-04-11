//
//  ActivityIndicatorView.swift
//  Wotakoi
//
//  Created by Rafael Melo on 11/04/23.
//  Copyright © 2023 Rafael Nunes. All rights reserved.
//

import UIKit

class ActivityIndicatorView {
    
    static var vSpinner : UIView?
    
    class func showActivityIndicatorView(onView : UIView) {
        vSpinner?.removeFromSuperview()
        vSpinner = nil
        let spinnerView = UIView.init(frame: UIScreen.main.bounds)
        spinnerView.backgroundColor = UIColor.clear
        let blackView = UIView.init(frame: UIScreen.main.bounds)
        blackView.alpha = 0.3
        blackView.backgroundColor = .black
        spinnerView.addSubview(blackView)
        let ai = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.medium)
        ai.color = .blue
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
            vSpinner = spinnerView
        }
    }
    
    class func removeActivityIndicatorView() {
       DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}
