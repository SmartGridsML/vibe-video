//
//  VideoHistoryCard.swift
//  
//
//  Created by Saleem, Bilal on 02/07/2025.
//

struct VideoHistoryCard: View {
    let video: GeneratedVideo
    @State private var showingPlayer = false
    
    var body: some View {
        Button(action: { showingPlayer = true }) {
            VStack(alignment: .leading, spacing: 8) {
                AsyncImage(url: video.thumbnailURL) { image in
                    image
                        .resizable()
                        .aspectRatio(16/9, contentMode: .fill)
                } placeholder: {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .aspectRatio(16/9, contentMode: .fill)
                        .overlay(
                            ProgressView()
                        )
                }
                .frame(height: 100)
                .cornerRadius(8)
                .clipped()
                
                Text(video.prompt)
                    .font(.caption)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
                
                HStack {
                    Text(video.apiUsed.displayName)
                        .font(.caption2)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(video.apiUsed.color.opacity(0.2))
                        .cornerRadius(4)
                    
                    Spacer()
                    
                    Text(video.createdAt, format: .dateTime.day().month().hour().minute())
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            }
        }
        .foregroundColor(.primary)
        .fullScreenCover(isPresented: $showingPlayer) {
            VideoPlayerView(video: video)
        }
    }
}
