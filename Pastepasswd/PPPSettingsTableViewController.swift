// PPPSettingsTableViewController.swift
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
import MessageUI

class PPPSettingsTableViewController: UITableViewController, MFMailComposeViewControllerDelegate, UIGestureRecognizerDelegate {
    
    // MARK: Initializers
    
    override init() {
         super.init(style: UITableViewStyle.Grouped)
    }
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
        
    }
    
    required  init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for parent in self.navigationController!.navigationBar.subviews {
            for childView in parent.subviews {
                if(childView is UIImageView) {
                    childView.removeFromSuperview()
                }
            }
        }
        
        var doneButton:UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        doneButton.frame = CGRectMake(0, 0, 45.0, 22.0);
        doneButton.setTitle("Done", forState: UIControlState.Normal)
        doneButton.addTarget(self, action: "close:", forControlEvents: UIControlEvents.TouchDown)
        
        var doneBarButtonItem:UIBarButtonItem = UIBarButtonItem(customView: doneButton)
        self.navigationItem.rightBarButtonItem = doneBarButtonItem
        
        var titleMainView:UILabel = UILabel(frame: CGRectMake(0, 0, 320, 44))
        titleMainView.backgroundColor = UIColor.clearColor()
        titleMainView.textColor = UIColor.whiteColor()
        var font:UIFont = UIFont(name: "Avenir-Medium", size: 20)!
        titleMainView.font = font
        titleMainView.text = "Settings"
        titleMainView.sizeToFit()
        self.navigationItem.titleView = titleMainView;

        //self.tableView.registerClass(PPSettingsTableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        self.navigationController?.interactivePopGestureRecognizer.enabled = true
        self.navigationController?.interactivePopGestureRecognizer.delegate = self
    }
    
    // MARK: Actions
    
    func close(sender:UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                
            }
            return
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                if MFMailComposeViewController.canSendMail() {
                    var mailer:MFMailComposeViewController = MFMailComposeViewController()
                    mailer.mailComposeDelegate = self
                    mailer.setSubject("Feedback")
                    mailer.setToRecipients(["pastepasswd@spirosgerokostas.com"])
                    let titleTextDict:NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont.mediumFontWithSize(16.0)]
                    mailer.navigationBar.titleTextAttributes = titleTextDict
                    mailer.navigationBar.tintColor = UIColor.whiteColor()
                    self.presentViewController(mailer, animated: true, completion: nil)
                } else {
                    var alert:UIAlertView = UIAlertView(title: "Pastepasswd", message: "Your device doesn't support this feature", delegate: nil, cancelButtonTitle: "OK")
                    alert.show()
                }
            } else if indexPath.row == 1 {
                var pastepasswdViewController:PPPastepasswdViewController = PPPastepasswdViewController()
                self.navigationController?.pushViewController(pastepasswdViewController, animated: true)
            }
        }
    }

    // MARK: UITableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 2
        }
        return 0
    }
    
    // Custom UITableViewCell
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell:PPSettingsTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell") as PPSettingsTableViewCell
//        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
//        
//        if indexPath.section == 0 {
//            if indexPath.row == 0 {
//                cell.accessoryType = UITableViewCellAccessoryType.None
//                cell.label!.text = "Switch Mode"
//                cell.switchMode!.addTarget(self, action: "switchMode:", forControlEvents: UIControlEvents.ValueChanged)
//                
//                var userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
//                let modeValue:String = userDefaults.objectForKey("mode") as String
//                
//                println(modeValue)
//                
//                if modeValue == "1" {
//                    cell.switchMode!.setOn(true, animated: true)
//                } else {
//                    cell.switchMode!.setOn(false, animated: true)
//                }
//            }
//        } else if indexPath.section == 1 {
//            if indexPath.row == 0 {
//                cell.switchMode?.hidden = true
//                cell.label?.text = "Send Feedback"
//            }
//            if indexPath.row == 1 {
//                cell.switchMode?.hidden = true
//                cell.label?.text = "About"
//            }
//        }
//        
//        return cell;
//
//    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        let label:UILabel = UILabel(frame: CGRectMake(14.0, 12.0, self.view.frame.size.width, 20.0))
        label.numberOfLines = 0
        label.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        label.backgroundColor = UIColor.clearColor()
        label.font = UIFont(name: "Avenir-Medium", size: 16)
        label.textColor = UIColor.pastepasswdTextColor()
        cell.contentView.addSubview(label)
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell.accessoryType = UITableViewCellAccessoryType.None
                cell.selectionStyle = UITableViewCellSelectionStyle.None
                label.text  = "Switch Mode"
                
                let switchMode:UISwitch = UISwitch(frame: CGRectMake(self.view.frame.size.width - 60.0, 6.0, 0.0, 0.0))
                switchMode.onTintColor = UIColor.pastepasswdMainColor()
                switchMode.setOn(true, animated: true)
                switchMode.addTarget(self, action: "switchMode:", forControlEvents: UIControlEvents.ValueChanged)
                cell.contentView.addSubview(switchMode)
                
                var userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                let modeValue:String = userDefaults.objectForKey("mode") as String
                
                //println(modeValue)
                
                if modeValue == "1" {
                    switchMode.setOn(true, animated: true)
                } else {
                    switchMode.setOn(false, animated: true)
                }
            }
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                label.text  = "Send Feedback"
            }
            if indexPath.row == 1 {
                label.text  = "About"
            }
        }
        return cell;
    }
    
    // MARK: UITableViewDelegate
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func switchMode(sender: UISwitch) {
        let mode:UISwitch = sender as UISwitch
        let value:NSString = mode.on == true ? "1" : "2"
        let userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(value, forKey: "mode")
        userDefaults.synchronize()
        NSNotificationCenter.defaultCenter().postNotificationName("changeMode", object: nil)
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "OPTIONS"
        } else if section == 1 {
            return "MORE"
        }
        return nil
    }
    
     // MARK: MFMailComposeViewControllerDelegate
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        switch result.value {
        case MFMailComposeResultCancelled.value:
            break;
        case MFMailComposeResultSaved.value:
            break;
        case MFMailComposeResultSent.value:
            break;
        case MFMailComposeResultFailed.value:
            break;
        default:
            break;
        }
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
}
