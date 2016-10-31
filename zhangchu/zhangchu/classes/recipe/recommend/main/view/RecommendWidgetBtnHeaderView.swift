//
//  RecommendWidgetBtnHeaderView.swift
//  zhangchu
//
//  Created by 苏宁 on 2016/10/26.
//  Copyright © 2016年 suning. All rights reserved.
//

import UIKit

class RecommendWidgetBtnHeaderView: UIView {
    
    var textField:UITextField!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(red: 243 / 255, green: 243 / 255, blue: 244 / 255, alpha: 1)
        //
        textField = UITextField(frame: CGRect(x: 35, y: 8, width: bounds.size.width - 30 * 2, height: 30))
        textField.placeholder = "输入菜名或食材搜索"
        textField.textAlignment = .Center
        textField.borderStyle = .RoundedRect
        addSubview(textField)
        //
        let imgView = UIImageView(image: UIImage(named: "search1"))
        imgView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        imgView.backgroundColor = UIColor.cyanColor()
        textField.leftView = imgView
        textField.leftViewMode = .Always
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
