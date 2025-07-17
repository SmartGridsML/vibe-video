//
//  APIConfigView.swift
//  
//
//  Created by Saleem, Bilal on 16/07/2025.
//


struct APIConfigView: View {
    let api: VideoAPI
    @EnvironmentObject var videoGenerator: VideoGeneratorViewModel
    @State private var apiKey = ""
    @State private var showingKeyInput = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Form {
            Section(header: Text(api.displayName)) {
                VStack(alignment: .leading, spacing: 12) {
                    Text(api.description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    if videoGenerator.isAPIConfigured(api) {
                        Label("API Key Configured", systemImage: "checkmark.circle.fill")
                            .foregroundColor(.green)
                    } else {
                        Label("API Key Required", systemImage: "exclamationmark.circle.fill")
                            .foregroundColor(.orange)
                    }
                }
            }
            
            Section("Configuration") {
                Button(videoGenerator.isAPIConfigured(api) ? "Update API Key" : "Add API Key") {
                    showingKeyInput = true
                }
                
                if videoGenerator.isAPIConfigured(api) {
                    Button("Remove API Key") {
                        videoGenerator.removeAPIKey(for: api)
                    }
                    .foregroundColor(.red)
                }
            }
            
            Section("Setup Instructions") {
                Text(api.setupInstructions)
                    .font(.footnote)
                
                if let url = api.signupURL {
                    Link("Get API Key", destination: url)
                        .font(.footnote)
                        .foregroundColor(.blue)
                }
            }
        }
        .navigationTitle(api.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .alert("Enter API Key", isPresented: $showingKeyInput) {
            TextField("API Key", text: $apiKey)
            Button("Cancel", role: .cancel) { }
            Button("Save") {
                videoGenerator.setAPIKey(apiKey, for: api)
                apiKey = ""
                dismiss()
            }
        }
    }
}