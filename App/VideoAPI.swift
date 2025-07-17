//
//  VideoAPI.swift
//  
//
//  Created by Saleem, Bilal on 02/07/2025.
//

// MARK: - Models
import Foundation

enum VideoAPI: String, CaseIterable {
    case runwayML = "runway"
    case stabilityAI = "stability"
    case pikaLabs = "pika"
    case lumaLabs = "luma"
    case replicate = "replicate"
    
    var displayName: String {
        switch self {
        case .runwayML: return "Runway ML"
        case .stabilityAI: return "Stability AI"
        case .pikaLabs: return "Pika Labs"
        case .lumaLabs: return "Luma Labs"
        case .replicate: return "Replicate"
        }
    }
    
    var description: String {
        switch self {
        case .runwayML: return "High-quality video generation with excellent motion"
        case .stabilityAI: return "Stable Video Diffusion for consistent results"
        case .pikaLabs: return "Creative video generation with unique styles"
        case .lumaLabs: return "Dream Machine for photorealistic videos"
        case .replicate: return "Multiple AI models via Replicate platform"
        }
    }
    
    var icon: String {
        switch self {
        case .runwayML: return "airplane"
        case .stabilityAI: return "waveform.path"
        case .pikaLabs: return "sparkles"
        case .lumaLabs: return "moon.stars"
        case .replicate: return "arrow.triangle.2.circlepath"
        }
    }
    
    var color: Color {
        switch self {
        case .runwayML: return .blue
        case .stabilityAI: return .green
        case .pikaLabs: return .pink
        case .lumaLabs: return .purple
        case .replicate: return .orange
        }
    }
    
    var setupInstructions: String {
        switch self {
        case .runwayML:
            return """
            1. Visit runwayml.com
            2. Create an account
            3. Go to Settings > API Keys
            4. Generate a new API key
            5. Copy and paste it here
            """
        case .stabilityAI:
            return """
            1. Visit platform.stability.ai
            2. Sign up for an account
            3. Navigate to API Keys section
            4. Create a new API key
            5. Copy and paste it here
            """
        case .pikaLabs:
            return """
            1. Visit pika.art
            2. Join the waitlist or get access
            3. Get your API credentials
            4. Copy and paste your key here
            """
        case .lumaLabs:
            return """
            1. Visit lumalabs.ai
            2. Sign up for Dream Machine
            3. Get API access
            4. Copy your API key here
            """
        case .replicate:
            return """
            1. Visit replicate.com
            2. Create an account
            3. Go to Account > API tokens
            4. Create a new token
            5. Copy and paste it here
            """
        }
    }
    
    var signupURL: URL? {
        switch self {
        case .runwayML: return URL(string: "https://runwayml.com")
        case .stabilityAI: return URL(string: "https://platform.stability.ai")
        case .pikaLabs: return URL(string: "https://pika.art")
        case .lumaLabs: return URL(string: "https://lumalabs.ai")
        case .replicate: return URL(string: "https://replicate.com")
        }
    }
}
