//
//  PicsModel.swift
//  UIKit_ProgrammaticUI_SearchBar
//
//  Created by Matteo on 05/09/2021.
//

import UIKit

class PicsModel {
    var pics: [PicDetails] = []
    
}

struct PicDetails {
    var userName: String
    var title: String
    var smallPicUrl: String
    var largePicUrl: String
    
//    var smallPicData: UIImageView {
//        return self.getPicData(smallPic)
//    }
    
//    var getShortUserName: String {
//        var nameString = userName
//        nameString = nameString.trimmingCharacters(in: .whitespacesAndNewlines)
//        let start = nameString.index(nameString.startIndex, offsetBy: 0)
//        let end = nameString.index(nameString.startIndex, offsetBy: 9)
//        let range = start...end
//        nameString = String(nameString[range])
//        return nameString
//    }
    
    var getUserName: String {
        var nameString = userName
        nameString = nameString.trimmingCharacters(in: .whitespacesAndNewlines)
        return nameString
    }
    
//    func getPicData(_ urlString: String) -> UIImageView {
//        let img = UIImageView()
//
//        DispatchQueue.global(qos: .userInitiated).async {
//            if let url = URL(string: urlString) {
//                let session = URLSession(configuration: .default)
//                let task = session.dataTask(with: url, completionHandler: { data, response, error in
//                    if error != nil {
//                        img.backgroundColor = .systemRed
//                    }
//
//                    if let data = data {
//                        DispatchQueue.main.async {
//                            img.image = UIImage(data: data)
//                        }
//                    }
//                })
//                task.resume()
//            }
//        }
//        return img
//    }
}

