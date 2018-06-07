//
//  PlaybackAudioViewController.swift
//  Pitch Perfect
//
//  Created by Dylan Edwards on 1/26/16.
//  Copyright © 2016 Slinging Pixels Media. All rights reserved.
//

import UIKit

final class PlaybackAudioViewController: UIViewController {
    
    private var playbackAudioView: PlaybackAudioView!
    
    var playbackAudioViewDataSource: PlaybackAudioViewModel?
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = LocalizedStrings.ViewControllerTitles.playback
        
        guard let playbackAudioViewDataSource = playbackAudioViewDataSource as PlaybackAudioViewModel? else {
            fatalError("playbackAudioViewDataSource is not set... :[")
        }
        playbackAudioView = view as! PlaybackAudioView
        playbackAudioView.configure(withViewModel: playbackAudioViewDataSource)
    }
}
