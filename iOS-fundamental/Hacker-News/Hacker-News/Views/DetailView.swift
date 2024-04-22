//
//  DetailView.swift
//  Hacker-News
//
//  Created by Sunggon Park on 2024/02/29.
//

import SwiftUI

struct DetailView: View {
    let url: String?
    
    var body: some View {
        WebView(urlString: url)
    }
}


#Preview {
    DetailView(url: "https://www.google.com")
}
