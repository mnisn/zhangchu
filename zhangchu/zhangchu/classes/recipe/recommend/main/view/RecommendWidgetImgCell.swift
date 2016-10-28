//
//  RecommendWidgetImgCell.swift
//  zhangchu
//
//  Created by 苏宁 on 2016/10/26.
//  Copyright © 2016年 suning. All rights reserved.
//

import UIKit

class RecommendWidgetImgCell: UITableViewCell {

    var clickClosure:RecipClickClosure?
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var listModel:RecipeRecommendWidgetList? {
        didSet{
            showData()
        }
    }
    
    func showData()
    {
        if listModel!.widget_data?.count > 0
        {
            //
            let contentView = UIView.createView()
            scrollView.addSubview(contentView)
            contentView.snp_makeConstraints(closure: {
                [weak self](make) in
                make.edges.equalTo(self!.scrollView)
                make.height.equalTo(self!.scrollView)
                })
            
            //
            var lastView:UIView? = nil
            for i in 0 ..< (listModel!.widget_data?.count)!
            {
                let data = listModel!.widget_data![i]
                //
                let tmpImgView = UIImageView()
                if data.type == "image"
                {
                    tmpImgView.kf_setImageWithURL(NSURL(string: data.content!), placeholderImage: UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                    contentView.addSubview(tmpImgView)
                    
                    tmpImgView.userInteractionEnabled = true
                    tmpImgView.tag = 450 + i
                    let tap = UITapGestureRecognizer(target: self, action: #selector(imgTapClick(_:)))
                    tmpImgView.addGestureRecognizer(tap)
                    
                    tmpImgView.snp_makeConstraints(closure: {
                        (make) in
                        make.top.bottom.equalTo(contentView)
                        make.width.equalTo(210)
                        
                        if i == 0
                        {
                            make.left.equalTo(contentView)
                        }
                        else
                        {
                            make.left.equalTo((lastView?.snp_right)!)
                        }
                    })
                    //
                    lastView = tmpImgView
                }
            }
            
            //
            contentView.snp_makeConstraints(closure: {
                (make) in
                make.right.equalTo(lastView!)
            })
            
            scrollView.showsHorizontalScrollIndicator = false
            
        }
    }
    
    func imgTapClick(tap:UITapGestureRecognizer)
    {
        let index = (tap.view?.tag)! - 450
        let data = listModel?.widget_data![index]
        if clickClosure != nil && data?.link != nil
        {
            clickClosure!((data?.link)!)
        }
    }
    
    //创建cell
    class func createWidgetImgCell(tableView: UITableView, atIndexPath indexPath:NSIndexPath, listModel:RecipeRecommendWidgetList?) ->RecommendWidgetImgCell
    {
        let cellID = "RecommendWidgetImgCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellID) as? RecommendWidgetImgCell
        if cell == nil
        {
            cell = NSBundle.mainBundle().loadNibNamed("RecommendWidgetImgCell", owner: nil, options: nil).last as? RecommendWidgetImgCell
        }
        cell?.listModel = listModel!
        return cell!
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
