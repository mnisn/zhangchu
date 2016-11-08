//
//  RecipIngredientsCell.swift
//  zhangchu
//
//  Created by 苏宁 on 2016/11/2.
//  Copyright © 2016年 suning. All rights reserved.
//

import UIKit
import Kingfisher

class RecipIngredientsCell: UITableViewCell {
    
    var clickClosure:RecipClickClosure?
    
    var cellModel:RecipIngredientsType? {
        didSet{
            if cellModel != nil
            {
                for i in contentView.subviews
                {
                    i.removeFromSuperview()
                }
            }
            
            showData()
        }
    }
    
    //
    class private var titleHeight:CGFloat
    {
        return 20
    }
    class private var space:CGFloat
    {
        return 10
    }
    
    class private var btnHeight:CGFloat
    {
        return 44
    }
    class private var col:CGFloat
    {
        return 5
    }
    class private var btnWidth:CGFloat
    {
        return (screenWidth - (col + 1) * space) / col
    }
    
    func showData()
    {
        //
        let titleLabel = UILabel.createLabel(cellModel!.text, textAlignment: .Center, font: UIFont.systemFontOfSize(16))
        contentView.addSubview(titleLabel)
        
        titleLabel.snp_makeConstraints {
            (make) in
            make.left.top.equalTo(RecipIngredientsCell.space)
            make.height.equalTo(RecipIngredientsCell.titleHeight)
            make.right.equalTo(-RecipIngredientsCell.space)
        }
        
        //
        let typeImgView = UIImageView()
        typeImgView.kf_setImageWithURL(NSURL(string: (cellModel?.image)!),placeholderImage: UIImage(named:"sdefaultImage"))
        contentView.addSubview(typeImgView)
        
        typeImgView.snp_makeConstraints {
            (make) in
            make.left.equalTo(RecipIngredientsCell.space)
            make.top.equalTo(RecipIngredientsCell.space * 2 + RecipIngredientsCell.titleHeight)
            make.width.equalTo(RecipIngredientsCell.btnWidth * 2 + RecipIngredientsCell.space)
            make.height.equalTo(RecipIngredientsCell.btnHeight * 2 + RecipIngredientsCell.space)
        }
        //
        if cellModel?.data?.count > 0
        {
            for i in 0 ..< (cellModel?.data?.count)!
            {
                //
                let model = cellModel!.data![i]
                
                let btn = RecipIngredientsBtn()
                btn.model = model
                contentView.addSubview(btn)
                
                btn.addTarget(self, action: #selector(btnClick(_:)), forControlEvents: .TouchUpInside)
                
                //
                if i < 6
                {
                    //
                    let subrow = i / Int(RecipIngredientsCell.col - 2)
                    let subcol = i % Int(RecipIngredientsCell.col - 2)
                    btn.snp_makeConstraints(closure: {
                        (make) in
                        let l = RecipIngredientsCell.btnWidth * 2 + RecipIngredientsCell.space * 3 + (RecipIngredientsCell.btnWidth + RecipIngredientsCell.space) * CGFloat(subcol)
                        make.left.equalTo(l)
                        let t = RecipIngredientsCell.titleHeight + RecipIngredientsCell.space * 2 + (RecipIngredientsCell.btnHeight + RecipIngredientsCell.space) * CGFloat(subrow)
                        make.top.equalTo(t)
                        make.width.equalTo(RecipIngredientsCell.btnWidth)
                        make.height.equalTo(RecipIngredientsCell.btnHeight)
                    })
                }
                else
                {
                    //
                    let subrow = (i - 6) / Int(RecipIngredientsCell.col)
                    let subcol = (i - 6) % Int(RecipIngredientsCell.col)
                    btn.snp_makeConstraints(closure: {
                        (make) in
                        make.left.equalTo(RecipIngredientsCell.space + (RecipIngredientsCell.space + RecipIngredientsCell.btnWidth) * CGFloat(subcol))
                        make.top.equalTo(typeImgView.snp_bottom).offset(RecipIngredientsCell.space + (RecipIngredientsCell.space + RecipIngredientsCell.btnHeight) * CGFloat(subrow))
                        make.width.equalTo(RecipIngredientsCell.btnWidth)
                        make.height.equalTo(RecipIngredientsCell.btnHeight)
                    })
                }
            }
        }
    }
    
    //计算cell高度
    class func heightForCellWithModel(typeModel:RecipIngredientsType) ->CGFloat
    {
        //
        var height = RecipIngredientsCell.space * 2 + RecipIngredientsCell.titleHeight + (RecipIngredientsCell.btnHeight + RecipIngredientsCell.space) * 2
        if typeModel.data?.count > 6
        {
            var subrow = ((typeModel.data?.count)! - 6) / Int(RecipIngredientsCell.col)
            let tmpNum = ((typeModel.data?.count)! - 6) % Int(RecipIngredientsCell.col)
            if tmpNum > 0
            {
                subrow += 1
            }
            height += (RecipIngredientsCell.space + RecipIngredientsCell.btnHeight) * CGFloat(subrow)
        }
        
        return height
    }
    
    func btnClick(btn:RecipIngredientsBtn)
    {
        let tmpModel = btn.model
        if tmpModel != nil && clickClosure != nil
        {
            let url = "app://ingredients#\((tmpModel?.id)!)#"
            clickClosure!(url)
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

class RecipIngredientsBtn:UIControl
{
    private var titleLabel:UILabel?
    
    var model:RecipIngredientsSubType? {
        didSet{
            titleLabel?.text = model?.text
        }
    }
    
    init() {
        super.init(frame: CGRectZero)
        titleLabel = UILabel.createLabel(nil, textAlignment: .Center, font: UIFont.systemFontOfSize(15))
        titleLabel?.numberOfLines = 0
        addSubview(titleLabel!)
        
        //
        titleLabel?.snp_makeConstraints(closure: {
            (make) in
            make.edges.equalTo(self)
        })
        
        backgroundColor = UIColor.lightGrayColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}