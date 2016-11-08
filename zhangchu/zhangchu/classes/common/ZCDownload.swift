//
//  ZCDownload.swift
//  zhangchu
//
//  Created by 苏宁 on 2016/10/24.
//  Copyright © 2016年 suning. All rights reserved.
//

import UIKit
import Alamofire

protocol ZCDownloadDelegate:NSObjectProtocol {
    //下载失败
    func download(download:ZCDownload, didFailWithError error:NSError)
    //下载成功
    func download(download:ZCDownload, didFinishWithData data:NSData?)
}

enum DownloadType:Int {
    case Normal = 0
    case Recommend
    case Ingredients
    case Classify
    
    case FoodCourseDetail
    case FoodCourseComment
}

class ZCDownload: NSObject {
    
    weak var delegate:ZCDownloadDelegate?
    
    var downloadType: DownloadType = .Normal
    
    //POST
    func postWithUrl(urlString:String, params:[String:AnyObject])
    {
        var tmpParams = NSDictionary(dictionary: params) as! [String:AnyObject]
        //token=8ABD36C80D1639D9E81130766BE642B7&user_id=1386387&version=4.32
        tmpParams["token"] = ""
        tmpParams["user_id"] = ""
        tmpParams["version"] = 4.5
        
        Alamofire.request(.POST, urlString, parameters: tmpParams, encoding: ParameterEncoding.URL, headers: nil).responseData {
            (response) in
            switch response.result {
            case .Failure(let error):
                self.delegate?.download(self, didFailWithError: error)
            case .Success:
                self.delegate?.download(self, didFinishWithData: response.data)
            }
        }
    }
}
