//
//  Response.swift
//  FutureRequest
//
//  Created by MrQi on 2025/3/13.
//

import Foundation

public class Response: NSObject {
    
    public var code: Int
    public var msg: String?
    public var data: Any?
    
    init(code: Int, msg: String? = nil, data: Any? = nil) {
        self.code = code
        self.msg = msg
        self.data = data
    }
}

public enum ResponseEnum {
    case fail(response: Response)
    case succ(request: URLRequest)
}
