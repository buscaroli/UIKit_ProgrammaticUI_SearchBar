//
//  PicsData.swift
//  UIKit_ProgrammaticUI_SearchBar
//
//  Created by Matteo on 01/09/2021.
//

import Foundation

struct PicsData: Decodable {
    let total: Int
    let total_pages: Int
    let results: [Result]
}

struct Result: Decodable {
    let id: String
    let description: String
    let likes: Int
    let user: User
    let urls: URLS
}

struct User: Decodable {
    let id: String
    let name: String
}

struct URLS: Decodable {
    let thumb: String
    let small: String
    let regular: String
    let full: String
    let raw: String
}
