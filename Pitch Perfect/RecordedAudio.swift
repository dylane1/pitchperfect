//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Dylan Edwards on 1/29/16.
//  Copyright © 2016 Slinging Pixels Media. All rights reserved.
//

import Foundation

struct RecordedAudio {
    var title: String
    var fileURL: NSURL
    
    init(withTitle title: String, fileURL: NSURL) {
        self.title      = title
        self.fileURL    = fileURL
    }
}