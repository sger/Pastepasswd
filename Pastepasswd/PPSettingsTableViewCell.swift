// PPSettingsTableViewCell.swift
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

class PPSettingsTableViewCell: UITableViewCell {

    var label:UILabel?
    var switchMode:UISwitch?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.textLabel?.hidden = true
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.mainScreen().scale
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        label = UILabel(frame: CGRectMake(0.0, 0.0, self.frame.size.width, 20.0))
        label?.numberOfLines = 0
        label?.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        label?.backgroundColor = UIColor.clearColor()
        label?.font = UIFont(name: "Avenir-Medium", size: 16)
        label?.textColor = UIColor.pastepasswdTextColor()
        self.contentView.addSubview(label!)
        
        switchMode = UISwitch(frame: CGRectMake(0, 0, self.frame.size.width, 20.0))
        switchMode!.onTintColor = UIColor.pastepasswdMainColor()
        switchMode!.setOn(true, animated: true)
        self.contentView.addSubview(switchMode!)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override  func layoutSubviews() {
        label?.frame = CGRectMake(14.0, 12.0, self.frame.size.width, 20.0)
        switchMode?.frame = CGRectMake(self.frame.size.width - switchMode!.frame.size.width - 10.0, 6.0, 0.0, 0.0)
    }

}
