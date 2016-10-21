//
//  UIButtonCommon.swift
//  zhangchu
//
//  Created by 苏宁 on 2016/10/21.
//  Copyright © 2016年 suning. All rights reserved.
//

import Foundation
import UIKit

extension UIButton
{
    class func createButton(title:String?, bgImgName:String?, highlightImgName:String?, selectImgName:String?, target:AnyObject?, action:Selector) ->UIButton
    {
        let button = UIButton(type: .Custom)
        if let tmpTitle = title
        {
            button.setTitle(tmpTitle, forState: .Normal)
            button.setTitleColor(UIColor.blackColor(), forState: .Normal)
        }
        if let tmpBgImgName = bgImgName
        {
            button.setBackgroundImage(UIImage(named: tmpBgImgName), forState: .Normal)
        }
        if let tmpHighlightImgName = highlightImgName
        {
            button.setBackgroundImage(UIImage(named: tmpHighlightImgName), forState: .Highlighted)
        }
        if let tmpSelectImgName = selectImgName
        {
            button.setBackgroundImage(UIImage(named: tmpSelectImgName), forState: .Selected)
        }
        if target != nil && action != nil
        {
            button.addTarget(target, action: action, forControlEvents: .TouchUpInside)

        }
        
        return button
    }
}