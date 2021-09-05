//
//  PicsManager.swift
//  UIKit_ProgrammaticUI_SearchBar
//
//  Created by Matteo on 01/09/2021.
//

import Foundation

protocol PicsManagerDelegate {
    func didUpdatePics(_ pics: PicsData)
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
        do {
            let decodedData = try JSONDecoder().decode(PicsData.self, from: picsData)
            print("Decoded data:\n\(decodedData.results[0].urls.small)")
            var downloadedPics: [Result] = []
            downloadedPics += decodedData.results
            print("~~~ ~~~ ~~~")
            print(downloadedPics)
            
            self.delegate?.didUpdatePics(decodedData)
            
            
        } catch let error {
            print("Error decoding data: \(error)")
        }
        
    }
}
