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
    
    private var recordedAudio: RecordedAudio?
    private var playbackAudioViewDataSource: PlaybackAudioViewModel?
    
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = LocalizedStrings.ViewControllerTitles.record
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureView()
    }

    //MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        magic("prepareForSegue")
        if segue.identifier == Constants.SegueIDs.showPlaybackViewController {
            guard let destinationVC = segue.destination as? PlaybackAudioViewController,
                let playbackAudioViewDataSource = playbackAudioViewDataSource as PlaybackAudioViewModel? else { fatalError(":[") }
            magic("playbackAudioViewDataSource: \(playbackAudioViewDataSource)")
            destinationVC.playbackAudioViewDataSource = playbackAudioViewDataSource
        }
    }
    
    //MARK: - Private funk(s)
    
    private func configureView() {
        recordAudioView = view as! RecordAudioView

        let doneRecording = { [weak self] (recordedAudio: RecordedAudio) in
            magic("performSegue")
            self!.recordedAudio = recordedAudio
            self!.playbackAudioViewDataSource = PlaybackAudioViewModel(withRecordedAudio: recordedAudio)
            self!.performSegue(withIdentifier: Constants.SegueIDs.showPlaybackViewController, sender: nil)
        }
        recordAudioView.configure(withDoneRecordingClosure: doneRecording)
    }
}













/** The End :] */
