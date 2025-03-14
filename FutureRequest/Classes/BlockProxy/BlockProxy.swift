//
//  BlockProxy.swift
//  FutureRequest
//
//  Created by MrQi on 2025/3/14.
//

import Foundation
import CoreFoundation

public class BlockProxy: NSObject {
    
    weak var target: NSObject?
    var progress: ProgressComplent?
    
    required init(target: NSObject?, progress: ProgressComplent?) {
        self.target = target
        self.progress = progress
        super.init()
    }
}

extension BlockProxy: URLSessionDelegate {
    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge) async -> (URLSession.AuthChallengeDisposition, URLCredential?) {
        
    }
}
