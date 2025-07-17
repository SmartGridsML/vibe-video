//
//  VideoGeneratorViewModel.swift
//  
//
//  Created by Saleem, Bilal on 02/07/2025.
//

// MARK: - View Model
import Combine
import Foundation

@MainActor
class VideoGeneratorViewModel: ObservableObject {
    @Published var isGenerating = false
    @Published var generationProgress: Double = 0.0
    @Published var generationStatus = "Ready to generate"
    @Published var recentVideos: [GeneratedVideo] = []
    @Published var errorMessage: String?
    
    private var apiKeys: [VideoAPI: String] = [:]
    private let networkService = NetworkService()
    
    init() {
        loadStoredData()
    }
    
    func generateVideo(prompt: String, using api: VideoAPI) async {
        guard let apiKey = apiKeys[api] else {
            errorMessage = "API key not configured for \(api.displayName)"
            return
        }
        
        isGenerating = true
        generationProgress = 0.0
        errorMessage = nil
        
        do {
            generationStatus = "Submitting request..."
            generationProgress = 0.1
            
            let video = try await networkService.generateVideo(
                prompt: prompt,
                api: api,
                apiKey: apiKey,
                progressCallback: { [weak self] progress, status in
                    DispatchQueue.main.async {
                        self?.generationProgress = progress
                        self?.generationStatus = status
                    }
                }
            )
            
            recentVideos.insert(video, at: 0)
            saveStoredData()
            
            generationStatus = "Video generated successfully!"
            generationProgress = 1.0
            
        } catch {
            errorMessage = error.localizedDescription
            generationStatus = "Generation failed"
        }
        
        isGenerating = false
    }
    
    func isAPIConfigured(_ api: VideoAPI) -> Bool {
        return apiKeys[api] != nil
    }
    
    func setAPIKey(_ key: String, for api: VideoAPI) {
        apiKeys[api] = key
        saveAPIKeys()
    }
    
    func removeAPIKey(for api: VideoAPI) {
        apiKeys.removeValue(forKey: api)
        saveAPIKeys()
    }
    
    func clearHistory() {
        recentVideos.removeAll()
        saveStoredData()
    }
    
    private func loadStoredData() {
        // Load API keys
        for api in VideoAPI.allCases {
            if let key = UserDefaults.standard.string(forKey: "apiKey_\(api.rawValue)") {
                apiKeys[api] = key
            }
        }
        
        // Load recent videos
        if let data = UserDefaults.standard.data(forKey: "recentVideos"),
           let videos = try? JSONDecoder().decode([GeneratedVideo].self, from: data) {
            recentVideos = videos
        }
    }
    
    private func saveStoredData() {
        if let data = try? JSONEncoder().encode(recentVideos) {
            UserDefaults.standard.set(data, forKey: "recentVideos")
        }
    }
    
    private func saveAPIKeys() {
            for (api, key) in apiKeys {
                UserDefaults.standard.set(key, forKey: "apiKey_\(api.rawValue)")
            }
        }
}
