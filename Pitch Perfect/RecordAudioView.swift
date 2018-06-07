//
//  RecordAudioView.swift
//  Pitch Perfect
//
//  Created by Dylan Edwards on 1/26/16.
//  Copyright © 2016 Slinging Pixels Media. All rights reserved.
//

import UIKit

final class RecordAudioView: UIView {
    typealias IBActionClosure = (_ recordedAudio: RecordedAudio) -> Void
    private var doneRecordingSuccessfully: IBActionClosure?
    
    enum AudioRecorderState {
        case Stopped, Recording, Paused
    }
    
    private var currentRecordingState: AudioRecorderState = .Stopped
    
    private var audioController: AudioController?
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var recordAudioButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var pauseContinueButton: UIButton!
    
    //MARK: - IBActions
    
    @IBAction func recordButtonTapped(sender: AnyObject) {
        currentRecordingState = .Recording
        audioController!.startRecording()
        
        recordAudioButton.isEnabled   = false
        recordingLabel.text         = LocalizedStrings.Labels.RecordAudioView.recording
        doneButton.isEnabled          = true
        doneButton.isHidden           = false
        pauseContinueButton.isEnabled = true
        pauseContinueButton.isHidden  = false
    }
    @IBAction func doneButtonTapped(sender: AnyObject) {
        currentRecordingState = .Stopped
        audioController!.doneRecording()
        configureButtonsAndLabels()
    }
    @IBAction func pauseButtonTapped(sender: AnyObject) {
        switch currentRecordingState {
        case .Recording:
            currentRecordingState = .Paused
            audioController!.doPauseRecording(doPause: true)
            pauseContinueButton.setTitle(LocalizedStrings.Temporary.continueRecording, for: .normal)
            recordingLabel.text = LocalizedStrings.Labels.RecordAudioView.paused
        case .Paused:
            magic(".Paused")
            currentRecordingState = .Recording
            audioController!.doPauseRecording(doPause: false)
            pauseContinueButton.setTitle(LocalizedStrings.Temporary.pauseRecording, for: .normal)
            recordingLabel.text = LocalizedStrings.Labels.RecordAudioView.recording
        default:
            break
        }
        
    }
    
    //MARK: - Public funk(s)
    
    func configure(withDoneRecordingClosure done: @escaping IBActionClosure) {
        doneRecordingSuccessfully = done
        
        let doneRecordingClosure = { [weak self] (success: Bool, recordedAudio: RecordedAudio?) in
            if success && recordedAudio != nil {
                magic("Yay!  \(recordedAudio!.title)")
                self!.doneRecordingSuccessfully?(recordedAudio!)
            } else {
                magic("Noooooooo......")
                self!.configureButtonsAndLabels()
            }
        }
        audioController = AudioController(withDoneRecordingClosure: doneRecordingClosure)
        
        configureButtonsAndLabels()
    }
    
    //MARK: - Private funk(s)
    
    private func configureButtonsAndLabels() {
        recordAudioButton.isEnabled   = true
        recordingLabel.text         = LocalizedStrings.Labels.RecordAudioView.tapToRecord
        doneButton.isEnabled          = false
        doneButton.isHidden           = true
        pauseContinueButton.isEnabled = false
        pauseContinueButton.isHidden  = true
    }

}




























