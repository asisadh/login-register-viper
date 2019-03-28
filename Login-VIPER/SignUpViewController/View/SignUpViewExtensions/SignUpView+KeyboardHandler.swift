//
//  SignUpView+KeyboardHandler.swift
//  Login-VIPER
//
//  Created by Aashish Adhikari on 3/3/19.
//  Copyright © 2019 Aashish Adhikari. All rights reserved.
//

import UIKit

// MARK: Keyboard Handling
extension SignUpView {
    @objc func keyboardWillShow(notification: NSNotification) {
        if keyboardHeight != nil {
            return
        }
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            keyboardHeight = keyboardSize.height
            
            // so increase contentView's height by keyboard height
            UIView.animate(withDuration: 0.3, animations: {
                self.constraintContentHeight.constant += self.keyboardHeight
            })
            
            activeTextField.convert(activeTextField.frame, to: scrollView)
            
            // move if keyboard hide input field
            //            print(scrollView.frame.height)
            //            print(activeTextField.frame.origin.y)
            //            print(activeTextField.frame.size.height)
            let distanceToBottom = self.scrollView.frame.size.height - (activeTextField?.frame.origin.y)! - (activeTextField?.frame.size.height)!
            let collapseSpace = keyboardHeight - distanceToBottom
            
            if collapseSpace < 0 {
                // no collapse
                return
            }
            
            // set new offset for scroll view
            UIView.animate(withDuration: 0.3, animations: {
                // scroll to the position above keyboard 10 points
                self.scrollView.contentOffset = CGPoint(x: self.lastContentOffset.x, y: collapseSpace + 10)
            })
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.3) {
            
            guard let _ = self.keyboardHeight else { return }
            
            self.constraintContentHeight.constant -= self.keyboardHeight
            
            self.scrollView.contentOffset = self.lastContentOffset
        }
        
        keyboardHeight = nil
    }
}
