//
//  AudioRecorder.swift
//  Pitch Perfect
//
//  Created by Dylan Edwards on 1/27/16.
//  Copyright © 2016 Slinging Pixels Media. All rights reserved.
//

import Foundation
import AVFoundation

class AudioController {

    private lazy var audioSession = AVAudioSession.sharedInstance()
    private var recorder: AVAudioRecorder?
    private var player: AVAudioPlayer?
    private var playbackRate: Float = 1.0
    
    //MARK: - Public funk(s)
    
    func startRecording() {
        magic("start recording")
        let recordSettings = [
            AVSampleRateKey:            NSNumber(float: Float(44100.0)),
            AVFormatIDKey:              NSNumber(int: Int32(kAudioFormatMPEG4AAC)),
            AVNumberOfChannelsKey:      NSNumber(int: 1),
            AVEncoderAudioQualityKey:   NSNumber(int: Int32(AVAudioQuality.Medium.rawValue))
        ]
        do {
            try audioSession.setCategory(AVAudioSessionCategoryRecord)
            try recorder = AVAudioRecorder(URL: getSoundURL()!, settings: recordSettings)
            recorder?.prepareToRecord()
            activateAudioSession()
            recorder?.record()
        } catch {
            fatalError("\(error)")
        }
        
        
    }
    
    func pauseRecording() {
        magic("pause recording")
        recorder?.pause()
    }
    
    func doneRecording() {
        magic("done recording")
        recorder?.stop()
        deactivateAudioSession()
    }
    
    func playRecording(playbackType: AudioPlaybackType, effect1: Float, effect2: Float, effect3: Float) {
        
        switch playbackType {
        case .Snail:
            playbackRate = 0.5
        default:
            break
        }
        
        let concurrentAudioQueue = dispatch_queue_create("com.slingingpixels.PitchPerfect.audioQueue", DISPATCH_QUEUE_CONCURRENT)
        
        dispatch_async(concurrentAudioQueue) {
            
            do {
                try self.player =  AVAudioPlayer(contentsOfURL: self.getSoundURL()!)
                self.player!.prepareToPlay()
                self.player!.enableRate = true
                self.player!.rate = self.playbackRate
                self.player!.play()
            } catch {
                fatalError("AVAudioPlayer error: \(error)")
            }
        }
    }
    
    func stopPlayback() {
        player?.stop()
    }
    //MARK: - Private funk(s)
    
    private func getSoundURL() -> NSURL? {
        let fileManager = NSFileManager.defaultManager()
        let urls = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let documentDirectory = urls[0] as NSURL
        let soundURL = documentDirectory.URLByAppendingPathComponent("sound.m4a")
        return soundURL
    }
    
    private func activateAudioSession() {
        
        do {
            try audioSession.setActive(true)
        } catch {
            fatalError("AVAudioSession.setActive true error: \(error)")
        }
    }
    
    private func deactivateAudioSession() {
        
        do {
            try audioSession.setActive(false)
        } catch {
            fatalError("AVAudioSession.setActive false error: \(error)")
        }
    }
}


















