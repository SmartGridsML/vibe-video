//
//  VideoHistoryView.swift
//  
//
//  Created by Saleem, Bilal on 02/07/2025.
//

struct VideoHistoryView: View {
    @EnvironmentObject var videoGenerator: VideoGeneratorViewModel
    
    var body: some View {
        NavigationView {
            if videoGenerator.recentVideos.isEmpty {
                EmptyHistoryView()
            } else {
                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 16) {
                        ForEach(videoGenerator.recentVideos) { video in
                            VideoHistoryCard(video: video)
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("Video History")
    }
}
