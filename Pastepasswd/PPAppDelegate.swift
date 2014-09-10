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
import Crashlytics

//Extensions Array
extension Array {
    func combine(separator: String) -> String{
        var str : String = ""
        for (idx, item) in enumerate(self) {
            str += "\(item)"
            if idx < self.count-1 {
                str += separator
            }
        }
        return str
    }
}

//Extensions UIColor
extension UIColor {
    class func pastepasswdTextColor() -> UIColor {
        return UIColor(red: 124.0 / 255.0, green: 137.0 / 255.0, blue: 147.0 / 255.0, alpha: 1.0)
    }
    class func pastepasswdItemColor() -> UIColor {
        return UIColor(red: 250.0 / 255.0, green: 250.0 / 255.0, blue: 250.0 / 255.0, alpha: 1.0)
    }
    class func pastepasswdMainColor() -> UIColor {
        return UIColor(hue: 0.52, saturation: 0.65, brightness: 0.79, alpha: 1.00)
    }
    class func pastepasswdNumbersColor() -> UIColor {
        return UIColor(red:76.0 / 255.0, green:90.0 / 255.0, blue:100.0 / 255.0 ,alpha:1.0)
    }
}

//Extensions UIFont
extension UIFont {
    class func mediumFontWithSize(size:CGFloat) -> UIFont {
        return UIFont(name: "Avenir-Medium", size: size)
    }
}

@UIApplicationMain
class PPAppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        Crashlytics.startWithAPIKey("88300c2a59d5352c19153a01c6671ab3339d663e")
        var passwordViewController:PPPasswordViewController = PPPasswordViewController()
        var navigationController:UINavigationController = UINavigationController(rootViewController: passwordViewController);
        
        self.window!.rootViewController = navigationController;
        self.window!.backgroundColor = UIColor.whiteColor()
        self.window!.makeKeyAndVisible()
        
        var navigationBar:UINavigationBar = UINavigationBar.appearance()
        navigationBar.barTintColor = UIColor(hue: 0.52, saturation: 0.65, brightness: 0.79, alpha: 1.00)
        navigationBar.tintColor = UIColor(white: 1.0, alpha: 0.5)
        navigationBar.titleTextAttributes  = [NSForegroundColorAttributeName:UIColor.whiteColor(),
            NSFontAttributeName:UIFont(name: "Avenir-Heavy", size: 20.0)]
    
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {}

    func applicationDidEnterBackground(application: UIApplication) {}

    func applicationWillEnterForeground(application: UIApplication) {}

    func applicationDidBecomeActive(application: UIApplication) {}

    func applicationWillTerminate(application: UIApplication) {}
}

