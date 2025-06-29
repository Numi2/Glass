/*

Abstract:
Protocol for data service implementations and mock implementation.
*/

import Foundation
import MapKit

/// Protocol for abstracting data persistence
protocol DataService {
    func fetchLandmarks() async -> [Landmark]
    func fetchCollections() async -> [LandmarkCollection]
}

/// Mock implementation of DataService for development and testing
class MockDataService: DataService {
    func fetchLandmarks() async -> [Landmark] {
        // Simulate network delay
        try? await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds
        
        // Return sample data with proper categories and featured flags
        var landmarks = Landmark.exampleData
        
        // Set featured landmarks
        for i in landmarks.indices {
            switch landmarks[i].id {
            case 1001, 1005, 1016, 1019, 1021: // Sahara, Niagara, Fuji, Great Barrier, South Shetland
                landmarks[i].isFeatured = true
            default:
                landmarks[i].isFeatured = false
            }
            
            // Set categories based on landmark characteristics
            landmarks[i].category = categoryForLandmark(landmarks[i])
        }
        
        return landmarks
    }
    
    func fetchCollections() async -> [LandmarkCollection] {
        // Simulate network delay
        try? await Task.sleep(nanoseconds: 300_000_000) // 0.3 seconds
        
        let landmarks = await fetchLandmarks()
        
        // Create default collections
        let favoritesCollection = LandmarkCollection(
            id: 1001,
            name: "Favorites",
            description: "Your favorite landmarks",
            landmarkIds: [],
            landmarks: []
        )
        
        let featuredCollection = LandmarkCollection(
            id: 1002,
            name: "Featured",
            description: "Featured landmarks from around the world",
            landmarkIds: landmarks.filter { $0.isFeatured }.map { $0.id },
            landmarks: landmarks.filter { $0.isFeatured }
        )
        
        return [favoritesCollection, featuredCollection]
    }
    
    private func categoryForLandmark(_ landmark: Landmark) -> LandmarkCategory {
        switch landmark.id {
        case 1001: return .desert // Sahara
        case 1002: return .grassland // Serengeti
        case 1003: return .desert // Deadvlei
        case 1004: return .canyon // Grand Canyon
        case 1005: return .river // Niagara Falls
        case 1006: return .desert // Joshua Tree
        case 1007: return .mountain // Rocky Mountains
        case 1008: return .desert // Monument Valley
        case 1009: return .forest // Muir Woods
        case 1010: return .forest // Amazon Rainforest
        case 1011: return .lake // Lençóis Maranhenses
        case 1012: return .saltFlat // Uyuni Salt Flat
        case 1014: return .cliffs // White Cliffs of Dover
        case 1015: return .mountain // Alps
        case 1016: return .volcano // Mount Fuji
        case 1017: return .mountain // Wulingyuan
        case 1018: return .mountain // Mount Everest
        case 1019: return .reef // Great Barrier Reef
        case 1020: return .nationalPark // Yellowstone
        case 1021: return .island // South Shetland Islands
        case 1022: return .mountain // Kirkjufell Mountain
        default: return .mountain
        }
    }
}