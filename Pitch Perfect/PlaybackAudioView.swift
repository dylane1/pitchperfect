//
//  PlaybackAudioView.swift
//  Pitch Perfect
//
//  Created by Dylan Edwards on 1/27/16.
//  Copyright © 2016 Slinging Pixels Media. All rights reserved.
//

import UIKit

protocol PlaybackAudioViewDataSource {
    var recordedAudio: RecordedAudio { get }
    var delaySetting: Float { get }
    var distortionSetting: Float { get }
    var reverbSetting: Float { get }
}


final class PlaybackAudioView: UIView {
    private var audioController: AudioController!
    
    private var dataSource: PlaybackAudioViewModel!
    
    //MARK: - IBOutlets
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!

    @IBOutlet weak var stopButton: UIButton!
    
    @IBOutlet weak var delayLabel: UILabel!
    @IBOutlet weak var delaySlider: UISlider!
    @IBOutlet weak var distortionLabel: UILabel!
    @IBOutlet weak var distortionSlider: UISlider!
    @IBOutlet weak var reverbLabel: UILabel!
    @IBOutlet weak var reverbSlider: UISlider!
    
    
    //MARK: - IBActions
    @IBAction func snailButtonTapped(sender: AnyObject) {
        playIt(playbackType: .Snail)
    }
    @IBAction func rabbitButtonTapped(sender: AnyObject) {
        playIt(playbackType: .Rabbit)
    }
    @IBAction func chipmunkButtonTapped(sender: AnyObject) {
        playIt(playbackType: .Chipmunk)
    }
    @IBAction func vaderButtonTapped(sender: AnyObject) {
        playIt(playbackType: .Vader)
    }
    @IBAction func stopButtonTapped(sender: AnyObject) {
        audioController.stopPlayback()
    }
    
    @IBAction func delaySliderChanged(sender: UISlider) {
        dataSource.delaySetting = sender.value
    }
    @IBAction func distortionSliderChanged(sender: UISlider) {
        dataSource.distortionSetting = sender.value
    }
    @IBAction func reverbSliderChanged(sender: UISlider) {
        dataSource.reverbSetting = sender.value
    }
    
    
    //MARK: - Public funk(s)
    func configure(withViewModel viewModel: PlaybackAudioViewModel) {
        dataSource      = viewModel
        audioController = AudioController(withRecordedAudio: dataSource.recordedAudio)
        configureLabels()
        configureSliders()
    }
    
    
    //MARK: - Private funk(s)
    private func configureLabels() {
        let labelAttributes  = [
            NSForegroundColorAttributeName : UIColor.black,
            NSFontAttributeName: UIFont.systemFont(ofSize: 17, weight: UIFontWeightMedium)
        ]
        var string = LocalizedStrings.Labels.PlaybackAudioView.effectDelay
        delayLabel.attributedText = NSAttributedString(string: string, attributes: labelAttributes)
        
        string = LocalizedStrings.Labels.PlaybackAudioView.effectDistortion
        distortionLabel.attributedText = NSAttributedString(string: string, attributes: labelAttributes)
        
        string = LocalizedStrings.Labels.PlaybackAudioView.effectReverb
        reverbLabel.attributedText = NSAttributedString(string: string, attributes: labelAttributes)
    }
    
    private func configureSliders() {
        delaySlider.value = dataSource.delaySetting
        distortionSlider.value = dataSource.distortionSetting
        reverbSlider.value = dataSource.reverbSetting
    }
    
    private func playIt(playbackType: AudioPlaybackType) {
        audioController.playRecording(
            playbackType: playbackType,
            delay: delaySlider.value,
            distortion: distortionSlider.value,
            reverb: reverbSlider.value)
    }
}





















