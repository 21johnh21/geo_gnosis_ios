//
//  AppError.swift
//  geo_gnosis_ios
//
//  Error handling for the application
//

import Foundation

enum AppError: LocalizedError {
    case audioLoadFailed(String)
    case dataLoadFailed(String)
    case insufficientLocations(count: Int, required: Int, settings: String)
    case emptyLocationData
    case invalidGameState(String)

    var errorDescription: String? {
        switch self {
        case .audioLoadFailed(let fileName):
            return "Failed to load audio file: \(fileName)"
        case .dataLoadFailed(let fileName):
            return "Failed to load data from: \(fileName)"
        case .insufficientLocations(let count, let required, let settings):
            return "Not enough locations found. Found \(count), need at least \(required). Settings: \(settings)"
        case .emptyLocationData:
            return "No location data available"
        case .invalidGameState(let reason):
            return "Invalid game state: \(reason)"
        }
    }

    var recoverySuggestion: String? {
        switch self {
        case .audioLoadFailed:
            return "The game will continue without sound effects."
        case .dataLoadFailed:
            return "Please reinstall the app or contact support."
        case .insufficientLocations:
            return "Try selecting a different region or difficulty level."
        case .emptyLocationData:
            return "Please reinstall the app to restore location data."
        case .invalidGameState:
            return "Please restart the game."
        }
    }
}
