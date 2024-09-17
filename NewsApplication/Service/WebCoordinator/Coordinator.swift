//
//  Coordinator.swift
//  NewsApp
//
//  Created by Ayush on 16/09/24.
//

import Foundation
import WebKit

class Coordinator: NSObject, WKNavigationDelegate {
    let parent: DetailWebView

    init(_ parent: DetailWebView) {
        self.parent = parent
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Webview started loading.")
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Webview finished loading.")
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("Webview failed with error: \(error.localizedDescription)")
    }
}

