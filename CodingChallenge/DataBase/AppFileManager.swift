//
//  AppFileManager.swift
//  CodingChallenge
//
//  Created by Armaghan  on 5/30/21.
//

import Foundation
import UIKit
class AppFileManager
{
    static let shared = AppFileManager()
    // MARK: - Save Images To Document Directory
    func saveImageToDocumentDirectory(image : UIImage, name:String)
    {
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(name)
        let imageData = image.jpegData(compressionQuality: 1.0)
        fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)
    }
    // MARK: - Get Images From Document Directory
    func getImageFromDocumentDirectory(imageName : String) ->  UIImage
    {
        let fileManager = FileManager.default
        let imagePath = (self.getDirectoryPath() as NSString).appendingPathComponent(imageName)
        if fileManager.fileExists(atPath: imagePath){
            return UIImage(contentsOfFile: imagePath)!
        }else{
            print("No Image available")
            return UIImage()
        }
    }
    func getDirectoryPath() -> String
    {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        return paths
    }
    // MARK: - Delete Image
    func deleteThumbnail(url:String){
        let fileManager = FileManager.default
        let pathURL = String(format: "%@/%@", (self.getDirectoryPath() as NSString),url)
        do {
            try fileManager.removeItem(at: URL(string: pathURL)!)
        }
        catch let error as NSError {
            print("Ooops! Something went wrong: \(error)")
        }
   }
}
