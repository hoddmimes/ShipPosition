//
//  WebView.swift
//  ShipPos
//
//  Created by Pär Bertilsson on 2023-02-13.
//

import SwiftUI
import Foundation
import WebKit

struct WebView : UIViewRepresentable {

    let url: URL
    var webView = WKWebView()
   
    func makeUIView(context: Context) -> WKWebView  {
        let request = URLRequest(url: url)
        webView.load(request)
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.navigationDelegate = context.coordinator
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    //Conform to WKNavigationDelegate protocol here and declare its delegate
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView

        init(_ parent: WebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
            //Navigate to other URL if user clicks on the sign in link
            if navigationAction.request.url?.absoluteString == "https://sso.bytemountains.com/?clientId=2" {
                webView.load(URLRequest(url: URL(string: "https://nu.nl/")!))
            }
            decisionHandler(.allow)
        }
    }
}



struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(url: URL( string: "https://www.hoddmimes.com/shipposition/shipposhelp.html")!).frame(maxWidth: .infinity, maxHeight: .infinity).edgesIgnoringSafeArea(.all)
    }
}
