//
//  AudioRecorder.swift
//  Pitch Perfect
//
//  Created by Dylan Edwards on 1/27/16.
//  Copyright © 2016 Slinging Pixels Media. All rights reserved.
//

import Foundation
import AVFoundation

final class AudioController: NSObject {
    
    /** Audio Recording */
    typealias DoneRecordingClosure = (success: Bool, recordedAudio: RecordedAudio?) -> Void
    private var doneRecordingClosure: DoneRecordingClosure?
    private lazy var audioSession   = AVAudioSession.sharedInstance()
    private var recorder: AVAudioRecorder?
    
    /** Audio Playback */
    private lazy var audioEngine    = AVAudioEngine()
    private var input: AVAudioInputNode?
    private var output: AVAudioOutputNode?
    private var format: AVAudioFormat?
    
    private lazy var audioPlayer    = AVAudioPlayerNode()
    private lazy var pitchUnit      = AVAudioUnitTimePitch()
    private lazy var delayUnit      = AVAudioUnitDelay()
    private lazy var distortionUnit = AVAudioUnitDistortion()
    private lazy var reverbUnit     = AVAudioUnitReverb()
    private lazy var eqUnit         = AVAudioUnitEQ()

    private var recordedAudio: RecordedAudio?
    
    /** Audio Recording */
    convenience init(withDoneRecordingClosure closure: DoneRecordingClosure) {
        self.init()
        doneRecordingClosure = closure
    }
    
    /** Audio Playback */
    convenience init(withRecordedAudio audio: RecordedAudio) {
        self.init()
        recordedAudio = audio
        input   = audioEngine.inputNode
        output  = audioEngine.outputNode
        format  = input!.inputFormatForBus(0)
        audioEngine.attachNode(audioPlayer)
        
        /** Pitch (Using for pitch & rate) */
        audioEngine.attachNode(pitchUnit)
        
        /** Delay */
        audioEngine.attachNode(delayUnit)
        
        /** Distortion */
        distortionUnit.loadFactoryPreset(.SpeechAlienChatter)
        audioEngine.attachNode(distortionUnit)
        
        /** Reverb */
        audioEngine.attachNode(reverbUnit)
        
        /** EQ */
        audioEngine.attachNode(eqUnit)
        
        /** Connect all the things! */
        audioEngine.connect(audioPlayer, to: pitchUnit, format: format!)
        audioEngine.connect(pitchUnit, to: delayUnit, format: format!)
        audioEngine.connect(delayUnit, to: distortionUnit, format: format!)
        audioEngine.connect(distortionUnit, to: reverbUnit, format: format!)
        audioEngine.connect(reverbUnit, to: eqUnit, format: format!)
        audioEngine.connect(eqUnit, to: output!, format: format!)
        
    }
    
    private override init() {
        super.init()
    }
    
    //MARK: - Public funk(s)
    
    /** Audio Recording */
    func startRecording() {
        let recordSettings = [
            AVSampleRateKey:            NSNumber(float: Float(44100.0)),
            AVFormatIDKey:              NSNumber(int:   Int32(kAudioFormatMPEG4AAC)),
            AVNumberOfChannelsKey:      NSNumber(int:   1),
            AVEncoderAudioQualityKey:   NSNumber(int:   Int32(AVAudioQuality.Medium.rawValue))
        ]
        do {
            try audioSession.setCategory(AVAudioSessionCategoryRecord)
            try recorder = AVAudioRecorder(URL: getSoundURL()!, settings: recordSettings)
            recorder?.delegate = self
            recorder?.prepareToRecord()
            activateAudioSession()
            recorder?.record()
        } catch {
            fatalError("Recording error: \(error)")
        }
    }
    
    func doPauseRecording(doPause: Bool) {
        if doPause {
            recorder?.pause()
        } else {
            recorder?.record()
        }
    }
    
    func doneRecording() {
        recorder?.stop()
    }
    
    
    /** Audio Playback */
    func playRecording(
        playbackType: AudioPlaybackType,
        delay: Float,
        distortion: Float,
        reverb: Float)
    {
        delayUnit.delayTime = NSTimeInterval(Double(delay))
        
        /** 
         * Delay cuts the volume for some reason, so I'm boosting globalGain 
         * to compensate 
        */
        eqUnit.globalGain = (delay > 0) ? 4.0 : 0
        
        distortionUnit.wetDryMix    = distortion * 100
        reverbUnit.wetDryMix        = reverb * 100
        
        switch playbackType {
        case .Snail:
            pitchUnit.rate  = 0.5
            pitchUnit.pitch = 1.0
        case .Rabbit:
            pitchUnit.rate  = 3.0
            pitchUnit.pitch = 1.0
        case .Chipmunk:
            pitchUnit.rate  = 1.0
            pitchUnit.pitch = 1000.0
        case .Vader:
            pitchUnit.rate  = 1.0
            pitchUnit.pitch = -1000.0
        }
        
        /** 
         * I play back audio on a seperate queue so it doesn't intervere with UI.
         * While it's not really an issue with this app, it has caused problems
         * for me in other apps I've built that have UI animations going on.
         */
        let concurrentAudioQueue = dispatch_queue_create("com.slingingpixels.PitchPerfect.audioQueue", DISPATCH_QUEUE_CONCURRENT)
        
        dispatch_async(concurrentAudioQueue) {
            
            do {
                let file = try AVAudioFile(forReading: self.recordedAudio!.fileURL)
                
                self.audioPlayer.scheduleFile(file, atTime: nil, completionHandler: nil)
                
                self.audioEngine.prepare()
                try self.audioEngine.start()
                
                self.audioPlayer.play()

            } catch {
                fatalError("error: \(error)")
            }
        }
    }
    
    func stopPlayback() {
        audioPlayer.stop()
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

extension AudioController: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        deactivateAudioSession()
        if flag {
            let recordedAudio = RecordedAudio(withTitle: recorder.url.lastPathComponent!, fileURL: recorder.url)
            doneRecordingClosure?(success: true, recordedAudio: recordedAudio)
        } else {
            doneRecordingClosure?(success: false, recordedAudio: nil)
        }
    }
}












