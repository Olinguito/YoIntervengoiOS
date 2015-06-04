//
//  Pictures.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 2/4/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit

class Pictures: UIView, PicContainerDelegate {
    var picCont:PicContainer!
    var data:JSON!
    var frame2:CGRect!
    var view:UIView!
    var ms:NSMutableArray!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(index:Int, frame:CGRect, ini:CGFloat, data:JSON) {
        super.init(frame:CGRectZero)
        self.data = data
        frame2 = frame
        ms = NSMutableArray()
        self.backgroundColor = UIColor.whiteColor()
        
        for (index,picture) in enumerate(self.data[0]["pictures"]){
            var pic = Picture()
            pic.id = index
            pic.urlImage = picture.1["url"].string
            pic.desc = String.getDate(picture.1["date"].string!)
            pic.title = picture.1["description"].string
            ms.addObject(pic)
        }
        picCont = PicContainer(frame: CGRect(x: 0, y: 0, width: frame.width, height: ((frame.height - ini))-55), array: ms)
        picCont.delegate = self
        self.addSubview(picCont)
        self.frame = CGRect(x: 0, y: 0, width: frame.width, height: (frame.height - CGFloat(ini))-55)
    }
    
    func reloadData(){
        picCont.collectionView.reloadData()
    }
    
    func picTapped(index: UIButton) {
        var modelsM = NSMutableArray(capacity: ms.count)
        for (var i = 0; i<ms.count; i++){
            var pbModel = PhotoModel()
            var pic = ms.objectAtIndex(i) as! Picture
            pbModel.mid   = i+1
            pbModel.title = pic.title
            pbModel.desc  = pic.desc
            pbModel.image_HD_U = pic.urlImage
            pbModel.sourceImageView = index.imageView
            modelsM.addObject(pbModel)
        }
        PhotoBroswerVC.show(self.parentViewController(), type: PhotoBroswerVCTypePush , index: index.tag, photoModelBlock: modelsM)
    }
    
    func close(sender:UIButton){
        view.removeFromSuperview()
    }
    
}