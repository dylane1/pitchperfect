//
//  PlaybackAudioView.swift
//  Pitch Perfect
//
//  Created by Dylan Edwards on 1/27/16.
//  Copyright © 2016 Slinging Pixels Media. All rights reserved.
//

import UIKit

class PlaybackAudioView: UIView {
    private lazy var audioController = AudioController()
    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!

    @IBOutlet weak var stopButton: UIButton!
    
    @IBOutlet weak var effect1Slider: UISlider!
    @IBOutlet weak var effect2Slider: UISlider!
    @IBOutlet weak var effect3Slider: UISlider!
    
    @IBAction func snailButtonTapped(sender: AnyObject) {
        playIt(.Snail)
    }
    @IBAction func rabbitButtonTapped(sender: AnyObject) {
        playIt(.Rabbit)
    }
    @IBAction func chipmunkButtonTapped(sender: AnyObject) {
        playIt(.Chipmunk)
    }
    @IBAction func vaderButtonTapped(sender: AnyObject) {
        playIt(.Vader)
    }
    @IBAction func stopButtonTapped(sender: AnyObject) {
        audioController.stopPlayback()
    }
    
    private func playIt(type: AudioPlaybackType) {
        audioController.playRecording(type, effect1: effect1Slider.value, effect2: effect2Slider.value, effect3: effect3Slider.value)
    }
}
