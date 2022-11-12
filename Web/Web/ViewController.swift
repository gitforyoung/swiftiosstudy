//
//  ViewController.swift
//  Web
//
//  Created by Wooyoung on 2022/11/12.
//

import UIKit
import WebKit

// 웹뷰 델리게이트를 선언하기 위해 WKNavigationDelegate 추가
class ViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet var txtUrl: UITextField!
    @IBOutlet var myWebView: WKWebView! // import WebKit
    @IBOutlet var myActivityIndicator: UIActivityIndicatorView!
    
    // url 인수를 통해 웹페이지 주소를 받아 웹페이지를 보여주는 함수
    func loadWebPage(_ url: String) {
        let myUrl = URL(string: url)    // url:String -> URL형
        let myRequest = URLRequest(url: myUrl!)
        myWebView.load(myRequest)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 웹뷰가 로딩중인지 살펴보기 위해 델리게이트 선언해야 함.
        myWebView.navigationDelegate = self
        
        // HTTP를 사용하기 위해서는 ATS(App Transport Security)에서 보안에 취약한 네트워크 연결 차단을 해제해야 함
        // Info.plist에서 ATS 추가, 하위에 Allow Arbitrary Loads를 YES로 추가.
        loadWebPage("http://www.naver.com")
    }
    
    // 로딩 중인지 확인하기 위한 함수
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        myActivityIndicator.startAnimating()
        myActivityIndicator.isHidden = false
    }
    
    // 로딩이 완료되었을 때 동작하는 함수
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        myActivityIndicator.stopAnimating()
        myActivityIndicator.isHidden = true
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        myActivityIndicator.stopAnimating()
        myActivityIndicator.isHidden = true
    }
    
    // 홈페이지 주소를 문자열로 받아 확인한 후 다시 문자열로 반환
    func checkUrl(_ url: String) -> String {
        var strUrl = url
        let flag = strUrl.hasPrefix("http://")  // 문자열 앞에 http가 있는지 확인
        if !flag {
            strUrl = "http://" + strUrl
        }
        return strUrl
    }

    @IBAction func btnGotoUrl(_ sender: UIButton) {
        let myUrl = checkUrl(txtUrl.text!)
        txtUrl.text = ""
        loadWebPage(myUrl)
    }
    
    @IBAction func btnGoSite1(_ sender: UIButton) {
        loadWebPage("http://fallinmac.tistory.com")
    }
    
    @IBAction func btnGoSite2(_ sender: UIButton) {
        loadWebPage("http://blog.2sam.net")
    }
    
    @IBAction func btnLoadHtmlString(_ sender: UIButton) {
        let htmlString = "<h1> HTML String </h1><p> String 변수를 이용한 웹 페이지 </p><p><a href=\"http://2sam.net\">2sam</a>으로 이동</p>"
        myWebView.loadHTMLString(htmlString, baseURL: nil)
    }
    
    @IBAction func btnLoadHtmlFile(_ sender: UIButton) {
        let filePath = Bundle.main.path(forResource: "htmlView", ofType: "html")    // htmlView.html 파일에 대한 path 변수 생성
        let myUrl = URL(fileURLWithPath: filePath!)
        let myRequest = URLRequest(url: myUrl)
        myWebView.load(myRequest)
    }
    
    @IBAction func btnStop(_ sender: UIBarButtonItem) {
        // 웹뷰 로딩 중지시키는 함수 호출
        myWebView.stopLoading()
    }
    
    @IBAction func btnReload(_ sender: UIBarButtonItem) {
        // 웹뷰 리로딩 함수 호출
        myWebView.reload()
    }
    
    @IBAction func btnGoBack(_ sender: UIBarButtonItem) {
        myWebView.goBack()
    }
    
    @IBAction func btnGoForward(_ sender: UIBarButtonItem) {
        myWebView.goForward()
    }
}

