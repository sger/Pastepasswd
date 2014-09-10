// PPPasswordView.swift
//
// Copyright (c) 2014 Pastepasswd (http://pastepasswd.spirosgerokostas.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit

class PPPasswordView: UIView {
    var passwordSecureTextField:UITextField?
    var normalTextContainer:UIView?
    var secureTextContainer:UIView?
    var attributedLabel:TTTAttributedLabel?
    
    var passwordLabel:UILabel?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        normalTextContainer = UIView(frame: CGRectMake(0, 0, self.frame.size.width, PPPasswordView.height()))
        normalTextContainer?.backgroundColor = UIColor.whiteColor()
        self.addSubview(normalTextContainer!)
        
        secureTextContainer = UIView(frame: CGRectMake(320, 0, self.frame.size.width, PPPasswordView.height()))
        secureTextContainer?.backgroundColor = UIColor(red: 235.0 / 255, green: 89.0 / 255, blue: 89.0 / 255, alpha: 1)
        self.addSubview(secureTextContainer!)
        
        attributedLabel = TTTAttributedLabel(frame: CGRectMake(0, 0, self.frame.size.width, PPPasswordView.height()))
        attributedLabel?.textColor = UIColor(red: 133.0 / 255, green: 155.0 / 255, blue: 172.0 / 255, alpha: 1)
        attributedLabel?.backgroundColor = UIColor.clearColor()
        attributedLabel?.numberOfLines = 0
        attributedLabel?.font = UIFont(name: "Helvetica", size: 17)
        attributedLabel?.textAlignment = NSTextAlignment.Center
        normalTextContainer?.addSubview(attributedLabel!)
        attributedLabel?.text = ""
        attributedLabel?.hidden = true
        
        passwordSecureTextField = UITextField(frame: CGRectMake(0, 0, self.frame.size.width, PPPasswordView.height()))
        passwordSecureTextField?.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        passwordSecureTextField?.backgroundColor = UIColor.clearColor()
        passwordSecureTextField?.font = UIFont(name: "Helvetica", size: 17)
        passwordSecureTextField?.textAlignment = NSTextAlignment.Center
        passwordSecureTextField?.textColor = UIColor(red: 250.0 / 255.0, green: 250.0 / 255.0, blue: 250.0 / 255.0, alpha: 1)
        passwordSecureTextField?.secureTextEntry = true
        secureTextContainer?.addSubview(passwordSecureTextField!)
        
        passwordLabel = UILabel(frame: CGRectMake(0, 0, self.frame.size.width, PPPasswordView.height()))
        passwordLabel?.textColor = UIColor(red: 133.0 / 255, green: 155.0 / 255, blue: 172.0 / 255, alpha: 1)
        passwordLabel?.backgroundColor = UIColor.clearColor()
        passwordLabel?.numberOfLines = 0
        passwordLabel?.font = UIFont(name: "Helvetica", size: 17)
        passwordLabel?.textAlignment = NSTextAlignment.Center
        normalTextContainer?.addSubview(passwordLabel!)
    }

    func slideOut() {
        UIView.animateWithDuration(0.4, delay: 0.0, options: .CurveEaseInOut | .AllowUserInteraction, animations: {
            
            self.normalTextContainer?.frame = CGRectMake(-self.bounds.size.width, 0, self.bounds.size.width, PPPasswordView.height())
            
            self.secureTextContainer?.frame = CGRectMake(0, 0, self.bounds.size.width, PPPasswordView.height())
            
            }) { finished in
                
        }
    }
    
    func slideIn() {
        UIView.animateWithDuration(0.4, delay: 0.0, options: .CurveEaseInOut | .AllowUserInteraction, animations: {
            
            self.normalTextContainer?.frame = CGRectMake(0, 0, self.bounds.size.width, PPPasswordView.height())
            
            self.secureTextContainer?.frame = CGRectMake(self.bounds.size.width, 0, self.bounds.size.width, PPPasswordView.height())
            
        }) { finished in
        
        }
    }
    
    class func height() -> CGFloat {
        var screenSize:CGSize = UIScreen.mainScreen().bounds.size
        if screenSize.height == 480 {
            return 50
        } else {
            return 54
        }
    }
}