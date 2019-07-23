//
//  ViewController.swift
//  SealSaver
//
//  Created by Christie  on 7/12/19.
//  Copyright © 2019 Christie Frush. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
//
//    let engine = AVAudioEngine()
//    let EQNode = AVAudioUnitEQ()
//    let audioMixer = AVAudioMixerNode()
//    let micMixer = AVAudioMixerNode()
//    let audioPlayerNode = AVAudioPlayerNode()
//    var audioPlayerFile: AVAudioFile?
//    var audioURL: URL?
//    var recordedOutputFile: AVAudioFile?
//    @IBOutlet weak var recordBTN: UIButton!
//    @IBOutlet weak var playBTN: UIButton!
//    @IBOutlet weak var stopBTN: UIButton!
    var engine: RecordEngine!
    @IBOutlet weak var recordBTN: UIButton!
    @IBOutlet weak var stopBTN: UIButton!
    @IBOutlet weak var playBTN: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        engine = RecordEngine.init()
    }
    
    @IBAction func record(_ sender: Any) {
        engine.startRecord()
    }
    @IBAction func stop(_ sender: Any) {
        engine.stopRecord()
    }
    @IBAction func play(_ sender: Any) {
        engine.startPlaying()
    }
}
