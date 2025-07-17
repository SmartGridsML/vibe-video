//
//  VideoPlayerView.swift
//  
//
//  Created by Saleem, Bilal on 02/07/2025.
//

import AVKit

struct VideoPlayerView: View {
    let video: GeneratedVideo
    @Environment(\.dismiss) private var dismiss
    @State private var player: AVPlayer?
    
    var body: some View {
        NavigationView {
            VStack {
                if let player = player {
                    VideoPlayer(player: player)
                        .onAppear {
                            player.play()
                        }
                } else {
                    ProgressView("Loading video...")
                }
            }
            .navigationTitle(video.prompt)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Done") {
                        player?.pause()
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    ShareLink(item: video.videoURL) {
                        Image(systemName: "square.and.arrow.up")
                    }
                }
            }
        }
        .onAppear {
            setupPlayer()
        }
        .onDisappear {
            player?.pause()
        }
    }
    
    private func setupPlayer() {
        player = AVPlayer(url: video.videoURL)
    }
}
