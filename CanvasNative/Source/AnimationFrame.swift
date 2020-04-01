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
    static var callbacks: [String: (Float) -> Void] = [:]
    static var exitObserver: Any?
    static var enterObserver: Any?
    @objc static func handleAnimation(displayLink: CADisplayLink){
        let time =  (displayLink.timestamp - displayLink.duration) * 1000
        for (id,callback) in callbacks {
            callback(Float(time))
            callbacks.removeValue(forKey: id)
        }
        if(callbacks.count == 0){
            self.displayLink?.invalidate()
            self.displayLink = nil
        }
    }
    
    public static func requestAnimationFrame(toLoop: @escaping (Float) -> Void){
        callbacks[UUID().uuidString] = toLoop
        if(displayLink == nil){
            displayLink = CADisplayLink(target: self, selector: #selector(handleAnimation))
            displayLink?.preferredFramesPerSecond = 60
            displayLink?.add(to: .current, forMode: .common)
            
            exitObserver = NotificationCenter.default.addObserver(forName: UIApplication.didEnterBackgroundNotification, object: nil, queue: nil) { _ in
                self.displayLink?.invalidate()
                self.displayLink = nil
            }
            
            enterObserver = NotificationCenter.default.addObserver(forName: UIApplication.didBecomeActiveNotification, object: nil, queue: nil) { _ in
                displayLink = CADisplayLink(target: self, selector: #selector(handleAnimation))
                displayLink?.preferredFramesPerSecond = 60
                displayLink?.add(to: .current, forMode: .common)
            }
            
        }
    }
    
    public static func cancelAnimationFrame(id: String){
        callbacks.removeValue(forKey: id)
        if(callbacks.count == 0){
            displayLink?.invalidate()
            displayLink = nil
            if(exitObserver != nil){
                NotificationCenter.default.removeObserver(exitObserver!)
            }
            if(enterObserver != nil){
                NotificationCenter.default.removeObserver(enterObserver!)
            }
        }
    }
}
