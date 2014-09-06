// PPPasswordViewController.swift
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

class PPPasswordViewController: UIViewController {
    
    var passwordTextField:UITextField?
    var passwordView:PPPasswordView?
    var passwordLength:UIProgressView?
    var lengthSlider:UISlider?
    var digitsSlider:UISlider?
    var symbolSlider:UISlider?
    var clipboardSwitch:UISwitch?
    var switchAmbiguous:UISwitch?
    var switchAllowRepeat:UISwitch?
    var passwordMode:UISwitch?
    var letters:UISegmentedControl?
    var typeChar:UISegmentedControl?
    
    var lengthLabel:TTTAttributedLabel?
    var lengthValueLabel:TTTAttributedLabel?
    var digitsLabel:TTTAttributedLabel?
    var digitsValueLabel:TTTAttributedLabel?
    var symbolLabel:TTTAttributedLabel?
    var symbolValueLabel:TTTAttributedLabel?
    var clipboardLabel:TTTAttributedLabel?
    var avoidAmbiguousLabel:TTTAttributedLabel?
    var allowCharsRepeatLabel:TTTAttributedLabel?
    var secureLabel:TTTAttributedLabel?
    
    var ambiguous:Bool?
    var allowRepeat:Bool?
    var clipboardMode:Bool?
    var length:Float?
    var digitsValue:Float?
    var symbolValue:Float?
    var maxChars:Float = 30
    var mode:String?
    var typeLetterValue:Int?
    var typeCharValue:Int?
    
    // MARK: UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        ambiguous = false
        allowRepeat = true
        clipboardMode = true
        typeLetterValue = 1
        typeCharValue = 1
        
        for parent in self.navigationController!.navigationBar.subviews {
            for childView in parent.subviews {
                if(childView is UIImageView) {
                    childView.removeFromSuperview()
                }
            }
        }
        
        passwordView = PPPasswordView(frame: CGRectMake(0, 64, self.view.frame.size.width, 61.0))
        self.view.addSubview(passwordView!)
        
        var progressValue:Float = 4.0 / maxChars
        
        passwordLength = UIProgressView(progressViewStyle: UIProgressViewStyle.Default)
        passwordLength?.frame = CGRectMake(0, passwordView!.frame.origin.y + PPPasswordView.height(), self.view.frame.size.width, 1.0);
        passwordLength?.tintColor = UIColor.redColor()
        passwordLength?.transform = CGAffineTransformMakeScale(1.0, 1.0)
        passwordLength?.setProgress(progressValue, animated: true)
        passwordLength?.trackTintColor = UIColor.pastepasswdTextColor()
        self.view.addSubview(passwordLength!)
        
        let totalHeight:CGFloat = self.view.frame.size.height - 64.0 + PPPasswordView.height() + 2.0
        var itemHeight:CGFloat = round(totalHeight / 7.0)
        
        var size:CGSize = UIScreen.mainScreen().bounds.size
        
        if size.height == 480 {
            itemHeight -= 15.0
        } else {
            itemHeight -= 16.0
        }
        
        var view1:UIView = UIView(frame: CGRectMake(0.0, passwordLength!.frame.origin.y + passwordLength!.frame.size.height, self.view.frame.size.width, itemHeight))
        view1.backgroundColor = UIColor.pastepasswdItemColor()
        self.view.addSubview(view1)
        
        var view2:UIView = UIView(frame: CGRectMake(0.0, view1.frame.origin.y + itemHeight, self.view.frame.size.width, itemHeight))
        view2.backgroundColor = UIColor.clearColor()
        self.view.addSubview(view2)
        
        var view3:UIView = UIView(frame: CGRectMake(0.0, view2.frame.origin.y + itemHeight, self.view.frame.size.width, itemHeight))
        view3.backgroundColor = UIColor.pastepasswdItemColor()
        self.view.addSubview(view3)
        
        var view4:UIView = UIView(frame: CGRectMake(0.0, view3.frame.origin.y + itemHeight, self.view.frame.size.width, itemHeight))
        view4.backgroundColor = UIColor.clearColor()
        self.view.addSubview(view4)
        
        var view5:UIView = UIView(frame: CGRectMake(0.0, view4.frame.origin.y + itemHeight, self.view.frame.size.width, itemHeight))
        view5.backgroundColor = UIColor.pastepasswdItemColor()
        self.view.addSubview(view5)
        
        var view6:UIView = UIView(frame: CGRectMake(0.0, view5.frame.origin.y + itemHeight, self.view.frame.size.width, itemHeight))
        view6.backgroundColor = UIColor.clearColor()
        self.view.addSubview(view6)
        
        var view7:UIView = UIView(frame: CGRectMake(0.0, view6.frame.origin.y + itemHeight, self.view.frame.size.width, itemHeight))
        view7.backgroundColor = UIColor.pastepasswdItemColor()
        self.view.addSubview(view7)
        
        //Adding labels
        lengthLabel = TTTAttributedLabel(frame: CGRectZero)
        lengthLabel?.font = UIFont.mediumFontWithSize(16.0)
        lengthLabel?.textColor = UIColor.pastepasswdTextColor()
        lengthLabel?.text = "Length"
        lengthLabel?.numberOfLines = 0
        lengthLabel?.sizeToFit()
        self.view.addSubview(lengthLabel!)
        
        var lengthLabelRect:CGRect = lengthLabel!.frame
        lengthLabelRect.origin.x = 10.0;
        lengthLabelRect.origin.y = view1.frame.origin.y + view1.frame.size.height / 2.0 - lengthLabel!.frame.size.height / 2.0;
        lengthLabel!.frame = lengthLabelRect;
        
        lengthSlider = UISlider(frame: CGRectMake(10, 190, 290, 25))
        lengthSlider?.tintColor = UIColor.pastepasswdTextColor()
        lengthSlider?.minimumValue = 0.0
        lengthSlider?.maximumValue = maxChars
        lengthSlider?.value = 4.0
        lengthSlider?.continuous = true
        lengthSlider?.addTarget(self, action: "sliderValue:", forControlEvents: UIControlEvents.ValueChanged)
        self.view.addSubview(lengthSlider!)
        
        var lengthSliderRect:CGRect = lengthSlider!.frame;
        lengthSliderRect.origin.x = 80.0;
        lengthSliderRect.origin.y = view1.frame.origin.y + view1.frame.size.height / 2.0 - itemHeight / 2.0;
        lengthSliderRect.size.width = 200.0;
        lengthSliderRect.size.height = itemHeight;
        lengthSlider!.frame = lengthSliderRect;
        
        length = lengthSlider!.value
        
        lengthValueLabel = TTTAttributedLabel(frame: CGRectZero)
        lengthValueLabel?.font = UIFont.mediumFontWithSize(16.0)
        lengthValueLabel?.textColor = UIColor.pastepasswdTextColor()
        lengthValueLabel?.text = NSString(format: "%.0f", lengthSlider!.value)
        lengthValueLabel?.sizeToFit()
        lengthValueLabel?.textAlignment = NSTextAlignment.Center
        self.view.addSubview(lengthValueLabel!)
        
        var lengthValueLabelRect:CGRect = lengthValueLabel!.frame;
        lengthValueLabelRect.origin.x = self.view.frame.size.width - lengthValueLabel!.frame.size.width - 20.0;
        lengthValueLabelRect.origin.y = view1.frame.origin.y + view1.frame.size.height / 2.0 - lengthValueLabel!.frame.size.height / 2.0;
        lengthValueLabelRect.size.width = 20.0;
        lengthValueLabel!.frame = lengthValueLabelRect;
        
        //start mode 1
        let attributes:NSDictionary = NSDictionary(objectsAndKeys:
            UIFont(name: "Avenir-Medium", size: 16.0), NSFontAttributeName,
            UIColor.pastepasswdMainColor(), NSForegroundColorAttributeName)
        
        let lettersArr:Array = ["abc", "aBc", "ABC"]
        
        letters = UISegmentedControl(items: lettersArr)
        letters?.tintColor = UIColor.pastepasswdMainColor()
        letters?.selectedSegmentIndex = 1
        letters?.addTarget(self, action: "selectTypeOfLetter:", forControlEvents: UIControlEvents.ValueChanged)
        letters?.setTitleTextAttributes(attributes, forState: UIControlState.Normal)
        self.view.addSubview(letters!)
        
        var lettersRect:CGRect = letters!.frame
        lettersRect.origin.x = 10.0
        lettersRect.origin.y = view2.frame.origin.y + view2.frame.size.height / 2.0 - 40.0 / 2.0
        lettersRect.size.width = self.view.frame.size.width - 20.0
        lettersRect.size.height = 40.0
        letters!.frame = lettersRect
        
        let mixArr:Array = ["Numbers", "Punctuation"]
        
        typeChar = UISegmentedControl(items: mixArr)
        typeChar?.tintColor = UIColor.pastepasswdMainColor()
        typeChar?.selectedSegmentIndex = 1
        typeChar?.addTarget(self, action: "selectTypeOfChar:", forControlEvents: UIControlEvents.ValueChanged)
        typeChar?.setTitleTextAttributes(attributes, forState: UIControlState.Normal)
        self.view.addSubview(typeChar!)
        
        var typeCharRect:CGRect = typeChar!.frame
        typeCharRect.origin.x = 10.0
        typeCharRect.origin.y = view3.frame.origin.y + view3.frame.size.height / 2.0 - 40.0 / 2.0
        typeCharRect.size.width = self.view.frame.size.width - 20.0
        typeCharRect.size.height = 40.0
        typeChar!.frame = typeCharRect
        
        
        //Start Mode 2
        digitsLabel = TTTAttributedLabel(frame: CGRectZero)
        digitsLabel?.numberOfLines = 0
        digitsLabel?.font = UIFont.mediumFontWithSize(16.0)
        digitsLabel?.textColor = UIColor.pastepasswdTextColor()
        digitsLabel?.text = "Digits"
        digitsLabel?.sizeToFit()
        self.view.addSubview(digitsLabel!)
        
        var digitsLabelRect:CGRect = digitsLabel!.frame;
        digitsLabelRect.origin.x = 10.0;
        digitsLabelRect.origin.y = view2.frame.origin.y + view2.frame.size.height / 2.0 - digitsLabel!.frame.size.height / 2.0;
        digitsLabel!.frame = digitsLabelRect;
        
        digitsSlider = UISlider(frame: CGRectZero)
        digitsSlider?.minimumValue = 0.0
        digitsSlider?.maximumValue = 10.0
        digitsSlider?.tintColor = UIColor.pastepasswdTextColor()
        digitsSlider?.value = 1.0
        digitsSlider?.continuous = true
        digitsSlider?.addTarget(self, action: "digitsSliderValue:", forControlEvents: UIControlEvents.ValueChanged)
        self.view.addSubview(digitsSlider!)
        
        var digitsSliderRect:CGRect = digitsSlider!.frame;
        digitsSliderRect.origin.x = 80.0;
        digitsSliderRect.origin.y = view2.frame.origin.y + view2.frame.size.height / 2.0 - itemHeight / 2.0;
        digitsSliderRect.size.width = 200.0;
        digitsSliderRect.size.height = itemHeight;
        digitsSlider!.frame = digitsSliderRect;
        
        digitsValueLabel = TTTAttributedLabel(frame: CGRectZero)
        digitsValueLabel?.numberOfLines = 0
        digitsValueLabel?.font = UIFont.mediumFontWithSize(16.0)
        digitsValueLabel?.textColor = UIColor.pastepasswdTextColor()
        digitsValueLabel?.text = NSString(format: "%.0f", digitsSlider!.value)
        digitsValueLabel?.textAlignment = NSTextAlignment.Center
        digitsValueLabel?.sizeToFit()
        self.view.addSubview(digitsValueLabel!)
        
        var digitsValueLabelRect:CGRect = digitsValueLabel!.frame;
        digitsValueLabelRect.origin.x = self.view.frame.size.width - digitsValueLabel!.frame.size.width - 20.0;
        digitsValueLabelRect.origin.y = view2.frame.origin.y + view2.frame.size.height / 2.0 - itemHeight / 2.0;
        digitsValueLabelRect.size.width = 20.0;
        digitsValueLabelRect.size.height = itemHeight;
        digitsValueLabel!.frame = digitsValueLabelRect;
        
        digitsValue = digitsSlider!.value;
        
        symbolLabel = TTTAttributedLabel(frame: CGRectZero)
        symbolLabel?.numberOfLines = 0
        symbolLabel?.font = UIFont.mediumFontWithSize(16.0)
        symbolLabel?.textColor = UIColor.pastepasswdTextColor()
        symbolLabel?.text = "Symbols"
        symbolLabel?.sizeToFit()
        self.view.addSubview(symbolLabel!)
        
        var symbolsLabelRect:CGRect = symbolLabel!.frame;
        symbolsLabelRect.origin.x = 10.0;
        symbolsLabelRect.origin.y = view3.frame.origin.y + view3.frame.size.height / 2.0 - symbolLabel!.frame.size.height / 2.0;
        symbolLabel!.frame = symbolsLabelRect;
        
        symbolSlider = UISlider(frame: CGRectZero)
        symbolSlider?.minimumValue = 0.0
        symbolSlider?.tintColor = UIColor.pastepasswdTextColor()
        symbolSlider?.maximumValue = 16.0
        symbolSlider?.value = 0.0
        symbolSlider?.continuous = true
        symbolSlider?.addTarget(self, action: "symbolSliderValue:", forControlEvents: UIControlEvents.ValueChanged)
        self.view.addSubview(symbolSlider!)
        
        var symbolSliderRect:CGRect = symbolSlider!.frame;
        symbolSliderRect.origin.x = 80.0;
        symbolSliderRect.origin.y = view3.frame.origin.y + view3.frame.size.height / 2.0 - itemHeight / 2.0;
        symbolSliderRect.size.width = 200.0;
        symbolSliderRect.size.height = itemHeight;
        symbolSlider!.frame = symbolSliderRect;
        
        symbolValueLabel = TTTAttributedLabel(frame: CGRectZero)
        symbolValueLabel?.numberOfLines = 0
        symbolValueLabel?.font = UIFont.mediumFontWithSize(16.0)
        symbolValueLabel?.textColor = UIColor.pastepasswdTextColor()
        symbolValueLabel?.text = NSString(format: "%.0f", symbolSlider!.value)
        symbolValueLabel?.sizeToFit()
        symbolValueLabel?.textAlignment = NSTextAlignment.Center
        self.view.addSubview(symbolValueLabel!)
        
        var symbolValueLabelRect:CGRect = symbolValueLabel!.frame;
        symbolValueLabelRect.origin.x = self.view.frame.size.width - symbolValueLabel!.frame.size.width - 20.0;
        symbolValueLabelRect.origin.y = view3.frame.origin.y + view3.frame.size.height / 2.0 - itemHeight / 2.0;
        symbolValueLabelRect.size.width = 20.0;
        symbolValueLabelRect.size.height = itemHeight;
        symbolValueLabel!.frame = symbolValueLabelRect;
        
        symbolValue = symbolSlider!.value;
        
        //Both Modes
        avoidAmbiguousLabel = TTTAttributedLabel(frame: CGRectZero)
        avoidAmbiguousLabel?.numberOfLines = 0
        avoidAmbiguousLabel?.textColor = UIColor.pastepasswdTextColor()
        avoidAmbiguousLabel?.font = UIFont.mediumFontWithSize(16.0)
        avoidAmbiguousLabel?.text = "Avoid ambiguous characters"
        avoidAmbiguousLabel?.sizeToFit()
        self.view.addSubview(avoidAmbiguousLabel!)
        
        var avoidAmbiguousLabelRect:CGRect = avoidAmbiguousLabel!.frame;
        avoidAmbiguousLabelRect.origin.x = 10.0;
        avoidAmbiguousLabelRect.origin.y = view4.frame.origin.y + view4.frame.size.height / 2.0 - avoidAmbiguousLabel!.frame.size.height / 2.0;
        avoidAmbiguousLabel!.frame = avoidAmbiguousLabelRect;
        
        switchAmbiguous = UISwitch(frame: CGRectZero)
        switchAmbiguous?.onTintColor = UIColor.pastepasswdMainColor()
        switchAmbiguous?.addTarget(self, action: "switchAmbiguousValue:", forControlEvents: UIControlEvents.ValueChanged)
        self.view.addSubview(switchAmbiguous!)
        
        var switchAmbiguousRect:CGRect = switchAmbiguous!.frame;
        switchAmbiguousRect.origin.x = self.view.frame.size.width - switchAmbiguous!.frame.size.width - 10.0;
        switchAmbiguousRect.origin.y = view4.frame.origin.y + view4.frame.size.height / 2.0 - switchAmbiguous!.frame.size.height / 2.0;
        switchAmbiguous!.frame = switchAmbiguousRect;
        
        allowCharsRepeatLabel = TTTAttributedLabel(frame: CGRectZero)
        allowCharsRepeatLabel?.numberOfLines = 0
        allowCharsRepeatLabel?.textColor = UIColor.pastepasswdTextColor()
        allowCharsRepeatLabel?.font = UIFont.mediumFontWithSize(16.0)
        allowCharsRepeatLabel?.text = "Allow characters to repeat"
        allowCharsRepeatLabel?.sizeToFit()
        self.view.addSubview(allowCharsRepeatLabel!)
        
        var allowCharsRepeatLabelRect:CGRect = allowCharsRepeatLabel!.frame;
        allowCharsRepeatLabelRect.origin.x = 10.0;
        allowCharsRepeatLabelRect.origin.y = view5.frame.origin.y + view5.frame.size.height / 2.0 - allowCharsRepeatLabel!.frame.size.height / 2.0;
        allowCharsRepeatLabel!.frame = allowCharsRepeatLabelRect;
        
        switchAllowRepeat = UISwitch(frame: CGRectZero)
        switchAllowRepeat?.setOn(true, animated: true)
        switchAllowRepeat?.onTintColor = UIColor.pastepasswdMainColor()
        switchAllowRepeat?.addTarget(self, action: "switchAllowRepeatValue:", forControlEvents: UIControlEvents.ValueChanged)
        self.view.addSubview(switchAllowRepeat!)
        
        var switchAllowRepeatRect:CGRect = switchAllowRepeat!.frame;
        switchAllowRepeatRect.origin.x = self.view.frame.size.width - switchAllowRepeat!.frame.size.width - 10.0;
        switchAllowRepeatRect.origin.y = view5.frame.origin.y + view5.frame.size.height / 2.0 - switchAllowRepeat!.frame.size.height / 2.0;
        switchAllowRepeat!.frame = switchAllowRepeatRect;
        
        secureLabel = TTTAttributedLabel(frame: CGRectZero)
        secureLabel?.numberOfLines = 0
        secureLabel?.textColor = UIColor.pastepasswdTextColor()
        secureLabel?.font = UIFont.mediumFontWithSize(16.0)
        secureLabel?.text = "Secure Text"
        secureLabel?.sizeToFit()
        self.view.addSubview(secureLabel!)
        
        passwordMode = UISwitch(frame: CGRectZero)
        passwordMode?.setOn(false, animated: true)
        passwordMode?.onTintColor = UIColor.pastepasswdMainColor()
        passwordMode?.addTarget(self, action: "changePasswordMode:", forControlEvents: UIControlEvents.ValueChanged)
        self.view.addSubview(passwordMode!)
        
        var passwordModeRect:CGRect = passwordMode!.frame;
        passwordModeRect.origin.x = self.view.frame.size.width - passwordMode!.frame.size.width - 10.0;
        passwordModeRect.origin.y = view6.frame.origin.y + view6.frame.size.height / 2.0 - passwordMode!.frame.size.height / 2.0;
        passwordMode!.frame = passwordModeRect;
        
        var secureTextLabelRect:CGRect = secureLabel!.frame;
        secureTextLabelRect.origin.x = 10.0;
        secureTextLabelRect.origin.y = view6.frame.origin.y + view6.frame.size.height / 2.0 - secureLabel!.frame.size.height / 2.0;
        secureLabel!.frame = secureTextLabelRect;
        
        clipboardLabel = TTTAttributedLabel(frame: CGRectZero)
        clipboardLabel?.numberOfLines = 0;
        clipboardLabel?.font = UIFont.mediumFontWithSize(16.0)
        clipboardLabel?.textColor = UIColor.pastepasswdTextColor()
        clipboardLabel?.text = "Copy to Clipboard"
        clipboardLabel?.sizeToFit()
        self.view.addSubview(clipboardLabel!)
        
        var clipboardLabelRect:CGRect = clipboardLabel!.frame;
        clipboardLabelRect.origin.x = 10.0;
        clipboardLabelRect.origin.y = view7.frame.origin.y + view7.frame.size.height / 2.0 - clipboardLabel!.frame.size.height / 2.0;
        clipboardLabel!.frame = clipboardLabelRect;
        
        clipboardSwitch = UISwitch(frame: CGRectZero)
        clipboardSwitch?.setOn(true, animated: true)
        clipboardSwitch?.onTintColor = UIColor.pastepasswdMainColor()
        clipboardSwitch?.addTarget(self, action: "changeClipboardValue:", forControlEvents: UIControlEvents.ValueChanged)
        self.view.addSubview(clipboardSwitch!)
        
        var clipboardSwitchRect:CGRect = clipboardSwitch!.frame;
        clipboardSwitchRect.origin.x = self.view.frame.size.width - clipboardSwitch!.frame.size.width - 10.0;
        clipboardSwitchRect.origin.y = view7.frame.origin.y + view7.frame.size.height / 2.0 - clipboardSwitch!.frame.size.height / 2.0;
        clipboardSwitch!.frame = clipboardSwitchRect;
        
        var settingsImage:UIImage = UIImage(named: "settings")
        var settingsButton:UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        settingsButton.frame = CGRectMake(0, 0, 28, 28);
        settingsButton.setBackgroundImage(settingsImage, forState: UIControlState.Normal)
        settingsButton.setBackgroundImage(settingsImage, forState: UIControlState.Highlighted)
        settingsButton.addTarget(self, action: "displaySettings:", forControlEvents: UIControlEvents.TouchDown)
        
        var settingsBarButtonItem:UIBarButtonItem = UIBarButtonItem(customView: settingsButton)
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = settingsBarButtonItem
        
        var titleMainView:UILabel = UILabel(frame: CGRectMake(0, 0, 320, 44))
        titleMainView.backgroundColor = UIColor.clearColor()
        titleMainView.textColor = UIColor.whiteColor()
        var font:UIFont = UIFont(name: "Avenir-Medium", size: 20)
        titleMainView.font = font
        titleMainView.text = "Pastepasswd"
        titleMainView.sizeToFit()
        self.navigationItem.titleView = titleMainView;
    
        let userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let value:String? = userDefaults.objectForKey("mode") as? String
        
        if value == nil {
            userDefaults.setObject("2", forKey: "mode")
            userDefaults.synchronize()
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "changeMode:", name: "changeMode", object: nil)
        
        changeMode(nil)
    }
    
    func selectTypeOfLetter(sender:UISegmentedControl) {
        let segmentedControl:UISegmentedControl = sender as UISegmentedControl
        let value:Int = Int(segmentedControl.selectedSegmentIndex)
        typeLetterValue = value
        generatePassword()
    }
    
    func selectTypeOfChar(sender:UISegmentedControl) {
        let segmentedControl:UISegmentedControl = sender as UISegmentedControl
        let value:Int = Int(segmentedControl.selectedSegmentIndex)
        typeCharValue = value
        generatePassword()
    }
    
    func changeMode(notification:NSNotification?) {
        let userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let value:String? = userDefaults.objectForKey("mode") as? String
        
        if value == "1" {
            mode = "1"
            digitsSlider!.hidden = true
            symbolSlider!.hidden = true
            digitsLabel!.hidden = true
            symbolLabel!.hidden = true
            digitsValueLabel!.hidden = true
            symbolValueLabel!.hidden = true
            letters!.hidden = false
            typeChar!.hidden = false
        } else {
            mode = "2"
            digitsSlider!.hidden = false
            symbolSlider!.hidden = false
            digitsLabel!.hidden = false
            symbolLabel!.hidden = false
            digitsValueLabel!.hidden = false
            symbolValueLabel!.hidden = false
            letters!.hidden = true
            typeChar!.hidden = true
        }
        generatePassword()
    }
    
    func changePasswordMode(sender: UISwitch) {
        var mode:UISwitch = sender as UISwitch
        if mode.on {
            passwordView?.slideOut()
        } else {
            passwordView?.slideIn()
        }
    }
    
    // MARK: Display Settings
    
    func displaySettings(sender: UIButton) {
        let settingsViewController:PPPSettingsTableViewController = PPPSettingsTableViewController(style: UITableViewStyle.Grouped)
        let navigationController:UINavigationController = UINavigationController(rootViewController: settingsViewController);
        navigationController.modalPresentationStyle = UIModalPresentationStyle.FormSheet;
        self.navigationController?.presentViewController(navigationController, animated: true, completion: nil)
    }
    
    // MARK: Generate Password
    
    func generatePassword() {
        
        var userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let modeValue:String = userDefaults.objectForKey("mode") as String
        
         let pc:PPPasswordController = PPPasswordController.sharedInstance
         var password:String
    
        println(modeValue)
        if modeValue == "1" {
            password = pc.generatePassword(Int(length!), typeLetter: typeLetterValue!, typeChar: typeCharValue!, avoid: allowRepeat!, ambiguous: ambiguous!)
             println("mode1: " + password)
        } else {
            password = pc.generatePassword(Int(length!), digitsLength: Int(digitsValue!), symbolsLength: Int(symbolValue!), avoid: allowRepeat!, ambiguous: ambiguous!)
            println("mode2: " + password)
        }
        
        if clipboardMode! {
            var pasteboard:UIPasteboard = UIPasteboard.generalPasteboard()
            pasteboard.string = password
        }

        displayText(password)
    }
    
    // MARK: Actions
    
    func sliderValue(sender: UISlider!) {
        var slider:UISlider = sender as UISlider
        length = slider.value
        var intLength:Int = Int(length!)
        lengthValueLabel?.text = NSString(format: "%d", intLength)
        var progressValue:Float = length! / maxChars
        passwordLength?.setProgress(progressValue, animated: true)
        
        /*let c1 = intLength >= 0 && intLength <= 6
        let c2 = intLength >= 6 && intLength <= 9
        let c3 = intLength >= 9 && intLength <= 11
        let c4 = intLength >= 11 && intLength <= 19
        let c5 = intLength >= 19 && intLength <= 30
        let c6 = intLength >= 30 && intLength <= Int(maxChars)
        
        if c1 {
        passwordLength?.tintColor = UIColor.redColor()
        } else if c2 {
        passwordLength?.tintColor = UIColor.redColor()
        } else if c3 {
        passwordLength?.tintColor = UIColor.orangeColor()
        } else if c4 {
        passwordLength?.tintColor = UIColor.yellowColor()
        } else if c5 {
        passwordLength?.tintColor = UIColor.greenColor()
        } else if c6 {
        passwordLength?.tintColor = UIColor.cyanColor()
        }*/
        
        switch intLength {
        case 0...6:
            passwordLength?.tintColor = UIColor.redColor()
            break
        case 6...9:
            passwordLength?.tintColor = UIColor.redColor()
            break
        case 9...11:
            passwordLength?.tintColor = UIColor.orangeColor()
            break
        case 11...19:
            passwordLength?.tintColor = UIColor.yellowColor()
            break
        case 19...30:
            passwordLength?.tintColor = UIColor.greenColor()
            break
        case 30...Int(maxChars):
            passwordLength?.tintColor = UIColor.cyanColor()
            break
        default:
            passwordLength?.tintColor = UIColor.redColor()
        }
        
        let between = intLength >= 0 && intLength < Int(maxChars)
        
        if between {
            generatePassword()
        }
    }
    
    func digitsSliderValue(sender:UISlider!) {
        var slider:UISlider = sender as UISlider
        digitsValue = sender.value
        digitsValueLabel?.text = NSString(format: "%d", Int(digitsValue!))
        generatePassword()
    }
    
    func symbolSliderValue(sender:UISlider!) {
        var slider:UISlider = sender as UISlider
        symbolValue = sender.value
        symbolValueLabel?.text = NSString(format: "%d", Int(symbolValue!))
        generatePassword()
    }
    
    func switchAllowRepeatValue(sender:UISwitch!) {
        var mode:UISwitch = sender as UISwitch
        if mode.on {
            allowRepeat = true
        } else {
            allowRepeat = false
        }
        
        generatePassword()
    }
    
    func changeClipboardValue(sender:UISwitch!) {
        var mode:UISwitch = sender as UISwitch
        if mode.on {
            clipboardMode = true
        } else {
            clipboardMode = false
        }
    }
    
    func switchAmbiguousValue(sender:UISwitch!) {
        var mode:UISwitch = sender as UISwitch
        if mode.on {
            ambiguous = true
        } else {
            ambiguous = false
        }
        generatePassword()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Display Text
    
    func displayText(value:NSString) {
        passwordView!.passwordSecureTextField!.text = value
        
        passwordView!.attributedLabel!.setText(value, afterInheritingLabelAttributesAndConfiguringWithBlock: { (mutableAttributedString) -> NSMutableAttributedString! in
            
            var searchedRange:NSRange = NSMakeRange(0, value.length)
            
            var error: NSError?
            var regexNumbers:NSRegularExpression = NSRegularExpression.regularExpressionWithPattern("\\d+", options: nil, error: &error)!
            var  matches:NSArray = regexNumbers.matchesInString(value, options: nil, range: searchedRange) as Array<NSTextCheckingResult>
           
            for match in matches {
                mutableAttributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.pastepasswdNumbersColor(), range: match.range)
            }
            
            var regexLetters:NSRegularExpression = NSRegularExpression.regularExpressionWithPattern("[a-zA-Z]+", options: nil, error: &error)!
            var  matchesLetters:NSArray = regexLetters.matchesInString(value, options: nil, range: searchedRange) as Array<NSTextCheckingResult>
            
            for match in matchesLetters {
                mutableAttributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.pastepasswdMainColor(), range: match.range)
            }
            return mutableAttributedString;
        })
    }
}
