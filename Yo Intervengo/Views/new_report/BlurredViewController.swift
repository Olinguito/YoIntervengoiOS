//
//  BlurredViewController.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 5/9/16.
//  Copyright © 2016 Olinguito. All rights reserved.
//

import UIKit

public class BlurredViewController: UIViewController {
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clearColor()
        let blurView   = UIVisualEffectView(effect: UIBlurEffect(style: .Light))
        blurView.frame = self.view.bounds
        self.view.addSubview(blurView)
    }
    
    public override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
