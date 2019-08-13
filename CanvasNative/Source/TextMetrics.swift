//
//  TextMetrics.swift
//
//  Created by Osei Fortune on 7/15/19.
//  Copyright © 2019 Osei Fortune. All rights reserved.
//

import Foundation
public class TextMetrics: NSObject {
    private var _width: Float = 0
    init(metrics: CanvasTextMetrics) {
        _width = metrics.width
        native_drop_text_metrics(metrics)
    }
    
    public var width: Float {
        get {
            return _width
        }
    }
}
