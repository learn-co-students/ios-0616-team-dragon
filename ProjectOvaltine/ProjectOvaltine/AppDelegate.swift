//
//  AppDelegate.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/4/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        // Override point for customization after application launch.
        self.window!.makeKeyAndVisible()
        
        self.window?.rootViewController = MapKitViewController()
        //self.window?.rootViewController = TestViewController()
        
        // Parcing county and state codes on the first launch
        let userDefaults = NSUserDefaults()
        //if !userDefaults.boolForKey("Codes parsed") { /////////////////// REMOVE THIS FOR SPEED TESTS
            let parser = CensusAPICodesParser()
            parser.parseCodes() { success in
                if success {
                    print("Parcing state & county codes successful! ")
                    userDefaults.setBool(true, forKey: "Codes parsed")
                } else {
                    print("Error parcing state & county codes, fix it or app won't work!")
                }
        }
        return true
    }
    

}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}