//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Mark Vicuna on 7/25/15.
//  Copyright (c) 2015 Mark Vicuna. All rights reserved.
//

import UIKit
import AVFoundation

extension AVAudioUnitTimePitch {
    convenience init(rate: Float) {
        self.init()
        self.rate = rate
    }
    convenience init(pitch: Float) {
        self.init()
        self.pitch = pitch
    }
}

class PlaySoundsViewController: UIViewController {
 
    @IBOutlet weak var stopButton: UIButton!
    
    // internal variables
    var engine : AVAudioEngine?
    var recordedAudio : RecordedAudio?
    var player : AVAudioPlayerNode?
    

    
    func playSound(sound: AVAudioFile!, nodes: [AVAudioNode]) {
        
        if let sound = sound {
            var error:NSError?

            AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, error: &error)
            
            
            if let error = error {
                println(error)
            }
            
            AVAudioSession.sharedInstance().setActive(true, error: &error)
            
            if let error = error {
                println(error)
            }
            
            // clean up last playback, if it happened
            player?.stop()
            engine?.stop()
            engine?.reset()
            
            
            engine = AVAudioEngine()
            player = AVAudioPlayerNode()
            if let engine = engine {
                
                engine.attachNode(player)
                
                // initialize the last node to
                var lastNode: AVAudioNode! = player
                
                for currentNode in nodes {
                    engine.attachNode(currentNode)
                    engine.connect(lastNode, to: currentNode, format: nil)
                    lastNode = currentNode
                }
                
                engine.connect(lastNode!, to: engine.outputNode, format: nil)
                
                player?.scheduleFile(sound, atTime: nil, completionHandler: nil)
                engine.startAndReturnError(&error)
                if let error = error {
                    println(error)
                }
                else {
                    stopButton.enabled = true
                    
                    player?.play()
                }
            }
        }
        else {
            println("failed to load file")
            return
            
        }
    }
    
    @IBAction func playChipmunk(sender: UIButton) {
        println("chipmunk")
        playSound(AVAudioFile(forReading: recordedAudio?.filePathUrl, error: nil), nodes: [AVAudioUnitTimePitch(pitch: 1000.0)])
    }
    
    @IBAction func playDarth(sender: UIButton) {
        println("darth")
        playSound(AVAudioFile(forReading: recordedAudio?.filePathUrl, error: nil), nodes: [AVAudioUnitTimePitch(pitch: -1000.0)])
    }
    
    @IBAction func playFast(sender: UIButton) {
        println("playFast")
        playSound(AVAudioFile(forReading: recordedAudio?.filePathUrl, error: nil), nodes: [AVAudioUnitTimePitch(rate: 1.5)])
        
        
    }
    
    @IBAction func playSlow(sender: AnyObject) {
        println("playSlow")
            playSound(AVAudioFile(forReading: recordedAudio?.filePathUrl, error: nil), nodes: [AVAudioUnitTimePitch(rate: 0.5)])
        
    }

    @IBAction func playStop(sender: UIButton) {
        stopButton.enabled = false
        player?.stop()
        engine?.stop()
    }

}
