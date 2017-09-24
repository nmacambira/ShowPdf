//
//  WebViewController.swift
//  ShowPdf
//
//  Created by Natalia Macambira on 23/09/17.
//  Copyright © 2017 Natalia Macambira. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var documentsTitleLabel: UILabel!
    @IBOutlet weak var webView: UIWebView!
    
    var urlRequest: URLRequest?

    override func viewDidLoad() {
        super.viewDidLoad()
               
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        self.automaticallyAdjustsScrollViewInsets = false
        webView.delegate = self
        webView.scalesPageToFit = true
        
        /*
         let requestURL = URL(string: url)
         let request = URLRequest(URL: requestURL!)
         webView.loadRequest(request)
         
         OR
         
         if let bundleUrl = Bundle.main.url(forResource: "document", withExtension: "pdf", subdirectory: nil, localization: nil)  {
            let request = NSURLRequest(URL: bundleUrl)
            webView.loadRequest(request)
         }
         */
        
        loadWebView()
        
        let refreshController: UIRefreshControl = UIRefreshControl()
        refreshController.addTarget(self, action: #selector(refreshWebView(_:)), for: .valueChanged)
        webView.scrollView.addSubview(refreshController)
    }
    
    func loadWebView() {
        if let url = urlRequest {
            let fileName = url.url?.lastPathComponent.replacingOccurrences(of: ".pdf", with: "")
            documentsTitleLabel.text = fileName ?? ""
            webView.loadRequest(url)
        }
    }
    
    func refreshWebView(_ refresh: UIRefreshControl){
        loadWebView()
        refresh.endRefreshing()
    }    
    
    // MARK: Action
    
    @IBAction func doneButton(_ sender: UIButton) {        
        dismiss(animated: true, completion: nil)
    }   
}

extension WebViewController: UIWebViewDelegate {
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        if(!webView.isLoading) {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        print("Webview fail with error \(error.localizedDescription)")
        
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
