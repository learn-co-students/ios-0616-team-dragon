//
//  Extensions.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/12/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import CoreGraphics

extension UIImage {
    func imageWithColor(tintColor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        
        //let context = UIGraphicsGetCurrentContext() as CGContextRef
        //error: 'CGContext?' is not convertible to 'CGContextRef'
        //CGContextRef == CGContext, so it's saying "'CGContext?' is not convertible to 'CGContext'"
        //->you just need to unwrap it
        let context = UIGraphicsGetCurrentContext()!
        
        
        CGContextTranslateCTM(context, 0, self.size.height)
        CGContextScaleCTM(context, 1.0, -1.0);
        //CGContextSetBlendMode(context, kCGBlendModeNormal)
        //error: use of unresolved identifier 'kCGBlendModeNormal'
        //->See the CGBlendMode constants in the CGContext Reference, it's got enum.
        CGContextSetBlendMode(context, CGBlendMode.Normal)
        
        let rect = CGRectMake(0, 0, self.size.width, self.size.height) as CGRect
        CGContextClipToMask(context, rect, self.CGImage)
        tintColor.setFill()
        CGContextFillRect(context, rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext() as UIImage
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
