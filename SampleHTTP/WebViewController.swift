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
        self.webView.delegate = self
        
        let accessUrl = NSURL(string: "https://qiita.com/\(url)")
        let request = NSURLRequest(url: accessUrl! as URL)
        self.webView.loadRequest(request as URLRequest)
    }
}
