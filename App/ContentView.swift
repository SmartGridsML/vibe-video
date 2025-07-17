import SwiftUI
import AVKit

struct ContentView: View {
    @StateObject private var videoGenerator = VideoGeneratorViewModel()
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            GenerateVideoView()
                .environmentObject(videoGenerator)
                .tabItem {
                    Image(systemName: "video.badge.plus")
                    Text("Generate")
                }
                .tag(0)
            
            VideoHistoryView()
                .environmentObject(videoGenerator)
                .tabItem {
                    Image(systemName: "clock")
                    Text("History")
                }
                .tag(1)
            
            SettingsView()
                .environmentObject(videoGenerator)
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
                .tag(2)
        }
        .accentColor(.purple)
    }
}
