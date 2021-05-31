//
//  AppCoreDataManager.swift
//  CodingChallenge
//
//  Created by Armaghan  on 5/30/21.
//

import Foundation
import CoreData
import UIKit
class AppCoreDataManager
{
    // MARK: - Save Photos Data
    func savePhotosData(arrPhotos: [Photo]) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        for photo in arrPhotos {
            let objPhoto = NSEntityDescription.insertNewObject(forEntityName: "PhotoCoreData", into: managedContext)
            objPhoto.setValue(photo.id, forKey: "id")
            objPhoto.setValue(photo.albumID, forKey: "albumID")
            objPhoto.setValue(photo.title, forKey: "title")
            objPhoto.setValue(photo.thumbnailURL, forKey: "thumbnailURL")
            objPhoto.setValue(photo.url, forKey: "url")
        }
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    // MARK: - Load Photos Data
    func loadPhotosData() -> Array<Photo>
    {
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return []
        }
        var arrPhotos : [Photo] = []
        var arrManagedObject: [NSManagedObject] = []
        let managedContext =
            appDelegate.persistentContainer.viewContext
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "PhotoCoreData")
        do
        {
            arrManagedObject = try managedContext.fetch(fetchRequest)
            if !arrManagedObject.isEmpty
            {
                for objData in arrManagedObject
                {
                    guard let id = objData.value(forKey: "id") as? Int else { return [] }
                    guard let albumID = objData.value(forKey: "albumID") as? Int else { return [] }
                    guard let url = objData.value(forKey: "url") as? String else { return [] }
                    guard let title = objData.value(forKey: "title") as? String else { return [] }
                    guard let thumbnailURL = objData.value(forKey: "thumbnailURL") as? String else { return [] }
                    
                    let photo : Photo = Photo(albumID: albumID, id: id, title: title, url: url, thumbnailURL: thumbnailURL)
                    arrPhotos.append(photo)
                }
            }
            
        } catch let error as NSError
        {
            print("Could not fetch. \(error), \(error.userInfo)")
            
        }
        return arrPhotos
    }
    // MARK: - Delete Photo Data
    func deletePhotosData()
    {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "PhotoCoreData")
        do
        {
            let result = try managedContext.fetch(fetchRequest)
            if !result.isEmpty
            {
                for object in result
                {
                    managedContext.delete(object)
                }
            }
        } catch let error as NSError
        {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}
