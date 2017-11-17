//
//  WebVIewController.swift
//  SampleHTTP
//
//  Created by 松山友也 on 2017/11/17.
//  Copyright © 2017年 Tomoya Matsuyama. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate{
    @IBOutlet weak var webView: UIWebView!
    
    var url: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        print(url)
        let initialUrl = NSURL(string: "https://qiita.com/\(url)")
        self.webView.delegate = self
        let request = NSURLRequest(url: initialUrl! as URL)
        self.webView.loadRequest(request as URLRequest)
    }
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
