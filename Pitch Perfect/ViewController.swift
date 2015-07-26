//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Mark Vicuna on 7/24/15.
//  Copyright (c) 2015 Mark Vicuna. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        stopButton.hidden = true
        recordingLabel.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(sender: UIButton) {
        //TODO: Record the user's voice
        println("start recording")
        recordingLabel.hidden = false
        stopButton.hidden = false
        startButton.enabled = false
    }

    @IBAction func stopRecording(sender: UIButton) {
        println("stop recording")
        recordingLabel.hidden = true
        stopButton.hidden = true
        startButton.enabled = true
    }
}

