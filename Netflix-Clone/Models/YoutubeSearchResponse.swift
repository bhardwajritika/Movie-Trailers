//
//  YoutubeSearchResponse.swift
//  Netflix-Clone
//
//  Created by Tarun Sharma on 17/01/26.
//

import Foundation

struct YoutubeSearchResponse: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: IdVideoElement
}


struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}
