//
//  GenerateVideoView.swift
//  
//
//  Created by Saleem, Bilal on 02/07/2025.
//

// MARK: - Video Generation View
import SwiftUI

struct GenerateVideoView: View {
    @EnvironmentObject var videoGenerator: VideoGeneratorViewModel
    @State private var prompt = ""
    @State private var selectedAPI: VideoAPI = .runwayML
    @State private var showingAPISelection = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    VStack(spacing: 8) {
                        Image(systemName: "sparkles.tv")
                            .font(.system(size: 60))
                            .foregroundColor(.purple)
                        
                        Text("AI Video Generator")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text("Transform your ideas into stunning videos")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.top, 20)
                    
                    // API Selection
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Select AI Model")
                            .font(.headline)
                        
                        Button(action: { showingAPISelection = true }) {
                            HStack {
                                Image(systemName: selectedAPI.icon)
                                Text(selectedAPI.displayName)
                                Spacer()
                                Image(systemName: "chevron.down")
                            }
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(12)
                        }
                        .foregroundColor(.primary)
                    }
                    
                    // Prompt Input
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Describe Your Video")
                            .font(.headline)
                        
                        TextEditor(text: $prompt)
                            .frame(minHeight: 120)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.purple.opacity(0.3), lineWidth: 1)
                            )
                        
                        if prompt.isEmpty {
                            Text("Example: A serene sunset over ocean waves with seagulls flying...")
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .padding(.leading, 4)
                        }
                    }
                    
                    // Generation Button
                    Button(action: generateVideo) {
                        HStack {
                            if videoGenerator.isGenerating {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                    .scaleEffect(0.8)
                                Text("Generating...")
                            } else {
                                Image(systemName: "play.circle.fill")
                                Text("Generate Video")
                            }
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            LinearGradient(
                                colors: [.purple, .blue],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(12)
                        .disabled(prompt.isEmpty || videoGenerator.isGenerating)
                    }
                    .opacity(prompt.isEmpty ? 0.6 : 1.0)
                    
                    // Current Generation Status
                    if videoGenerator.isGenerating {
                        GenerationStatusView()
                            .environmentObject(videoGenerator)
                    }
                    
                    // Recent Video Preview
                    if let recentVideo = videoGenerator.recentVideos.first {
                        RecentVideoCard(video: recentVideo)
                    }
                }
                .padding()
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
        .sheet(isPresented: $showingAPISelection) {
            APISelectionView(selectedAPI: $selectedAPI)
        }
        .alert("Error", isPresented: .constant(videoGenerator.errorMessage != nil)) {
            Button("OK") {
                videoGenerator.errorMessage = nil
            }
        } message: {
            Text(videoGenerator.errorMessage ?? "")
        }
    }
    
    private func generateVideo() {
        Task {
            await videoGenerator.generateVideo(prompt: prompt, using: selectedAPI)
        }
    }
}

