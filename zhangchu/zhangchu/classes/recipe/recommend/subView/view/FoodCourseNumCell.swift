//
//  FoodCourseNumCell.swift
//  zhangchu
//
//  Created by 苏宁 on 2016/11/4.
//  Copyright © 2016年 suning. All rights reserved.
//

import UIKit

class FoodCourseNumCell: UITableViewCell {
    
    //集数
    var courseNum:Int?{
        didSet{
            if courseNum > 0
            {
                showData()
            }
        }
    }
    
    //
    var clickClosure:(Int ->())?
    //设置选中按钮的序号
    var selectIndex:Int = -1 {
        didSet{
            if oldValue >= 0
            {
                //取消以前按钮的选中
                let lastBtn = contentView.viewWithTag(200 + oldValue) as! UIButton
                lastBtn.backgroundColor = UIColor.lightGrayColor()
                lastBtn.setTitleColor(UIColor.lightTextColor(), forState: .Normal)
            }
            
            if selectIndex >= 0
            {
                //选中当前按钮
                let curBtn = contentView.viewWithTag(200 + selectIndex) as! UIButton
                curBtn.backgroundColor = UIColor.orangeColor()
                curBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            }
            
        }
    }
    
    //左右间距
    class private var space:CGFloat
    {
        return 15
    }
    
    //
    class private var spaceX:CGFloat
    {
        return 2
    }
    
    //
    class private var spaceY:CGFloat
    {
        return 5
    }
    
    //列数
    class private var colCount:Int
    {
        return 8
    }
    
    //宽
    class private var btnWidth:CGFloat
    {
        return (screenWidth - space * 2 - spaceX * CGFloat(colCount - 1)) / CGFloat(colCount)
    }
    
    //高
    class private var btnHeight:CGFloat
    {
        return (screenWidth - space * 2 - spaceX * CGFloat(colCount - 1)) / CGFloat(colCount)
    }
    
    
    func showData()
    {
        //
        for i in contentView.subviews
        {
            i.removeFromSuperview()
        }
        
        for i in 0 ..< courseNum!
        {
            let title = "\(i + 1)"
            let btn = UIButton.createButton(title, bgImgName: nil, highlightImgName: nil, selectImgName: nil, target: self, action: #selector(btnClick(_:)))
            contentView.addSubview(btn)
            btn.tag = 200 + i
            btn.backgroundColor = UIColor.lightGrayColor()
            btn.setTitleColor(UIColor.lightTextColor(), forState: .Normal)
            
            btn.snp_makeConstraints(closure: {
                (make) in
                make.width.equalTo(FoodCourseNumCell.btnWidth)
                make.height.equalTo(FoodCourseNumCell.btnHeight)
                
                let row = i / FoodCourseNumCell.colCount
                let col = i % FoodCourseNumCell.colCount
                make.top.equalTo(FoodCourseNumCell.spaceY + (FoodCourseNumCell.btnHeight + FoodCourseNumCell.spaceY) * CGFloat(row))
                make.left.equalTo(FoodCourseNumCell.space + (FoodCourseNumCell.btnWidth + FoodCourseNumCell.spaceX) * CGFloat(col))
            })
        }
    }
    
    //计算高度
    class func heightForNumCell(num:Int) ->CGFloat
    {
        var row = num / FoodCourseNumCell.colCount
        
        if num % FoodCourseNumCell.colCount > 0
        {
            row += 1
        }
        return CGFloat(row) * (FoodCourseNumCell.spaceY + FoodCourseNumCell.btnHeight + FoodCourseNumCell.spaceY)
    }
    
    func btnClick(btn:UIButton)
    {
        let index = btn.tag - 200
        if selectIndex != index
        {
            selectIndex = index
            
            if clickClosure != nil
            {
                clickClosure!(selectIndex)
            }
        }
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
