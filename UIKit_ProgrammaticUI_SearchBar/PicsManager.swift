//
//  PicsManager.swift
//  UIKit_ProgrammaticUI_SearchBar
//
//  Created by Matteo on 01/09/2021.
//

import Foundation

struct PicsManager {
    var currentPage: Int = 1
    let picsURL = "https://api.unsplash.com/photos/"
    
    let API_Key = "U5JhPqLRQmlpnIIruCblsd670NsIXkoiuD0DdWAU3P4"
    
    enum OrderBy {
        case latest
        case oldest
        case popular
    }
    
    var searchURL: String {
        return ("\(picsURL)?page=\(String(currentPage))")
    }
    
    func getPics(_ term: String) {
        print("\(searchURL)&query=\"\(term)\"")
    }
}
