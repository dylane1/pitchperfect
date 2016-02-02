//
//  RecordAudioView.swift
//  Pitch Perfect
//
//  Created by Dylan Edwards on 1/26/16.
//  Copyright © 2016 Slinging Pixels Media. All rights reserved.
//

import UIKit

final class RecordAudioView: UIView {
    typealias IBActionClosure = (recordedAudio: RecordedAudio) -> Void
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
        
        recordAudioButton.enabled   = false
        recordingLabel.text         = LocalizedStrings.Labels.RecordAudioView.recording
        doneButton.enabled          = true
        doneButton.hidden           = false
        pauseContinueButton.enabled = true
        pauseContinueButton.hidden  = false
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
            audioController!.doPauseRecording(true)
            pauseContinueButton.setTitle(LocalizedStrings.Temporary.continueRecording, forState: .Normal)
            recordingLabel.text = LocalizedStrings.Labels.RecordAudioView.paused
        case .Paused:
            magic(".Paused")
            currentRecordingState = .Recording
            audioController!.doPauseRecording(false)
            pauseContinueButton.setTitle(LocalizedStrings.Temporary.pauseRecording, forState: .Normal)
            recordingLabel.text = LocalizedStrings.Labels.RecordAudioView.recording
        default:
            break
        }
        
    }
    
    //MARK: - Public funk(s)
    
    func configure(withDoneRecordingClosure done: IBActionClosure) {
        doneRecordingSuccessfully = done
        
        let doneRecordingClosure = { [weak self] (success: Bool, recordedAudio: RecordedAudio?) in
            if success && recordedAudio != nil {
                magic("Yay!  \(recordedAudio!.title)")
                self!.doneRecordingSuccessfully?(recordedAudio: recordedAudio!)
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
        recordAudioButton.enabled   = true
        recordingLabel.text         = LocalizedStrings.Labels.RecordAudioView.tapToRecord
        doneButton.enabled          = false
        doneButton.hidden           = true
        pauseContinueButton.enabled = false
        pauseContinueButton.hidden  = true
    }

}




























