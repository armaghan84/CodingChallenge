//
//  APIManager.swift
//  CodingChallenge
//
//  Created by Armaghan  on 5/30/21.
//

import Foundation
import Network

class APIManager
{
    static let shared = APIManager()
   // MARK: - Fetch Photos Data
    func fetchPhotosData(completionBlockArray: @escaping (_ arrPhotos: [Photo], _ message : String, _ isSuccessfull: Bool) -> Void)
    {
        let url = URL(string: Constants.API.photos)!
        let task = URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            let decoder = JSONDecoder()
            do {
                let arrPhotos = try decoder.decode([Photo].self, from: data!)
                completionBlockArray(arrPhotos,"",true)
            } catch
            {
                print(error.localizedDescription)
                completionBlockArray([],error.localizedDescription,false)
            }
           
        }
        task.resume()
    }
    
    
}
