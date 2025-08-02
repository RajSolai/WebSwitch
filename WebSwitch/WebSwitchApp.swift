//
//  WebSwitchApp.swift
//  WebSwitch
//
//  Created by Solai Raj Muralidaran on 02/08/25.
//

import SwiftUI

class URLRouter: ObservableObject {
    static let shared = URLRouter()
    @Published var incomingURL: URL?
}

@main
struct WebSwitchApp: App {
    @StateObject var urlRouter = URLRouter.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(urlRouter)
                .onOpenURL { url in
                    print("Received URL: \(url.absoluteString)")
                    urlRouter.incomingURL = url
                }
        }
        .windowStyle(.hiddenTitleBar)
        .windowToolbarStyle(.unifiedCompact(showsTitle: false))
        .windowLevel(WindowLevel.floating)
        .defaultSize(width: 400, height: 20)
        
    }
}
