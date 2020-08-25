//
//  ViewController.swift
//  MyBrowser
//
//  Created by Татьяна Кочетова on 25.08.2020.
//  Copyright © 2020 Nikita Kochetov. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    @IBOutlet var webView: WKWebView!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var forwardButton: UIButton!
    @IBOutlet var urlTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        urlTextField.delegate = self
        webView.navigationDelegate = self
        
        let homePage = "https://www.apple.com"
        let url = URL(string: homePage)
        let request = URLRequest(url: url!)
        
        urlTextField.text = homePage
        
        
        webView.load(request)
        webView.allowsBackForwardNavigationGestures = true
    }
    @IBAction func backButtonAction(_ sender: UIButton) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    @IBAction func forwardButtonAction(_ sender: UIButton) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
}

extension ViewController: UITextFieldDelegate, WKNavigationDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let urlString = textField.text!
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        
        webView.load(request)
        
        textField.resignFirstResponder()
        
        return true
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        urlTextField.text = webView.url?.absoluteString
        
        backButton.isEnabled = webView.canGoBack
        forwardButton.isEnabled = webView.canGoForward
        
    }
}

