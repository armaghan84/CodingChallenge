//
//  PhotoGalleryViewController.swift
//  CodingChallenge
//
//  Created by Armaghan  on 5/30/21.
//

import UIKit

class PhotoGalleryViewController: UIViewController {

    @IBOutlet weak var viewBody: UIView!
    @IBOutlet weak var tblPhotos: UITableView!
    
    var reuseIdentifier = "cellPhotos"
    var arrPhotos : [Photo]?
    var sectionTitles = [Int]()
    var dictAlbums = [Int: [Photo]]()
    var activityIndicator = UIActivityIndicatorView(style: .large)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewSetup()
        // Do any additional setup after loading the view.
    }
    // MARK: - View Setup
    func viewSetup()
    {
        self.tblPhotos.delegate = self
        self.tblPhotos.dataSource = self
        self.tblPhotos.tableFooterView = UIView()
        self.populatData()
    }
    
    // MARK: - Populate Data
    func populatData()
    {
        if !loadDataFromCoreData()
        {
            self.fetchDataFromAPI()
        }
    }
    // MARK:- Load Data From Core Data
    func loadDataFromCoreData() -> Bool
    {
        self.arrPhotos = AppCoreDataManager().loadPhotosData()
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
    // MARK: - Sort Album
    func sortByAlbum()
    {
        self.dictAlbums.removeAll()
        for i in 0..<(arrPhotos?.count ?? 0)
        {
            let key = self.arrPhotos![i].albumID
            if var values = dictAlbums[key]
            {
                values.append(arrPhotos![i])
                dictAlbums[key] = values

            }
            else
            {
                dictAlbums[key] = [arrPhotos![i]]
            }
        }
        sectionTitles = [Int](dictAlbums.keys)
        sectionTitles = sectionTitles.sorted(by: { $0 < $1 })
    }
    // MARK: - Helper Methods
    func startActivityIndicator()
    {
        UtilityFunctions().startActivityIndicator(activityIndicator: self.activityIndicator, viewController: self)
    }
    func stopActivityIndicator()
    {
        DispatchQueue.main.async {
            UtilityFunctions().stopActivityIndicator(activityIndicator: self.activityIndicator, viewController: self)
        }
    }
}
    // MARK: - UITableView Delegate and DataSource
extension PhotoGalleryViewController : UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
      return sectionTitles.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let key = (sectionTitles[section])
        if let values = dictAlbums[key]
        {
            return values.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = self.tblPhotos.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! PhotoGalleryTableViewCell
        cell.imgThumbnail.image = nil
        let key = sectionTitles[indexPath.section]
        var objPhoto : Photo?
        if let values = dictAlbums[key]
        {
            let sortedValues = values.sorted {
                $0.id < $1.id
            }
            objPhoto = sortedValues[indexPath.row]
        }
        cell.populateCell(thumbnailURL: objPhoto!.thumbnailURL, title: objPhoto!.title)
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return String(format: "Album : %d", sectionTitles[section])
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 160
    }
}
