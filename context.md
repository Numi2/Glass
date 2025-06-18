This app leverages Apple's new Liquid Glass design feature for iOS 26 and macOS Tahoe, allowing users to explore landmarks, mark favorites, organize collections, and earn activity badges.

Here's a breakdown of the mapped features:

**Liquid Glass Features:**

*   **Custom Glass Effects**: The `.glassEffect(_:in:isEnabled:)` modifier is applied to custom views like the `BadgeLabel` in `BadgesView.swift`, giving them a Liquid Glass appearance within a defined shape (e.g., rounded rectangle).
*   **Glass Effect Container**: The `GlassEffectContainer` in `BadgesView.swift` is used to group multiple glass elements, ensuring their visual consistency and proper interaction.
*   **Morphing Transitions**: The `.glassEffectID(_:in:)` modifier enables fluid morphing animations between different glass elements, as demonstrated with the badges and the toggle button in `BadgesView.swift`.
*   **Glass Button Style**: The app utilizes the system-provided `.buttonStyle(.glass)` for controls such as the "Show/Hide Badges" button in `BadgesView.swift`, showcasing seamless integration of Liquid Glass with standard UI components.
*   **Background Extension Effect**: The `backgroundExtensionEffect()` modifier on the landmark image in `LandmarkDetailView.swift` suggests adherence to Liquid Glass design principles for extending content beyond safe areas.
*   **Flexible Headers**: The `flexibleHeaderContent()` and `flexibleHeaderScrollView()` modifiers in `LandmarkDetailView.swift` indicate the implementation of flexible headers, which align with the dynamic UI elements of Liquid Glass.

**App Structure and Navigation:**

*   **Split View Navigation**: The `NavigationSplitView`, implemented in `LandmarksSplitView.swift`, forms the core navigation structure. It provides a master-detail interface for navigating between main pages (Landmarks, Collections, Badges) and then to individual landmark or collection details.
*   **Floating Liquid Glass Sidebar**: While not explicitly a modifier in the Swift files, the `context.md` [[NavigationSplitView now has a floating Liquid Glass sidebar with a 'backgroundExtensionEffect' modifier that allows views to extend outside the safe area without clipping.]][[memory:121303]] suggests that `NavigationSplitView` inherently features a floating Liquid Glass sidebar, indicating a system-level design enhancement.
*   **Global Search**: A global search bar is integrated using the `.searchable` modifier in `LandmarksSplitView.swift`, allowing users to efficiently search for landmarks within the app.
*   **Inspector**: The `.inspector` modifier, also found in `LandmarksSplitView.swift` and in the `LandmarkDetailView` preview, provides a way to display supplementary information about selected landmarks in a secondary pane.
*   **Toolbars**: `LandmarkDetailView.swift` demonstrates floating toolbars with automatic item grouping using `ToolbarSpacer` for custom spacing.
*   **Badges Integration**: The custom `showsBadges()` view modifier is applied in `LandmarksSplitView.swift`, indicating that the Liquid Glass-enhanced badges can be displayed over the main content in both navigation and detail stacks.
*   **Menu Design**: `LandmarkCollectionsMenu.swift` demonstrates the use of `Menu` for managing landmark collections, and the `.menuIndicator(.hidden)` modifier aligns with the new menu design features mentioned in `context.md` that emphasize clean, consistent icon placement.
*   **Dialogs**: While explicit Liquid Glass morphing effects weren't directly observed on the `confirmationDialog` in `CollectionDetailView.swift`, the `.editButtonTransition()` with `.symbolEffect(.drawOn)` on the edit button demonstrates a dynamic visual effect consistent with the overall design.

**Other Features:**

*   **Activity Badges**: The app features a system for earning custom activity badges, which are visually enhanced with Liquid Glass effects.
*   **Landmark Collections**: Users can create, manage, and add landmarks to custom collections. The app includes a pre-defined "Favorites" collection.
*   **Favorites**: Users can mark individual landmarks as favorites, which are then managed within the "Favorites" collection.
*   **Map Integration**: The presence of `MapView.swift` and the use of `MKMapItemRequest` in `ModelData.swift` indicate that the app integrates map functionality to display landmark locations.
