/*

Abstract:
A class the app uses to store and manage model data.
*/

import Foundation
import SwiftUI
import MapKit

@Observable
class ModelData {
    var landmarks: [Landmark] = []
    var collections: [LandmarkCollection] = []
    var profile = Profile.default
    
    // Navigation and UI state
    var path = NavigationPath()
    var searchString = ""
    var selectedLandmark: Landmark?
    var isLandmarkInspectorPresented = false
    var windowSize: CGSize = .zero
    var locationFinder: LocationFinder?
    
    // The data service can be swapped with a live Firebase implementation later.
    private let dataService: DataService

    init(dataService: DataService = MockDataService()) {
        self.dataService = dataService
    }

    func fetchLandmarks() async {
        landmarks = await dataService.fetchLandmarks()
        collections = await dataService.fetchCollections()
    }

    var features: [Landmark] {
        landmarks.filter { $0.isFeatured }
    }

    var categories: [String: [Landmark]] {
        Dictionary(
            grouping: landmarks,
            by: { $0.category.rawValue }
        )
    }
    
    var landmarksById: [Int: Landmark] {
        Dictionary(uniqueKeysWithValues: landmarks.map { ($0.id, $0) })
    }
    
    var mapItemsForLandmarks: [MKMapItem] {
        landmarks.compactMap { landmark in
            let placemark = MKPlacemark(coordinate: landmark.locationCoordinate)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = String(localized: landmark.name)
            return mapItem
        }
    }
    
    var earnedBadges: [Badge] {
        landmarks.compactMap { landmark in
            guard let badgeProgress = landmark.badgeProgress, badgeProgress.earned else { return nil }
            return landmark.badge
        }
    }
    
    var featuredLandmark: Landmark? {
        features.first
    }
    
    var landmarksByContinent: [Continent: [Landmark]] {
        Dictionary(
            grouping: landmarks,
            by: { Continent(rawValue: $0.continent) ?? .other }
        )
    }
    
    var favoritesCollection: LandmarkCollection {
        collections.first { $0.isFavoritesCollection } ?? LandmarkCollection(
            id: 1001,
            name: "Favorites",
            description: "Your favorite landmarks",
            landmarkIds: [],
            landmarks: []
        )
    }
    
    func addUserCollection() -> LandmarkCollection {
        let nextId = (collections.map { $0.id }.max() ?? 1000) + 1
        let newCollection = LandmarkCollection(
            id: nextId,
            name: "New Collection",
            description: "A new collection of landmarks",
            landmarkIds: [],
            landmarks: []
        )
        collections.append(newCollection)
        return newCollection
    }
    
    static let orderedContinents: [Continent] = [
        .africa, .northAmerica, .southAmerica, .europe, .asia, .australiaOceania, .antarctica
    ]
}

/// Continent enumeration for organizing landmarks
enum Continent: String, CaseIterable {
    case africa = "Africa"
    case northAmerica = "North America"
    case southAmerica = "South America"
    case europe = "Europe"
    case asia = "Asia"
    case australiaOceania = "Australia/Oceania"
    case antarctica = "Antarctica"
    case other = "Other"
    
    var name: String {
        return self.rawValue
    }
}

/// A placeholder for user profile data.
struct Profile {
    var username: String
    var prefersNotifications = true
    var seasonalPhoto = Season.winter
    var goalDate = Date()

    static let `default` = Profile(username: "g_kumar")

    enum Season: String, CaseIterable, Identifiable {
        case spring = "🌷"
        case summer = "☀️"
        case autumn = "🍂"
        case winter = "☃️"

        var id: String { rawValue }
    }
}
