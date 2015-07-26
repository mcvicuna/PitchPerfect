//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Mark Vicuna on 7/25/15.
//  Copyright (c) 2015 Mark Vicuna. All rights reserved.
//

import Foundation

final class RecordedAudio: NSObject{
    var filePathUrl: NSURL
    var title: String!
    init(url: NSURL!, title :String!) {
        filePathUrl = url
        self.title = title
    }
    convenience init(url: NSURL) {
        self.init()
        self.filePathUrl = url
        self.title = url.lastPathComponent
    }
    override init() {
        filePathUrl = NSURL()
        title = "None"
    }
}

