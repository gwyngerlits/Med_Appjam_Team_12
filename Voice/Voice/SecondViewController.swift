//
//  SecondViewController.swift
//  Voice
//
//  Created by Gwyn Gerlits on 11/15/15.
//  Copyright © 2015 Team12. All rights reserved.
//

import UIKit
import AVFoundation

class SecondViewController: UIViewController {
    // MARK: Properties
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var current: UILabel!
    @IBOutlet weak var duration: UILabel!
    
    var audioPlayer:AVAudioPlayer!
    
    // MARK: Settup
    override func viewDidLoad() {
        super.viewDidLoad()
        initializePlayer()
        //audioPlayer.play()
        // Do any additional setup after loading the view, typically from a nib.
        NSTimer.scheduledTimerWithTimeInterval(0.0001, target: self, selector: "display", userInfo: nil, repeats: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Helpers
    func initializePlayer(){
        //init
        let audioSession:AVAudioSession = AVAudioSession.sharedInstance()
        
        //set category and activate player session
        try! audioSession.setCategory(AVAudioSessionCategoryPlayback)
        try! audioSession.setActive(true)
        
        //get documents directory
        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory,inDomains: .UserDomainMask)[0]
        let url = documentsURL.URLByAppendingPathComponent("voiceRecording.caf")
        print(url)
        //link player to track
        try! self.audioPlayer = AVAudioPlayer(contentsOfURL: url)
    }
    
    func timeToString(time: Int) -> String{
        let seconds = ((time%60 < 10) ? "0" : "") + String(time%60)
        let minutes = String(time / 60)
        return minutes + ":" + seconds
    }
    
    func display(){
        if (audioPlayer != nil){
            current.text = timeToString(Int(audioPlayer.currentTime))
            duration.text = timeToString(Int(audioPlayer.duration))
            slider.value = Float(audioPlayer.currentTime / audioPlayer.duration)
            if (!audioPlayer.playing){
                playButton.setImage(UIImage(named:"play.png"), forState: UIControlState.Normal)
            }
        }
    }
    
    // MARK: Actions
    @IBAction func playButtonPush(sender: AnyObject) {
        if (audioPlayer.playing) {
            sender.setImage(UIImage(named:"play.png"), forState: UIControlState.Normal)
            audioPlayer.pause()
        } else {
            sender.setImage(UIImage(named:"pause.png"), forState: UIControlState.Normal)
            audioPlayer.play()
            
        }
    }

}