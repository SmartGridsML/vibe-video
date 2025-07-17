//
//  VideoGenerationError.swift
//  
//
//  Created by Saleem, Bilal on 17/07/2025.
//


import Foundation

// MARK: - Error Types
enum VideoGenerationError: LocalizedError {
    case invalidResponse
    case generationFailed(String)
    case timeout
    case unsupportedAPI
    
    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Invalid response from API"
        case .generationFailed(let message):
            return "Generation failed: \(message)"
        case .timeout:
            return "Request timed out. Please try again."
        case .unsupportedAPI:
            return "API not supported"
        }
    }
}