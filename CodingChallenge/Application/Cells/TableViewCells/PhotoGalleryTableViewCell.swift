//
//  PhotoGalleryTableViewCell.swift
//  CodingChallenge
//
//  Created by Armaghan  on 5/30/21.
//

import UIKit

class PhotoGalleryTableViewCell: UITableViewCell {

    @IBOutlet weak var viewMain: UIView!
    
    @IBOutlet weak var imgThumbnail: UIImageView!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Populate Cell
    func populateCell(thumbnailURL: String, title: String)
    {
        self.lblTitle.text = title
        self.setImage(thumbnailURL: thumbnailURL)
    }
    // MARK: - Set Image with Document Directory
    func setImage(thumbnailURL: String)
    {
        let size = CGSize(width: 0, height: 0)
        let path = thumbnailURL.digits
        let savedImage = AppFileManager.shared.getImageFromDocumentDirectory(imageName: path)
        if savedImage.size != size
        {
            self.imgThumbnail.image = savedImage
        }
        else
        {
            Downloader().downloadImage(imageURL: thumbnailURL) { (image, isSuccess) in
                if isSuccess
                {
                    AppFileManager.shared.saveImageToDocumentDirectory(image: image!, name: path)
                    DispatchQueue.main.async
                    {
                        self.imgThumbnail.image = image
                    }
                }
            }
        }
    }
    // MARK: - image Cache
    func cacheImage(thumbnailURL: String)
    {
        let imageCache = NSCache<NSString, UIImage>()
        if let cachedImage = imageCache.object(forKey: NSString(string: thumbnailURL))
        {
            self.imgThumbnail.image = cachedImage
        }
        else
        {
            Downloader().downloadImage(imageURL: thumbnailURL) { (image, isSuccess) in
                if isSuccess
                {
                    imageCache.setObject(image!, forKey: NSString(string: thumbnailURL))
                    DispatchQueue.main.async
                    {
                        self.imgThumbnail.image = image
                    }
                }
            }
        }
    }
}
