//
//  RecordAudioView.swift
//  Pitch Perfect
//
//  Created by Dylan Edwards on 1/26/16.
//  Copyright © 2016 Slinging Pixels Media. All rights reserved.
//

import UIKit

final class RecordAudioView: UIView {
    typealias IBActionClosure = () -> Void
    private var startRecording: IBActionClosure?
    private var pauseRecording: IBActionClosure?
    private var doneRecording: IBActionClosure?
    
    enum AudioRecorderState {
        case Stopped, Recording, Paused
    }
    
    private var currentRecordingState: AudioRecorderState = .Stopped {
        didSet {
            
        }
    }
    
    
    
    @IBOutlet weak var recordAudioButton: UIButton!
    @IBOutlet weak var tapToBeginLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var pauseContinueButton: UIButton!
    
   
    
    @IBAction func recordButtonTapped(sender: AnyObject) {
        currentRecordingState = .Recording
        startRecording?()
    }
    @IBAction func doneButtonTapped(sender: AnyObject) {
        currentRecordingState = .Stopped
        doneRecording?()
    }
    @IBAction func pauseButtonTapped(sender: AnyObject) {
        currentRecordingState = .Paused
        pauseRecording?()
    }
    
    
    func configure(
        withStartRecording  start: IBActionClosure,
        pauseRecording      pause: IBActionClosure,
        doneRecording       done: IBActionClosure)
    {
            startRecording = start
            pauseRecording = pause
            doneRecording = done
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
