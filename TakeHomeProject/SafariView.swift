//
//  SafariView.swift
//  TakeHomeProject
//
//  Created by Holly on 10/23/24.
//

import SwiftUI
import SafariServices

struct WebDestination: Hashable, Identifiable {
    var id: String {
        url.absoluteString
    }
    
    var title: String
    var url: URL
}

struct SafariView: UIViewControllerRepresentable {
    typealias UIViewControllerType = SFSafariViewController
    
    var url: URL
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        
        
        let vc = SFSafariViewController(url: url)
        return vc
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {

    }
    
}

#Preview {
    SafariView(url: URL(string: "https://google.com")!)
}
