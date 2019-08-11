//
//  CanvasColorStyle.swift
//  CanvasDemo
//
//  Created by Osei Fortune on 7/16/19.
//  Copyright © 2019 Osei Fortune. All rights reserved.
//

import Foundation
import UIKit

@objc public enum CanvasColorStyleType: Int, RawRepresentable {
    case Color
    case Gradient
    case Pattern
    public typealias RawValue = String
    
    public var rawValue: RawValue {
        switch self {
        case .Color:
            return "color"
        case .Gradient:
            return "gradient"
        case .Pattern:
            return "pattern"
        }
    }
    
    
    public init?(rawValue: RawValue) {
        switch rawValue {
        case "gradient":
            self = .Gradient
        case "pattern":
            self = .Pattern
        default:
            self = .Color
        }
    }
    
}

public protocol ICanvasColorStyle {
    func getStyleType() ->  CanvasColorStyleType
}

@objc public enum PatternRepetition: Int, RawRepresentable {
    case Repeat
    case RepeatX
    case RepeatY
    case NoRepeat
    
    public typealias RawValue = String
    
    public var rawValue: String {
        switch self {
        case .RepeatX:
            return "repeat-x"
        case .RepeatY:
            return "repeat-y"
        case .NoRepeat:
            return "no-repeat"
        default:
            return "repeat"
        }
    }
    public init?(rawValue: RawValue) {
        switch rawValue {
        case "repeat-x":
            self = .RepeatX
        case "repeat-y":
            self = .RepeatY
        case "no-repeat":
            self = .NoRepeat
        default:
            self = .Repeat
        }
    }
}

public class CanvasColorStyle: NSObject {
    public class Color:ICanvasColorStyle {
        var color: UIColor
        public init(color: UIColor) {
            self.color = color
        }
        
        public func getStyleType() -> CanvasColorStyleType {
            return .Color
        }
    }
    
    public class Gradient:ICanvasColorStyle {
        var gradientMap: NSMutableDictionary = [:]
        
        public func getStyleType() -> CanvasColorStyleType {
            return .Gradient
        }
        
        public func addColorStop(offset: Float, color: UIColor){
            if (offset < 0) {
                return
            }
            
            if (offset > 1) {
                return
            }
            gradientMap[offset] = Int(color.colorCode)
        }
        
        func getPostions() -> [Float] {
            return gradientMap.allKeys as! [Float]
        }
        
        func getColors() -> [Int] {
            return gradientMap.allValues as! [Int]
        }
    }
    
    
    public class LinearGradient: Gradient {
        let x0: Float
        let y0: Float
        let x1: Float
        let y1: Float
        
        public init(x0: Float, y0: Float, x1: Float, y1: Float) {
            self.x0 = x0
            self.y0 = y0
            self.x1 = x1
            self.y1 = y1
        }
    }
    
    public class RadialGradient: Gradient {
        let x0: Float
        let y0: Float
        let r0: Float
        let x1: Float
        let y1: Float
        let r1: Float
        
        public init(x0:Float, y0: Float, r0: Float, x1: Float, y1: Float, r1: Float) {
            self.x0 = x0
            self.y0 = y0
            self.r0 = r0
            self.r1 = r1
            self.x1 = x1
            self.y1 = y1
        }
    }
    
    public class Pattern:ICanvasColorStyle {
        let src: AnyObject
        let pattern: PatternRepetition
        public init(src: AnyObject, pattern: PatternRepetition){
            self.src = src
            self.pattern = pattern
        }
        
        public func getStyleType() -> CanvasColorStyleType {
            return .Pattern
        }
    }
}

