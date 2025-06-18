# Developer Tasks: Product Backlog

Below is a curated list of high-impact tasks for the next milestones.  Tasks are grouped and roughly ordered by priority.  Each task includes the impacted layers and suggested starting points.

---

## 1. User-Added Landmark Images (IN PROGRESS)
*Owner: TBD*  
Extends existing components so users can upload, view, and manage their own photos.

### 1.1 Image Selection & Upload
- Add `PhotosPicker` sheet to `LandmarkDetailView`.
- Resize & compress on the client (`ImageRenderer`).
- Display upload progress with `ProgressView` overlay.

### 1.2 Persistent Storage
- Extend `Landmark` with `[UserImage]` sub-model (id, url, createdAt, ownerId).
- Implement `CloudKitAssetsDataService` or `FirebaseStorageDataService` conforming to `DataService`.
- Sync images when `ModelData.fetchLandmarks()` is called.

### 1.3 Gallery Presentation
- Create `LandmarkGalleryView` – horizontally-scrolling `TabView(.page)` or masonry grid.
- Use `AsyncImage` with caching (e.g. Nuke).
- Blur sensitive images until fully downloaded.

### 1.4 Image Management
- Long-press context menu (`Edit`, `Delete`, `Set as Featured`).
- Add owner-only guards and confirmation dialogs.

### 1.5 Cross-Platform
- macOS support via `OpenPanel` + drag-and-drop.

---

## 2. Replace `MockDataService` with Production Backend
*Owner: Backend Team*

| Milestone | Description |
|-----------|-------------|
| 2.1 | Define `DataService` protocol methods (CRUD landmarks, collections, images). |
| 2.2 | Implement `FirebaseDataService` (Firestore + Storage) **or** `CloudKitDataService`. |
| 2.3 | Add offline persistence with `SQLite` or Core Data `NSPersistentCloudKitContainer`. |
| 2.4 | Unit test with `XCTest + CombineExpectations`. |

Start File: `Model/ModelData.swift`

---

## 3. Global Search Refinement
*Owner: UX Team*

- Index on-device with `SearchIndex` for fuzzy search.
- Include Collections & Badges in results.
- Debounce search string (`.onChange`) to avoid UI thrash.

---

## 4. Accessibility & Localization Polish
- Add VoiceOver labels for badge icons.
- Audit Dynamic Type in `LandmarkDetailView`.
- Translate missing `.xcstrings` keys (German, Japanese).

---

## 5. Continuous Integration / Delivery
- Set up GitHub Actions: `xcodebuild -scheme Landmarks -destination "platform=iOS Simulator,name=iPhone 15" test`.
- Upload coverage to Codecov.
- On `main`, notarize & archive macOS build.

---

## 6. Tech Debt & Refactors
- Extract glass-specific view modifiers to `Glass+Extensions.swift`.
- Move style constants into SwiftGen-generated enum.
- Convert `@State` heavy views to *observable* view models.

---

## 7. Nice-to-Have Enhancements
- Live Activity widgets for nearby landmarks.
- SharePlay group sessions when exploring a landmark.
- Vision Pro spatial version – concept spike.

---

> _Update this file as tasks are completed or as new ideas surface._ 