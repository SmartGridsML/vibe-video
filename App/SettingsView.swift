//
//  SettingsView.swift
//  
//
//  Created by Saleem, Bilal on 02/07/2025.
//

struct SettingsView: View {
    @EnvironmentObject var videoGenerator: VideoGeneratorViewModel
    @AppStorage("defaultAPI") private var defaultAPI = VideoAPI.runwayML.rawValue
    @AppStorage("videoQuality") private var videoQuality = "HD"
    @AppStorage("autoSaveToPhotos") private var autoSaveToPhotos = false
    
    var body: some View {
        NavigationView {
            Form {
                Section("API Configuration") {
                    ForEach(VideoAPI.allCases, id: \.self) { api in
                        NavigationLink(destination: APIConfigView(api: api)) {
                            HStack {
                                Image(systemName: api.icon)
                                    .foregroundColor(api.color)
                                VStack(alignment: .leading) {
                                    Text(api.displayName)
                                    Text(videoGenerator.isAPIConfigured(api) ? "Configured" : "Not configured")
                                        .font(.caption)
                                        .foregroundColor(videoGenerator.isAPIConfigured(api) ? .green : .red)
                                }
                            }
                        }
                    }
                }
                
                Section("Preferences") {
                    Picker("Default API", selection: $defaultAPI) {
                        ForEach(VideoAPI.allCases, id: \.rawValue) { api in
                            Text(api.displayName).tag(api.rawValue)
                        }
                    }
                    
                    Picker("Video Quality", selection: $videoQuality) {
                        Text("Standard").tag("SD")
                        Text("High Definition").tag("HD")
                        Text("4K").tag("4K")
                    }
                    
                    Toggle("Auto-save to Photos", isOn: $autoSaveToPhotos)
                }
                
                Section("About") {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.secondary)
                    }
                    
                    Button("Clear History") {
                        videoGenerator.clearHistory()
                    }
                    .foregroundColor(.red)
                }
            }
            .navigationTitle("Settings")
        }
    }
}
