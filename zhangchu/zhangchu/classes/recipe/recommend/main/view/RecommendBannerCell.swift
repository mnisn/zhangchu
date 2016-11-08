//
//  RecommendBannerCell.swift
//  zhangchu
//
//  Created by 苏宁 on 2016/10/25.
//  Copyright © 2016年 suning. All rights reserved.
//

import UIKit

class RecommendBannerCell: UITableViewCell {
    
    var clickClosure:RecipClickClosure?
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    //
    var bannerArray:[RecipeRecommendBanner]?
    {
        didSet{
            //
            createData()
        }
    }

    private func createData()
    {
        //注意:滚动视图系统默认添加了一些子视图,删除子视图时要考虑一下会不会影响这些子视图
        
        //删除滚动视图之前的子视图
        for sub in scrollView.subviews {
            sub.removeFromSuperview()
        }
        
        //
        if bannerArray?.count > 0
        {
            //加约束
            //容器视图
            let contentView = UIView.createView()
            scrollView.addSubview(contentView)
            contentView.snp_makeConstraints(closure: {
                [weak self](make) in
                make.edges.equalTo(self!.scrollView)
                make.height.equalTo(self!.scrollView)
                })
            
            //
            var lastView:UIView? = nil
            
            for i in 0 ..< bannerArray!.count
            {
                let model = bannerArray![i]
                //
                let tmpImgView = UIImageView()
                tmpImgView.kf_setImageWithURL(NSURL(string: model.banner_picture!), placeholderImage: UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                contentView.addSubview(tmpImgView)
                
                //
                tmpImgView.userInteractionEnabled = true
                tmpImgView.tag = 350 + i
                let tap = UITapGestureRecognizer(target: self, action: #selector(imgTapClick(_:)))
                tmpImgView.addGestureRecognizer(tap)
                
                //
                tmpImgView.snp_makeConstraints(closure: {
                    [weak self](make) in
                    make.top.bottom.equalTo(contentView)
                    make.width.equalTo(self!.scrollView)
                    if lastView == nil
                    {
                        make.left.equalTo(contentView)
                    }
                    else
                    {
                       make.left.equalTo((lastView?.snp_right)!)
                    }
                })
                
                lastView = tmpImgView
            }
            
            //
            contentView.snp_makeConstraints(closure: {
                (make) in
                make.right.equalTo(lastView!)
            })
            
            //
            pageControl.numberOfPages = (bannerArray?.count)!
            
            //xib设置代理
            
            scrollView.showsHorizontalScrollIndicator = false
        }
    }
    
    func imgTapClick(tap:UITapGestureRecognizer)
    {
        let index = (tap.view?.tag)! - 350
        //
        let banner = bannerArray![index]
        
        if clickClosure != nil && banner.banner_link != nil
        {
            clickClosure!(banner.banner_link!)
        }
    }
    
    //创建cell方法
    class func createBannerCell(tableView:UITableView, atIndexPath indexPath:NSIndexPath, bannerArray:[RecipeRecommendBanner]?) ->RecommendBannerCell
    {
        let cellID = "recommendBannerCell"
        //这里要写as❓
        var cell = tableView.dequeueReusableCellWithIdentifier(cellID) as? RecommendBannerCell
        if nil == cell
        {
            //这里要写as❓
            cell = NSBundle.mainBundle().loadNibNamed("RecommendBannerCell", owner: nil, options: nil).last as? RecommendBannerCell
        }
        cell!.bannerArray = bannerArray
        
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

extension RecommendBannerCell:UIScrollViewDelegate
{
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x / scrollView.bounds.size.width
        pageControl.currentPage = Int(index)
    }
}













