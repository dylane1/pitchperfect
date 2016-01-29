//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Dylan Edwards on 1/26/16.
//  Copyright © 2016 Slinging Pixels Media. All rights reserved.
//

import UIKit

final class RecordAudioViewController: UIViewController {
    private var recordAudioView: RecordAudioView!
    
    private lazy var audioController = AudioController()
    
    
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = LocalizedStrings.ViewControllerTitles.record
        
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    //MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Constants.SegueIDs.showPlaybackViewController {
            guard let destinationVC = segue.destinationViewController as? PlaybackAudioViewController else { fatalError(":[") }
            
            destinationVC.configure()
        }
    }
    
    //MARK: - Private funk(s)
    
    private func configureView() {
        recordAudioView = view as! RecordAudioView
        let startRecording = { [weak self] in
            self!.audioController.startRecording()
        }
        let pauseRecording = { [weak self] in
            self!.audioController.pauseRecording()
        }
        let doneRecording = { [weak self] in
            self!.audioController.doneRecording()
            self!.performSegueWithIdentifier(Constants.SegueIDs.showPlaybackViewController, sender: nil)
        }
        recordAudioView.configure(withStartRecording: startRecording, pauseRecording: pauseRecording, doneRecording: doneRecording)
    }
}













/** The End :] */
