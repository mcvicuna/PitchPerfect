//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Mark Vicuna on 7/24/15.
//  Copyright (c) 2015 Mark Vicuna. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    // local functions
    var audioRecorder : AVAudioRecorder!
    var recordedAudio : RecordedAudio!
    
    // outlet functions
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
       
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        
        let recordingName = "current.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)

        
        var error:NSError?
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: &error)
        println(error?.description)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: &error)
        println(error?.description)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        

    }

    @IBAction func stopRecording(sender: UIButton) {
        println("stop recording")
        
        //Inside func stopAudio(sender: UIButton)
        audioRecorder.stop()
        
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if ( segue.identifier == "stopRecording" ) {
            var dest = segue.destinationViewController as! PlaySoundsViewController
            dest.recordedAudio = recordedAudio            
        }
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        println("didfinish")
        if (flag) {
            self.recordedAudio = RecordedAudio()
            self.recordedAudio.filePathUrl = recorder.url
            self.recordedAudio.title = recorder.url.lastPathComponent
            self.performSegueWithIdentifier("stopRecording", sender: self.recordedAudio)
        }
        else{
            println("recording failed")
            
        }
        recordingLabel.hidden = true
        stopButton.hidden = true
        startButton.enabled = true
        
    }
}

