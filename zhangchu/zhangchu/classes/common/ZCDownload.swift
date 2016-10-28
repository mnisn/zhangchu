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

class ZCDownload: NSObject {
    
    weak var delegate:ZCDownloadDelegate?
    
    //POST
    func postWithUrl(urlString:String, params:[String:AnyObject])
    {
        Alamofire.request(.POST, urlString, parameters: params, encoding: ParameterEncoding.URL, headers: nil).responseData {
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
