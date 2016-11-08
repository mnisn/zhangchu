//
//  RecipeSegView.swift
//  zhangchu
//
//  Created by 苏宁 on 2016/11/1.
//  Copyright © 2016年 suning. All rights reserved.
//

import UIKit

protocol RecipeSegViewDelegate:NSObjectProtocol {
    
    //点击事件
    func recipeSegView(recipeSegView: RecipeSegView, didClickBtnAtIndex index:Int)
}

class RecipeSegView: UIView {
    
    //
    weak var delegate:RecipeSegViewDelegate?
    //
    private var lineView:UIImageView?
    
    //设置当前的序号
    var selectIndex:Int = 0 {
        didSet {
            if selectIndex != oldValue
            {
                //取消之前的选中状态
                let lastBtn = viewWithTag(100 + oldValue)
                if lastBtn?.isKindOfClass(RecipeSegBtn) == true {
                    let tmpBtn = lastBtn as! RecipeSegBtn
                    tmpBtn.clicked = false
                }
                
                //选中当前点击的按钮
                let curBtn = viewWithTag(100 + selectIndex)
                if curBtn?.isKindOfClass(RecipeSegBtn) == true {
                    let tmpBtn = curBtn as! RecipeSegBtn
                    tmpBtn.clicked = true
                }
                
                //
                UIView.animateWithDuration(0.2, animations: {
                    [weak self] in
                    self!.lineView?.frame.origin.x = (self!.lineView?.frame.size.width)! * CGFloat(self!.selectIndex)
                })
                
            }
        }
    }
    
    //
    init(frame: CGRect, titleArray:[String]) {
        super.init(frame:frame)
        if titleArray.count > 0
        {
            createBtn(titleArray)
        }
        
    }
    
    func createBtn(titleArray:[String])
    {
        let width = bounds.width / CGFloat(titleArray.count)
        for i in 0 ..<  titleArray.count
        {
            let frame = CGRectMake(width * CGFloat(i), 0, width, bounds.height)
            let btn = RecipeSegBtn(frame: frame)
            //默认选中第一个
            if i == 0 {
                btn.clicked = true
            }else{
                btn.clicked = false
            }
            btn.config(titleArray[i])
            btn.tag = 100 + i
            btn.addTarget(self, action: #selector(btnClick(_:)), forControlEvents: .TouchUpInside)
            
            addSubview(btn)
        }
        //
        lineView = UIImageView(frame: CGRect(x: 0, y: -22, width: width, height: 66))
        lineView?.image = UIImage(named: "navBtn_bag")
        addSubview(lineView!)
    }
    
    func btnClick(btn:RecipeSegBtn)
    {
        let index = btn.tag - 100
        //修改选中的UI
        selectIndex = index
        //
        delegate?.recipeSegView(self, didClickBtnAtIndex: index)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class RecipeSegBtn:UIControl
{
    private var titleLabel:UILabel?
    
    //设置选中状态
    var clicked: Bool = false {
        didSet {
            if clicked == true
            {
                //选中
                titleLabel?.textColor = UIColor.blackColor()
            }else{
                //取消选中
                titleLabel?.textColor = UIColor.lightGrayColor()
            }
        }
    }
    //显示数据
    func config(title:String?)
    {
        titleLabel?.text = title
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel = UILabel.createLabel(nil, textAlignment: .Center, font: UIFont.systemFontOfSize(17))
        titleLabel?.frame = bounds
        addSubview(titleLabel!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
