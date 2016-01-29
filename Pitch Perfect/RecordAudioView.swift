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

    private var doneRecording: IBActionClosure?
    
    enum AudioRecorderState {
        case Stopped, Recording, Paused
    }
    
    private var currentRecordingState: AudioRecorderState = .Stopped {
        didSet {
            
        }
    }
    
    private lazy var audioController = AudioController()
    
    
    @IBOutlet weak var recordAudioButton: UIButton!
    @IBOutlet weak var tapToBeginLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var pauseContinueButton: UIButton!
    
   
    
    @IBAction func recordButtonTapped(sender: AnyObject) {
        currentRecordingState = .Recording
        audioController.startRecording()
    }
    @IBAction func doneButtonTapped(sender: AnyObject) {
        currentRecordingState = .Stopped
        audioController.doneRecording()
        doneRecording?()
    }
    @IBAction func pauseButtonTapped(sender: AnyObject) {
        currentRecordingState = .Paused
        audioController.pauseRecording()
    }
    
    
    func configure(withDoneRecordingClosure done: IBActionClosure) {
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
