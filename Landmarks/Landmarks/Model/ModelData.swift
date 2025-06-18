/*

Abstract:
A class the app uses to store and manage model data.
*/

import Foundation

@Observable
class ModelData {
    var landmarks: [Landmark] = []
    var profile = Profile.default
    
    // The data service can be swapped with a live Firebase implementation later.
    private let dataService: DataService

    init(dataService: DataService = MockDataService()) {
        self.dataService = dataService
    }

    func fetchLandmarks() async {
        landmarks = await dataService.fetchLandmarks()
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
