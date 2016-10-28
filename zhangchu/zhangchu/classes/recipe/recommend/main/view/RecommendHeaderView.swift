//
//  RecommendHeaderView.swift
//  zhangchu
//
//  Created by 苏宁 on 2016/10/27.
//  Copyright © 2016年 suning. All rights reserved.
//

import UIKit

class RecommendHeaderView: UIView {
    
    var clickClosure:RecipClickClosure?
    
    var listModel:RecipeRecommendWidgetList?{
        didSet{
            configText((listModel?.title)!)
        }
    }

    private var titleLabel:UILabel?
    
    private var imgView:UIImageView?
    
    
    private var space:CGFloat = 40
    
    private var margin:CGFloat = 20
    
    private var iconWidth:CGFloat = 22
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(white: 0.9, alpha: 1)
        
        let bgView = UIView.createView()
        bgView.backgroundColor = UIColor.whiteColor()
        bgView.frame = CGRectMake(0, 10, bounds.width, 44)
        addSubview(bgView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapClick))
        bgView.addGestureRecognizer(tap)
        
        //
        titleLabel = UILabel.createLabel(nil, textAlignment: .Left, font: UIFont.systemFontOfSize(17))
        bgView.addSubview(titleLabel!)
        //
        let iconImg = UIImage(named: "more_icon")
        imgView = UIImageView(image: iconImg)
        bgView.addSubview(imgView!)
    }
    
    //显示文字
    func configText(text:String)
    {
        //计算文字的宽度
        let str = NSString(string: text)
        //参1 文字的最大范围
        //参2 文字的显示规范
        //参3 文字的属性
        //参4 上下文
        let maxWidth = bounds.width - space * 2 - iconWidth - margin
        let textWidth = str.boundingRectWithSize(CGSizeMake(maxWidth, 44), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(17)], context: nil).size.width
        
        let labelSpaceX = (maxWidth - textWidth) / 2
        //设置文字
        titleLabel!.text = text
        //
        titleLabel?.frame = CGRectMake(space + labelSpaceX, 0, textWidth, 44)
        titleLabel?.textAlignment = .Center
        
        imgView?.frame = CGRectMake(((titleLabel?.frame.origin.x)! + margin + textWidth), 11, iconWidth, iconWidth)
    }
    
    func tapClick()
    {
        if clickClosure != nil && listModel?.title_link != nil
        {
            clickClosure!((listModel?.title_link)!)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
















