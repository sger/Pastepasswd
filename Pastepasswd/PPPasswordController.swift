//
//  PPPasswordController.swift
//  Pastepasswd
//
//  Created by Spiros Gerokostas on 8/31/14.
//  Copyright (c) 2014 Spiros Gerokostas. All rights reserved.
//

import UIKit

class PPPasswordController: NSObject {
     // MARK: Singleton
    class var sharedInstance : PPPasswordController {
    struct Static {
        static var onceToken:dispatch_once_t = 0
        static var instance:PPPasswordController? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = PPPasswordController()
        }
        return Static.instance!
    }
    
    func generatePassword(length:Int,  typeLetter:NSInteger, typeChar:NSInteger, avoid:Bool, ambiguous:Bool)->String {
        var selectedSet:NSString = ""
        
        switch typeLetter {
        case 0:
            selectedSet = selectedSet.stringByAppendingString("abcdefghijklmnopqrstuvwxyz")
            break
        case 1:
            selectedSet = selectedSet.stringByAppendingString("abcdefghijklmnopqrstuvwxyz")
            selectedSet = selectedSet.stringByAppendingString("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
            break
        case 2:
            if ambiguous {
                selectedSet = selectedSet.stringByAppendingString("ACEFHJKMNPRTUVWXY")
            } else {
                selectedSet = selectedSet.stringByAppendingString("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
            }
            break
        default:
            break
        }
        
        switch typeChar {
        case 0:
            if ambiguous {
                selectedSet = selectedSet.stringByAppendingString("3479")
            } else {
                selectedSet = selectedSet.stringByAppendingString("0123456789")
            }
            break;
        case 1:
            if ambiguous {
                selectedSet = selectedSet.stringByAppendingString("3479")
            } else {
                selectedSet = selectedSet.stringByAppendingString("0123456789")
            }
            selectedSet = selectedSet.stringByAppendingString("~!@#$%^&*+=?/|:;")
            break;
        default:
            break;
        }
        
        var result:NSString = ""
        var targetLength:Int = Int(length)
        
        if !avoid {
            println(avoid)
            var chars:NSMutableArray = NSMutableArray(capacity: selectedSet.length)
            
            for var i:Int = 0; i < selectedSet.length; i++ {
                var ichar:NSString = NSString(format: "%C", selectedSet.characterAtIndex(i))
                chars.addObject(ichar)
            }
            
            var choice:NSMutableSet = NSMutableSet()
            while choice.count < targetLength {
                var randomIndex:Int = Int(arc4random_uniform(UInt32(chars.count)))
                choice.addObject(chars.objectAtIndex(randomIndex))
            }
            
            result = choice.allObjects.combine("")
            println(result)
        } else {
            
            for var i:Int = 0; i < targetLength; i++ {
                let location = Int(arc4random_uniform(UInt32(selectedSet.length)))
                result = result.stringByAppendingFormat(selectedSet.substringWithRange(NSRange(location: location, length: 1)))
            }
            
            println(result)
        }
        checkForDuplicateChars(result)
        return result
    }

    
    func generatePassword(length:Int,  digitsLength:Int, symbolsLength:Int, avoid:Bool, ambiguous:Bool) ->String {
        var result:String = ""
        var selectedSet:NSString = ""
        var totalChars:NSInteger = 0
        var totalDigits:NSInteger = 0
        var totalSymbols:NSInteger = 0
        
        totalChars = length - digitsLength - symbolsLength
        
        if totalChars <= 0 {
            if digitsLength >= length {
                totalDigits = length
                totalSymbols = 0
                totalChars = 0
            } else {
                totalDigits = digitsLength
                totalSymbols = symbolsLength + totalChars
                totalChars = 0
            }
        } else {
            totalDigits = digitsLength
            totalSymbols = symbolsLength
        }
        
        var selectedDigits:NSString = ""
        
        if ambiguous {
            selectedDigits = selectedDigits.stringByAppendingString("3479")
        } else {
            selectedDigits = selectedDigits.stringByAppendingString("0123456789")
        }
        
        for var i:Int = 0; i < totalDigits; i++ {
            let location = Int(arc4random_uniform(UInt32(selectedDigits.length)))
            selectedSet = selectedSet.stringByAppendingString(selectedDigits.substringWithRange(NSRange(location: location, length: 1)))
        }
        
        var selectedPunc:NSString = ""
        
        selectedPunc = selectedPunc.stringByAppendingString("~!@#$%^&*+=?/|:;")
        
        for var i = 0; i < totalSymbols; i++ {
            let location = Int(arc4random_uniform(UInt32(selectedPunc.length)))
            selectedSet = selectedSet.stringByAppendingString(selectedPunc.substringWithRange(NSRange(location: location, length: 1)))
        }
        
        if totalChars > 0 {
            
            println(avoid)
            
            if !avoid {
                var chars:[String] = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t","u", "v", "w", "x", "y", "z", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S","T","U","V", "W", "X", "Y", "Z"]
                var choiceChars:[String] = []
                
                var test:NSMutableSet = NSMutableSet()
                
                while(choiceChars.count < totalChars) {
                    let randomIndex = Int(arc4random_uniform(UInt32(chars.count)))
                    choiceChars.append(chars[randomIndex])
                    test.addObject(chars[randomIndex])
                }
                
                var non:NSString = test.allObjects.combine("")
                
                selectedSet = selectedSet.stringByAppendingString(non);
                
            } else {
                
                var chars:NSString = ""
                var selectedChars:NSString = ""
                
                if ambiguous {
                    selectedChars = selectedChars.stringByAppendingString("ACEFHJKMNPRTUVWXY")
                    selectedChars = selectedChars.stringByAppendingString("acefhjkmnprtuvwxy")
                } else {
                    selectedChars = selectedChars.stringByAppendingString("abcdefghijklmnopqrstuvwxyz")
                    selectedChars = selectedChars.stringByAppendingString("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
                }
                
                for var i:Int = 0; i < totalChars; i++ {
                    let location = Int(arc4random_uniform(UInt32(selectedChars.length)))
                    chars = chars.stringByAppendingFormat(selectedChars.substringWithRange(NSRange(location: location, length: 1)))
                }
                selectedSet = selectedSet.stringByAppendingString(chars)
            }
        }
        
        println(selectedSet)
        
        var str:NSString = Utils.randomizeStringWith(selectedSet)
        println("result: " +  str)
        
        //check for duplicates
        checkForDuplicateChars(str)
        
        return str
    }
    
    func checkForDuplicateChars(value:NSString) {
        var input:NSString = value
        var seenCharacters:NSMutableSet = NSMutableSet()
        var resultString:NSMutableString = NSMutableString()
        input.enumerateSubstringsInRange(NSMakeRange(0, input.length), options: NSStringEnumerationOptions.ByComposedCharacterSequences) { (substring:String!, substringRange:NSRange, enclosingRange:NSRange, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
            if !seenCharacters.containsObject(substring) {
                seenCharacters.addObject(substring)
                resultString.appendString(substring)
            } else {
                println("duplicates " + substring)
            }
        }
    }
}
