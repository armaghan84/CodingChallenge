//
//  PhotoGalleryViewModel.swift
//  CodingChallenge
//
//  Created by Armaghan  on 5/30/21.
//

import Foundation

class PhotoGalleryViewModel : NSObject
{
    var sectionTitles = [Int]()
    var dictAlbums = [Int: [Photo]]()
    private(set) var arrData : Photos! {
            didSet {
                self.bindPhotoGalleryViewModelToController()
            }
    }
    var bindPhotoGalleryViewModelToController : (() -> ()) = {}
    override init()
    {
        super.init()
    }
    
    func populateData()
    {
        
    }
    // MARK:- Load Data From Core Data
    func loadDataFromCoreData() -> Bool
    {
        self.arrData = AppCoreDataManager().loadPhotosData()
        self.sortByAlbum()
        self.tblPhotos.reloadData()
        if (arrPhotos?.count ?? 0) > 0
        {
            return true
        }
        return false
    }
    // MARK: - Fetch Data From API
    func fetchDataFromAPI()
    {
        self.startActivityIndicator()
        APIManager.shared.fetchPhotosData { (arrFetchedPhotos, message, isSuccess) in
            self.stopActivityIndicator()
            if isSuccess
            {
                self.arrPhotos = arrFetchedPhotos
                self.sortByAlbum()
                DispatchQueue.main.async
                {
                    AppCoreDataManager().savePhotosData(arrPhotos: self.arrPhotos!)
                    self.tblPhotos.reloadData()
                }
            }
            else
            {
                UtilityFunctions().showStandardAlert(title: "Failed", message: message, viewController: self)
            }
        }
    }
}
