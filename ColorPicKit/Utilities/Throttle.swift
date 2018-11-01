//
//  Throttle.swift
//  HatchKit
//
//  Created by Zakk Hoyt on 10/13/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import Foundation

public class Throttle {

    private static var _tokens = [String: Date]()
    
    public class func limitTo(file: String = #file, function: String = #function, line: Int = #line, every: TimeInterval, block:()->Void) {
        let token = file + ":" + function + ":" + String(line)
        limitTo(token: token, every:every, block: block)
    }
    
    
    public class func limitTo(token: String, every: TimeInterval, block:()->Void) {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        
    
        // Has been executed before
        if let lastDate = _tokens[token] {
            let now = Date()
            if now.timeIntervalSince(lastDate) > every {
                _tokens[token] = now
                block()
            }
        } else {
            // Has never been executed
            _tokens[token] = Date()
            block()
        }
    }
}
