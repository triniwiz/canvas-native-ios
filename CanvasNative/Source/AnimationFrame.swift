//
//  AnimationFrame.swift
//  CanvasNative
//
//  Created by Osei Fortune on 8/12/19.
//

import Foundation
@objcMembers
@objc(AnimationFrame)
public class AnimationFrame: NSObject {
    static var displayLink: CADisplayLink?
    static var callbacks: [String: (Int) -> Void] = [:]
    @objc static func handleAnimation(displayLink: CADisplayLink){
        let time = (displayLink.timestamp - displayLink.duration) * 1000
        for (id,callback) in callbacks {
            callback(Int(time))
            callbacks.removeValue(forKey: id)
        }
        if(callbacks.count == 0){
            self.displayLink?.invalidate()
            self.displayLink = nil
        }
    }
    
    public static func requestAnimationFrame(toLoop: @escaping (Int) -> Void){
        callbacks[UUID().uuidString] = toLoop
        if(displayLink == nil){
            displayLink = CADisplayLink(target: self, selector: #selector(handleAnimation))
            displayLink?.preferredFramesPerSecond = 60
            displayLink?.add(to: .current, forMode: .common)
        }
        
    }
    
    public static func cancelAnimationFrame(id: String){
        callbacks.removeValue(forKey: id)
        if(callbacks.count == 0){
            displayLink?.invalidate()
            displayLink = nil
        }
    }
}
