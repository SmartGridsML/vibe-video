//
//  GeneratedVideo.swift
//  
//
//  Created by Saleem, Bilal on 02/07/2025.
//

struct GeneratedVideo: Identifiable, Codable {
    let id = UUID()
    let prompt: String
    let videoURL: URL
    let thumbnailURL: URL?
    let apiUsed: VideoAPI
    let createdAt: Date
    let duration: TimeInterval?
    
    init(prompt: String, videoURL: URL, thumbnailURL: URL? = nil, apiUsed: VideoAPI, duration: TimeInterval? = nil) {
        self.prompt = prompt
        self.videoURL = videoURL
        self.thumbnailURL = thumbnailURL
        self.apiUsed = apiUsed
        self.createdAt = Date()
        self.duration = duration
    }
}
