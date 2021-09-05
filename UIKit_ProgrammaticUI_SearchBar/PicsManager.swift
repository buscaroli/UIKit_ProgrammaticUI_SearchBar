//
//  PicsManager.swift
//  UIKit_ProgrammaticUI_SearchBar
//
//  Created by Matteo on 01/09/2021.
//

import Foundation

protocol PicsManagerDelegate {
    func didUpdatePics(_ pics: PicsModel)
}

struct PicsManager {
    
    var currentPage: Int = 1
    let picsURL = "https://api.unsplash.com/search/photos/"
    
    
    
    var delegate: PicsManagerDelegate?
    
    let API_Key = "U5JhPqLRQmlpnIIruCblsd670NsIXkoiuD0DdWAU3P4"
    
    enum OrderBy {
        case latest
        case oldest
        case popular
    }
    
    var searchURL: String {
        return ("\(picsURL)?client_id=\(API_Key)&page=\(String(currentPage))")
    }
    
    func getPics(_ term: String) {
        let fullURL = "\(searchURL)&query=\(term)"
        self.performRequest(with: fullURL)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    print("Error: \(error!)")
                    return
                }
                
                if let data = data {
                    print("calling parseJSON")
                    self.parseJSON(data)
                    
//                    let dataString = String(data: data, encoding: .utf8)
//                    print(dataString!)
                    
                } else {
                    print("No data!!")
                }
                
                
            })
            
            task.resume()
        }
    }
    
    func parseJSON(_ picsData: Data) {
        let pics = PicsModel()
        
        do {
            let decodedData = try JSONDecoder().decode(PicsData.self, from: picsData)
            print("Decoded data:\n\(decodedData.results[0].urls.small)")
            var downloadedPics: [Result] = []
            downloadedPics += decodedData.results
//            print("~~~ ~~~ ~~~")
//            print(downloadedPics)
            for item in decodedData.results {
                let pic = PicDetails(userName: item.user.name, title: item.alt_description, smallPic: item.urls.small, largePic: item.urls.full)
                pics.pics.append(pic)
            }
            
            self.delegate?.didUpdatePics(pics)
            
            
        } catch let error {
            print("Error decoding data: \(error)")
        }
        
    }
}
