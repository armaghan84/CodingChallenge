//
//  Downloader.swift
//  CodingChallenge
//
//  Created by Armaghan  on 5/30/21.
//

import Foundation
import UIKit

class Downloader
{
    // MARK: - Download Image
    func downloadImage(imageURL: String , completionBlock: @escaping (_ image: UIImage?, _ isSuccessfull: Bool) -> Void)
    {
        let url = URL(string: imageURL)!
        self.getData(from: url) { data, response, error in
            guard let data = data, error == nil else
            {
                completionBlock(UIImage(),false)
                return
            }
            let image = UIImage(data: data)
            completionBlock(image,true)
        }
    }
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ())
    {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
