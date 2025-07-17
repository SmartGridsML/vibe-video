//
//  RecentVideoCard.swift
//  
//
//  Created by Saleem, Bilal on 16/07/2025.
//


struct RecentVideoCard: View {
    let video: GeneratedVideo
    @State private var showingPlayer = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Latest Generation")
                .font(.headline)
            
            Button(action: { showingPlayer = true }) {
                VStack(spacing: 8) {
                    AsyncImage(url: video.thumbnailURL) { image in
                        image
                            .resizable()
                            .aspectRatio(16/9, contentMode: .fill)
                    } placeholder: {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .aspectRatio(16/9, contentMode: .fill)
                            .overlay(
                                Image(systemName: "play.circle")
                                    .font(.system(size: 40))
                                    .foregroundColor(.white)
                            )
                    }
                    .frame(height: 200)
                    .cornerRadius(12)
                    .clipped()
                    
                    Text(video.prompt)
                        .font(.caption)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                }
            }
            .foregroundColor(.primary)
        }
        .fullScreenCover(isPresented: $showingPlayer) {
            VideoPlayerView(video: video)
        }
    }
}