//
//  UIViewController+HUD.swift
//  TaiwanRate
//
//  Created by liao yuhao on 2018/11/5.
//  Copyright © 2018 liao yuhao. All rights reserved.
//

import Foundation
import MBProgressHUD

extension UIViewController {
    func showHud(_ message: String) {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = message
        hud.isUserInteractionEnabled = false
    }
    
    func hideHUD() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
}
