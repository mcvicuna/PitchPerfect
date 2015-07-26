//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Mark Vicuna on 7/25/15.
//  Copyright (c) 2015 Mark Vicuna. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
 
    @IBOutlet weak var stopButton: UIButton!
    
    // internal variables
    var player : AVAudioPlayer!
    var recordedAudio : RecordedAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func playSound(sound: NSURL!, rate: Float) {
        
        if(sound != nil) {
            var error:NSError?
            
            println(sound)
            AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, error: &error)
            
            
            if (error != nil) {
                println(error)
            }
            
            AVAudioSession.sharedInstance().setActive(true, error: &error)
            
            if (error != nil) {
                println(error)
            }
            
            
            
            self.player = AVAudioPlayer(contentsOfURL: sound, error: &error)
            
            
            
            if (error != nil) {
                println(error)
            }
            else {
                stopButton.enabled = true
            
                self.player.enableRate = true
                self.player.rate = rate
            
                self.player.stop()
                self.player.prepareToPlay()
                self.player.play()
            }
        }
        else {
            println("failed to load file")
            return
            
        }
    }
    
    
    @IBAction func playFast(sender: UIButton) {
        println("playFast")
        self.playSound(recordedAudio.filePathUrl, rate: 1.5)
        
        
    }
    
    @IBAction func playSlow(sender: AnyObject) {
        println("playSlow")
        self.playSound(recordedAudio.filePathUrl, rate: 0.5)
    }

    @IBAction func playStop(sender: UIButton) {
        stopButton.enabled = false
        self.player.stop()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
