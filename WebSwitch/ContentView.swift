//
//  ContentView.swift
//  WebSwitch
//
//  Created by Solai Raj Muralidaran on 02/08/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var urlRouter: URLRouter
        
    struct BrowserInfo: Identifiable {
        let id = UUID()
        let bundleIdentifier: String
        let appName: String
        let icon: NSImage?
    }
    
    @State private var browsers: [BrowserInfo] = []
    
    var body: some View {
        VStack {
            LazyHStack() {
                ForEach(browsers, id: \.id) { item in
                               // This defines the content of each grid item (which can be seen as a "cell" in a row)
                               VStack {
                                   if let nsImage = item.icon {
                                       Image(nsImage: nsImage)
                                           .resizable()
                                           .frame(width: 32, height: 32)
                                   }
                                   Text(item.appName)
                               }
                               .padding()
                               .background(Color.blue.opacity(0.2))
                               .cornerRadius(8)
                               .onTapGesture {
                                   if let url = urlRouter.incomingURL {
                                                          openURLInBrowser(url: url, bundleID: item.bundleIdentifier)
                                                      }
                                      }
                           }
            }
        }
        .onAppear(perform: fetchBrowsers)
        .padding()
        .frame(width: 600, height: 150)
    }
    
    func openURLInBrowser(url: URL, bundleID: String) {
           guard let browserURL = NSWorkspace.shared.urlForApplication(withBundleIdentifier: bundleID) else {
               print("Browser not found")
               return
           }

           let config = NSWorkspace.OpenConfiguration()
           config.activates = true

           NSWorkspace.shared.open(
               [url],
               withApplicationAt: browserURL,
               configuration: config,
               completionHandler: { app, error in
                   if let error = error {
                       print("Failed to open URL in browser: \(error)")
                   }
               }
           )
           DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
               NSApplication.shared.keyWindow?.close()
           }
       }
    
    func fetchBrowsers() {
            guard let handlers = LSCopyAllHandlersForURLScheme("http" as CFString)?
                    .takeRetainedValue() as? [String] else {
                return
            }

            var results: [BrowserInfo] = []

            for bundleID in handlers {
                let url = NSWorkspace.shared.urlForApplication(withBundleIdentifier: bundleID)
                let appName = FileManager.default.displayName(atPath: url?.path ?? "")
                let icon = url.flatMap { NSWorkspace.shared.icon(forFile: $0.path) }
                if (appName != "WebSwitch"){
                    results.append(
                        BrowserInfo(bundleIdentifier: bundleID, appName: appName, icon: icon)
                    )
                }
                
            }

            self.browsers = results
        }
}

#Preview {
    ContentView()
}
