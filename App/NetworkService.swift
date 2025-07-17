//
//  NetworkService.swift
//  
//
//  Created by Saleem, Bilal on 02/07/2025.
//

import Foundation

class NetworkService {
    func generateVideo(
        prompt: String,
        api: VideoAPI,
        apiKey: String,
        progressCallback: @escaping (Double, String) -> Void
    ) async throws -> GeneratedVideo {
        
        switch api {
        case .runwayML:
            return try await generateRunwayVideo(prompt: prompt, apiKey: apiKey, progressCallback: progressCallback)
        case .stabilityAI:
            return try await generateStabilityVideo(prompt: prompt, apiKey: apiKey, progressCallback: progressCallback)
        case .pikaLabs:
            return try await generatePikaVideo(prompt: prompt, apiKey: apiKey, progressCallback: progressCallback)
        case .lumaLabs:
            return try await generateLumaVideo(prompt: prompt, apiKey: apiKey, progressCallback: progressCallback)
        case .replicate:
            return try await generateReplicateVideo(prompt: prompt, apiKey: apiKey, progressCallback: progressCallback)
        }
    }
    
    // MARK: - Runway ML Implementation
    private func generateRunwayVideo(
        prompt: String,
        apiKey: String,
        progressCallback: @escaping (Double, String) -> Void
    ) async throws -> GeneratedVideo {
        
        // Submit generation request
        progressCallback(0.2, "Submitting to Runway ML...")
        
        let submitURL = URL(string: "https://api.runwayml.com/v1/video/generate")!
        var submitRequest = URLRequest(url: submitURL)
        submitRequest.httpMethod = "POST"
        submitRequest.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        submitRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody = [
            "prompt": prompt,
            "model": "gen3",
            "aspect_ratio": "16:9",
            "duration": 10
        ]
        
        submitRequest.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
        
        let (submitData, _) = try await URLSession.shared.data(for: submitRequest)
        let submitResponse = try JSONSerialization.jsonObject(with: submitData) as! [String: Any]
        
        guard let taskId = submitResponse["id"] as? String else {
            throw VideoGenerationError.invalidResponse
        }
        
        // Poll for completion
        return try await pollForCompletion(
            taskId: taskId,
            apiKey: apiKey,
            api: .runwayML,
            prompt: prompt,
            progressCallback: progressCallback
        )
    }
    
    // MARK: - Stability AI Implementation
    private func generateStabilityVideo(
        prompt: String,
        apiKey: String,
        progressCallback: @escaping (Double, String) -> Void
    ) async throws -> GeneratedVideo {
        
        progressCallback(0.2, "Submitting to Stability AI...")
        
        let submitURL = URL(string: "https://api.stability.ai/v2beta/video/generate")!
        var submitRequest = URLRequest(url: submitURL)
        submitRequest.httpMethod = "POST"
        submitRequest.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        submitRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody = [
            "prompt": prompt,
            "aspect_ratio": "16:9",
            "duration": 5,
            "fps": 24
        ]
        
        submitRequest.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
        
        let (submitData, _) = try await URLSession.shared.data(for: submitRequest)
        let submitResponse = try JSONSerialization.jsonObject(with: submitData) as! [String: Any]
        
        guard let taskId = submitResponse["id"] as? String else {
            throw VideoGenerationError.invalidResponse
        }
        
        return try await pollForCompletion(
            taskId: taskId,
            apiKey: apiKey,
            api: .stabilityAI,
            prompt: prompt,
            progressCallback: progressCallback
        )
    }
    
    // MARK: - Pika Labs Implementation
    private func generatePikaVideo(
        prompt: String,
        apiKey: String,
        progressCallback: @escaping (Double, String) -> Void
    ) async throws -> GeneratedVideo {
        
        progressCallback(0.2, "Submitting to Pika Labs...")
        
        // Note: Pika Labs API is limited - this is a placeholder implementation
        // You would need to implement their actual API when available
        
        let submitURL = URL(string: "https://api.pika.art/v1/generate")!
        var submitRequest = URLRequest(url: submitURL)
        submitRequest.httpMethod = "POST"
        submitRequest.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        submitRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody = [
            "prompt": prompt,
            "style": "realistic",
            "duration": 3
        ]
        
        submitRequest.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
        
        // Simulate API call for now
        try await Task.sleep(nanoseconds: 1_000_000_000)
        progressCallback(0.5, "Processing with Pika Labs...")
        try await Task.sleep(nanoseconds: 2_000_000_000)
        progressCallback(0.9, "Finalizing video...")
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        // Return mock video for demonstration
        return GeneratedVideo(
            prompt: prompt,
            videoURL: URL(string: "https://sample-videos.com/zip/10/mp4/SampleVideo_1280x720_1mb.mp4")!,
            thumbnailURL: nil,
            apiUsed: .pikaLabs
        )
    }
    
    // MARK: - Luma Labs Implementation
    private func generateLumaVideo(
        prompt: String,
        apiKey: String,
        progressCallback: @escaping (Double, String) -> Void
    ) async throws -> GeneratedVideo {
        
        progressCallback(0.2, "Submitting to Luma Dream Machine...")
        
        let submitURL = URL(string: "https://api.lumalabs.ai/dream-machine/v1/generations")!
        var submitRequest = URLRequest(url: submitURL)
        submitRequest.httpMethod = "POST"
        submitRequest.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        submitRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody = [
            "prompt": prompt,
            "aspect_ratio": "16:9",
            "loop": false
        ]
        
        submitRequest.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
        
        let (submitData, _) = try await URLSession.shared.data(for: submitRequest)
        let submitResponse = try JSONSerialization.jsonObject(with: submitData) as! [String: Any]
        
        guard let taskId = submitResponse["id"] as? String else {
            throw VideoGenerationError.invalidResponse
        }
        
        return try await pollForCompletion(
            taskId: taskId,
            apiKey: apiKey,
            api: .lumaLabs,
            prompt: prompt,
            progressCallback: progressCallback
        )
    }
    
    // MARK: - Replicate Implementation
    private func generateReplicateVideo(
        prompt: String,
        apiKey: String,
        progressCallback: @escaping (Double, String) -> Void
    ) async throws -> GeneratedVideo {
        
        progressCallback(0.2, "Submitting to Replicate...")
        
        let submitURL = URL(string: "https://api.replicate.com/v1/predictions")!
        var submitRequest = URLRequest(url: submitURL)
        submitRequest.httpMethod = "POST"
        submitRequest.setValue("Token \(apiKey)", forHTTPHeaderField: "Authorization")
        submitRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody = [
            "version": "stable-video-diffusion-img2vid-xt",
            "input": [
                "prompt": prompt,
                "num_frames": 25,
                "fps": 6
            ]
        ]
        
        submitRequest.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
        
        let (submitData, _) = try await URLSession.shared.data(for: submitRequest)
        let submitResponse = try JSONSerialization.jsonObject(with: submitData) as! [String: Any]
        
        guard let predictionURL = submitResponse["urls"]?["get"] as? String else {
            throw VideoGenerationError.invalidResponse
        }
        
        return try await pollReplicatePrediction(
            predictionURL: predictionURL,
            apiKey: apiKey,
            prompt: prompt,
            progressCallback: progressCallback
        )
    }
    
    // MARK: - Helper Methods
    private func pollForCompletion(
        taskId: String,
        apiKey: String,
        api: VideoAPI,
        prompt: String,
        progressCallback: @escaping (Double, String) -> Void
    ) async throws -> GeneratedVideo {
        
        let baseURL: String
        switch api {
        case .runwayML:
            baseURL = "https://api.runwayml.com/v1/video/\(taskId)"
        case .stabilityAI:
            baseURL = "https://api.stability.ai/v2beta/video/\(taskId)"
        case .lumaLabs:
            baseURL = "https://api.lumalabs.ai/dream-machine/v1/generations/\(taskId)"
        default:
            throw VideoGenerationError.unsupportedAPI
        }
        
        let pollURL = URL(string: baseURL)!
        var pollRequest = URLRequest(url: pollURL)
        pollRequest.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        var attempts = 0
        let maxAttempts = 60 // 5 minutes with 5-second intervals
        
        while attempts < maxAttempts {
            try await Task.sleep(nanoseconds: 5_000_000_000) // 5 seconds
            attempts += 1
            
            let progress = 0.3 + (Double(attempts) / Double(maxAttempts)) * 0.6
            progressCallback(progress, "Generating video... (\(attempts * 5)s)")
            
            do {
                let (data, _) = try await URLSession.shared.data(for: pollRequest)
                let response = try JSONSerialization.jsonObject(with: data) as! [String: Any]
                
                let status = response["status"] as? String ?? "unknown"
                
                if status == "completed" || status == "succeeded" {
                    progressCallback(1.0, "Video generation complete!")
                    
                    guard let videoURL = response["video_url"] as? String ?? response["output"] as? String,
                          let url = URL(string: videoURL) else {
                        throw VideoGenerationError.invalidResponse
                    }
                    
                    let thumbnailURL = response["thumbnail_url"] as? String
                    
                    return GeneratedVideo(
                        prompt: prompt,
                        videoURL: url,
                        thumbnailURL: thumbnailURL != nil ? URL(string: thumbnailURL!) : nil,
                        apiUsed: api
                    )
                } else if status == "failed" || status == "error" {
                    let error = response["error"] as? String ?? "Unknown error"
                    throw VideoGenerationError.generationFailed(error)
                }
            } catch {
                if attempts == maxAttempts {
                    throw error
                }
            }
        }
        
        throw VideoGenerationError.timeout
    }
    
    private func pollReplicatePrediction(
        predictionURL: String,
        apiKey: String,
        prompt: String,
        progressCallback: @escaping (Double, String) -> Void
    ) async throws -> GeneratedVideo {
        
        let pollURL = URL(string: predictionURL)!
        var pollRequest = URLRequest(url: pollURL)
        pollRequest.setValue("Token \(apiKey)", forHTTPHeaderField: "Authorization")
        
        var attempts = 0
        let maxAttempts = 60
        
        while attempts < maxAttempts {
            try await Task.sleep(nanoseconds: 5_000_000_000)
            attempts += 1
            
            let progress = 0.3 + (Double(attempts) / Double(maxAttempts)) * 0.6
            progressCallback(progress, "Generating with Replicate... (\(attempts * 5)s)")
            
            do {
                let (data, _) = try await URLSession.shared.data(for: pollRequest)
                let response = try JSONSerialization.jsonObject(with: data) as! [String: Any]
                
                let status = response["status"] as? String ?? "unknown"
                
                if status == "succeeded" {
                    progressCallback(1.0, "Video generation complete!")
                    
                    guard let output = response["output"] as? [String],
                          let videoURL = output.first,
                          let url = URL(string: videoURL) else {
                        throw VideoGenerationError.invalidResponse
                    }
                    
                    return GeneratedVideo(
                        prompt: prompt,
                        videoURL: url,
                        thumbnailURL: nil,
                        apiUsed: .replicate
                    )
                } else if status == "failed" {
                    let error = response["error"] as? String ?? "Unknown error"
                    throw VideoGenerationError.generationFailed(error)
                }
            } catch {
                if attempts == maxAttempts {
                    throw error
                }
            }
        }
        
        throw VideoGenerationError.timeout
    }
}
