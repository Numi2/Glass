/*

Abstract:
The main app declaration.
*/

import SwiftUI

/// The main app declaration.
@main
struct LandmarksApp: App {
    /// An object that manages the app's data and state.
    @State private var modelData = ModelData()
    @State private var isLoading = true

    var body: some Scene {
        WindowGroup {
            if isLoading {
                ProgressView("Finding Gems...")
                    .task {
                        await modelData.fetchLandmarks()
                        isLoading = false
                    }
            } else {
                LandmarksSplitView()
                    .environment(modelData)
            }
        }
    }
}
