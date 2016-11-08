//
//  VideoService.swift
//  zhangchu
//
//  Created by 苏宁 on 2016/11/3.
//  Copyright © 2016年 suning. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class VideoService: NSObject {
    
    class func playVideo(url:String?, onViewController vc:UIViewController)
    {
        if url != nil
        {
            let url = NSURL(string: url!)
            let player = AVPlayer(URL: url!)
            let videoCtrl = AVPlayerViewController()
            videoCtrl.player = player
            
            player.play()
            
            vc.presentViewController(videoCtrl, animated: true, completion: nil)
        }
    }

}
