# PhotoAlbumViewer

This iOS application was built as part of a coding challenge to demonstrate practical iOS development skills. The app fetches photo data from a dummy API and displays it in a grouped table view. It uses Core Data for offline storage and caches images in the device's document directory.

### 🔧 Requirements

- The app contains a **single view** displaying all data in a **UITableView**
- **Data is fetched** from the API
- **Fetched data is saved offline** using Core Data
- **Images are cached** in the document directory to avoid repeated downloads
- **Data is grouped by `albumId`** in the table view
- Each row shows:
  - `title`
  - `thumbnailUrl` as an image

## 📱 Features

- Fetches and parses photo data from a public API
- Saves all data locally using **Core Data**
- Caches images in the **document directory**
- Displays grouped albums by `albumId` in a clean table view
- Efficient image loading and reuse
- Fully functional offline mode after initial load

## 🛠️ Technologies Used

- Swift  
- UIKit  
- URLSession  
- UITableView  
- Codable  
- **Core Data** for local data storage  
- **FileManager (Document Directory)** for image caching
