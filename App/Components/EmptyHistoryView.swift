//
//  EmptyHistoryView.swift
//  
//
//  Created by Saleem, Bilal on 16/07/2025.
//


struct EmptyHistoryView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "video.slash")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            
            Text("No Videos Yet")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Generate your first AI video to see it here")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}
