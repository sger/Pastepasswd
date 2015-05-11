// PPAppDelegate.swift
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

class PPPastepasswdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        
        var title:UILabel = UILabel(frame: CGRectMake(0.0, 0.0, 320.0, 24.0))
        title.accessibilityLabel = "About";
        title.autoresizingMask = UIViewAutoresizing.FlexibleWidth;
        title.backgroundColor = UIColor.clearColor()
        title.font = UIFont.mediumFontWithSize(18.0)
        title.textColor = UIColor.whiteColor()
        title.text = "About";
        title.layer.shouldRasterize = true
        title.clipsToBounds = false
        title.sizeToFit()
        
        self.navigationItem.titleView = title;
        
        var backButton:UIButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        backButton.frame = CGRectMake(0, 0, 13.0, 22.0);
        backButton.setBackgroundImage(UIImage(named: "back-view"), forState: UIControlState.Normal)
        backButton.setBackgroundImage(UIImage(named: "back-view"), forState: UIControlState.Highlighted)
        backButton.addTarget(self, action: "close:", forControlEvents: UIControlEvents.TouchDown)
        
        var backBarButtonItem:UIBarButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = backBarButtonItem
        
        var infoDictionary:NSDictionary = NSBundle.mainBundle().infoDictionary!
        var shortVersion:String = infoDictionary.objectForKey("CFBundleShortVersionString") as! String
        var build:String = infoDictionary.objectForKey("CFBundleVersion") as! String
        
        var version:UILabel = UILabel(frame: CGRectMake(10.0, 80.0, self.view.frame.size.width - 20.0, 65.0))
        version.accessibilityLabel = "Version " + shortVersion + "(" + build + ")"
        version.autoresizingMask = UIViewAutoresizing.FlexibleWidth;
        version.backgroundColor = UIColor.clearColor()
        version.font = UIFont.mediumFontWithSize(18.0)
        version.textColor = UIColor.pastepasswdMainColor()
        version.text = "Version " + shortVersion + "(" + build + ")"
        version.layer.shouldRasterize = true
        version.clipsToBounds = false
        version.textAlignment = NSTextAlignment.Center
        self.view.addSubview(version)

    }
    
    func close(sender:UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
}
