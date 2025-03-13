//
//  FutureSession.swift
//  FutureRequest
//
//  Created by MrQi on 2025/3/13.
//

import Foundation

public class FutureSession: NSObject {
    
    var config: SessionConfig
    var baseUrl: String? {return _baseUrl}
    private var _baseUrl: String?
    
    required init(config: SessionConfig, baseUrl: String?) {
        self.config = config
        self._baseUrl = baseUrl
        super.init()
    }
}
