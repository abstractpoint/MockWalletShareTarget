//
//  ShareViewController.swift
//  WalletConnectShare
//
//  Created by George T on 16/11/2019.
//  Copyright © 2019 George T. All rights reserved.
//

import UIKit
import Social

class ShareViewController: UIViewController {
    //MARK: Properties
    @IBOutlet var labelURL: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // only apply the blur if the user hasn't disabled transparency effects
        if UIAccessibility.isReduceTransparencyEnabled == false {
            view.backgroundColor = .clear

            let blurEffect = UIBlurEffect(style: .light)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            //always fill the view
            blurEffectView.frame = self.view.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

            view.insertSubview(blurEffectView, at: 0)
        } else {
            view.backgroundColor = .white
        }
        print("view rendered");
        debugPrint("view rendered");
        
        if let item = extensionContext?.inputItems.first as? NSExtensionItem {
            if let attachments = item.attachments {
            for itemProvider: NSItemProvider in attachments {
            if itemProvider.hasItemConformingToTypeIdentifier("public.url") {
                itemProvider.loadItem(forTypeIdentifier: "public.url", options: nil, completionHandler: { (url, error) -> Void in
                    if let shareURL = url as? NSURL {
                        // do what you want to do with shareURL
                        print(shareURL);
                        self.labelURL.text = shareURL.absoluteString
                    }
                    self.extensionContext?.completeRequest(returningItems: [], completionHandler:nil)
                })
            }
            }
            }
        }
        
        // Do any additional setup after loading the view.
    }

}
