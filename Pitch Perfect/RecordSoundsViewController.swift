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

    // class attributes
    var audioRecorder : AVAudioRecorder!
    var recordedAudio : RecordedAudio!
    
    // outlet functions
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    @IBAction func recordAudio(sender: UIButton) {
        println("start recording")

       
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        
        let recordingName = "current.caf"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        
        var error:NSError?
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: &error)
        if let error = error {
            println(error.description)
        }

        var recordSettings:[NSObject : AnyObject] = [AVSampleRateConverterAudioQualityKey: AVAudioQuality.Medium.rawValue]
        audioRecorder = AVAudioRecorder(URL: filePath, settings: recordSettings, error: &error)
        if let error = error {
            println(error.description)
        }
        else {
            recordingLabel.text = "Recording..."
            audioRecorder.delegate = self
            audioRecorder.meteringEnabled = true
            audioRecorder.prepareToRecord()
            audioRecorder.record()
            stopButton.hidden = false
            startButton.enabled = false
        }
        

    }

    @IBAction func stopRecording(sender: UIButton) {
        println("stop recording")
        
        audioRecorder?.stop()
        
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
            recordedAudio = RecordedAudio(url: recorder.url)
            performSegueWithIdentifier("stopRecording", sender: self.recordedAudio)
        }
        else{
            println("recording failed")
        }
        recordingLabel.text = "Tap to Record"
        stopButton.hidden = true
        startButton.enabled = true
        
    }
}

