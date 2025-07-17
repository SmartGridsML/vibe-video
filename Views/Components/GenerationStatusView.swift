//
//  GenerationStatusView.swift
//  
//
//  Created by Saleem, Bilal on 02/07/2025.
//

struct GenerationStatusView: View {
    @EnvironmentObject var videoGenerator: VideoGeneratorViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            ProgressView(value: videoGenerator.generationProgress)
                .progressViewStyle(LinearProgressViewStyle(tint: .purple))
            
            Text(videoGenerator.generationStatus)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
}
