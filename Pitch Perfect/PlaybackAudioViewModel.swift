//
//  PlaybackAudioViewModel.swift
//  Pitch Perfect
//
//  Created by Dylan Edwards on 2/1/16.
//  Copyright © 2016 Slinging Pixels Media. All rights reserved.
//

/*******************************************************************************
* This class is used to store the effects settings between audio playback sessions
*
*******************************************************************************/
import Foundation

final class PlaybackAudioViewModel: PlaybackAudioViewDataSource {
    var recordedAudio: RecordedAudio
    var delaySetting: Float = 0.0
    var distortionSetting: Float = 0.0
    var reverbSetting: Float = 0.0
    
    required init(withRecordedAudio audio: RecordedAudio) {
        recordedAudio = audio
    }
}