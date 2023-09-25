//
//  WebViewController.swift
//  GitHubUsersClientApp
//
//  Created by ふりかけ on R 5/09/26.
//

import UIKit
import WebKit

protocol WebView: AnyObject {
    func updateWebView()
    func reloadWebView()
    func stopWebView()

}

class WebViewController: UIViewController, WKUIDelegate, WKNavigationDelegate, UIScrollViewDelegate {
    
    var webURL: URL!
    
    @IBOutlet weak var webView:WKWebView!
    
    var presenter: WebPresenter?
    
    func setPresenter(presenter: WebPresenter) {
        self.presenter = presenter
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        WebUserRouter.create(view: self)
        presenter?.viewDidLoad()
        
        webView.scrollView.showsHorizontalScrollIndicator = false
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.delegate = self
        webView.configuration.userContentController.addUserScript(getZoomDisableScript())

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(_ url: URL) {
        super.init(nibName: nil, bundle: nil)
        self.webURL = url
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
        webView.navigationDelegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter?.viewWillDisappear()
        webView.navigationDelegate = nil


    }
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        scrollView.pinchGestureRecognizer?.isEnabled = false
        self.removeDoubleTapGestureRecognizer(view: webView)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.removeDoubleTapGestureRecognizer(view: webView)
    }
    
    private func getZoomDisableScript() -> WKUserScript {
        let source: String = "var meta = document.createElement('meta');" +
            "meta.name = 'viewport';" +
            "meta.content = 'width=device-width, initial-scale=1.0, maximum- scale=1.0, user-scalable=no';" +
            "var head = document.getElementsByTagName('head')[0];" + "head.appendChild(meta);"
        return WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
    }
    
    private func removeDoubleTapGestureRecognizer(view: UIView) {
        if let gestureRecognizers = view.gestureRecognizers {
            for gestureRecognizer in gestureRecognizers {
                if let tapGestureRecognizer = gestureRecognizer as? UITapGestureRecognizer {
                    if tapGestureRecognizer.numberOfTapsRequired == 2 {
                        view.removeGestureRecognizer(tapGestureRecognizer)
                    }
                }
            }
        }

        for subview in view.subviews {
            self.removeDoubleTapGestureRecognizer(view: subview)
        }
    }

}

extension WebViewController: WebView {
    
    func updateWebView() {
        webView.load(URLRequest(url: webURL))
    }
    
    func reloadWebView() {
        webView.reload()
    }
    
    func stopWebView() {
        webView.stopLoading()
        webView.configuration.userContentController.removeScriptMessageHandler(forName: "...")
    }
    
}

