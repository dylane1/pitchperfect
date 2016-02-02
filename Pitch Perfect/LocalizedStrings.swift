//
//  LocalizedStrings.swift
//  Pitch Perfect
//
//  Created by Dylan Edwards on 1/27/16.
//  Copyright © 2016 Slinging Pixels Media. All rights reserved.
//
import Foundation

struct LocalizedStrings {
    struct ViewControllerTitles {
        static let record   = NSLocalizedString("vcTitles.record",      value: "Record",    comment: "")
        static let playback = NSLocalizedString("vcTitles.playback",    value: "Playback",  comment: "")
    }
    
    struct Labels {
        struct RecordAudioView {
            static let tapToRecord  = NSLocalizedString("labels.tapToRecord",   value: "Tap to Record", comment: "")
            static let recording    = NSLocalizedString("labels.recording",     value: "Recording...",  comment: "")
            static let paused       = NSLocalizedString("labels.paused",        value: "Paused...",     comment: "")
        }
        
        struct PlaybackAudioView {
            static let effectDelay      = NSLocalizedString("labels.effectDelay",       value: "Delay",         comment: "")
            static let effectDistortion = NSLocalizedString("labels.effectDistortion",  value: "Distortion",    comment: "")
            static let effectReverb     = NSLocalizedString("labels.effectReverb",      value: "Reverb",        comment: "")
        }
    }
    
    struct Temporary {
        static let pauseRecording       = NSLocalizedString("vcTitles.pause",       value: "Pause",     comment: "")
        static let continueRecording    = NSLocalizedString("vcTitles.continue",    value: "Continue",  comment: "")
    }
}
