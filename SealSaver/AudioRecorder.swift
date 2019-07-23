//
//  AudioRecorder.swift
//  SealSaver
//
//  Created by Christie  on 7/22/19.
//  Copyright © 2019 Christie Frush. All rights reserved.
//

import Foundation
import AVFoundation

final class RecordEngine {
    private var engine: AVAudioEngine!
    private var mixer: AVAudioMixerNode!
    private var player: AVAudioPlayerNode!
    private var outputFile: AVAudioFile!
    
    let session = AVAudioSession.sharedInstance()
    
    init() {
        prepareAVAudioSession()
        prepareNodes()
        prepare()
    }
    
    func start() {
        try! engine.start()
    }
    
    func stop() {
//        engine.pause()
        engine.reset()
    }
    
    private func prepareAVAudioSession() {
        do {
            //            try session.setCategory(.playAndRecord, mode: .default, options: [.allowBluetooth, .allowBluetoothA2DP])
            try session.setCategory(.playAndRecord, mode: .default, options: .defaultToSpeaker)
            try session.setActive(true)
        } catch {
            
        }
    }
    
    private func prepareNodes() {
        engine = AVAudioEngine()
        mixer = AVAudioMixerNode()
        player = AVAudioPlayerNode()
        engine.attach(mixer)
        engine.attach(player)
    }
    
    private func prepare() {
        let input = engine.inputNode
        let mainMixer = engine.mainMixerNode
        
        let format = input.outputFormat(forBus: 0)
        engine.connect(player, to: mainMixer, format: format)
        engine.connect(input, to: mixer, format: format)
        engine.prepare()
    }
    
    func startRecord() {
        start()
        
        let format = mixer.outputFormat(forBus: 0)
        let outputFileURL = URL(string: NSTemporaryDirectory() + "temp.caf")!
        
        do {
            outputFile = try AVAudioFile(forWriting: outputFileURL, settings: format.settings)
        } catch {
            print(error)
        }
        
        mixer.installTap(onBus: 0, bufferSize: 1024, format: format) { [weak self] buffer, when in
            do {
                try self?.outputFile.write(from: buffer)
                print(buffer)
            } catch {
                print(error)
            }
        }
    }
    
    func stopRecord() {
        engine.stop()
        mixer.removeTap(onBus: 0)
        print(outputFile)
        stop()
    }
    
    func startPlaying() {
        start()
        
        player.scheduleFile(outputFile, at: nil) {
            print("complete")
        }
        
        player.play()
    }
    
    func pausePlaying() {
        player.pause()
    }
}
