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
    
    private lazy var audioController = AudioController()
    
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = LocalizedStrings.ViewControllerTitles.playback
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Public funk(s)
    
    func configure() {
        
    }
    
    //MARK: - Private funk(s)
}
