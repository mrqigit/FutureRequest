//
//  Requestor.swift
//  FutureRequest
//
//  Created by MrQi on 2025/3/13.
//

import Foundation

internal class Requestor: NSObject {
    
    var method: Method
    var contentType: ContentType
    var url: String?
    var params: [String: Any?]
    
    required init(method: Method, contentType: ContentType, url: String?, params: [String : Any?]) {
        self.method = method
        self.contentType = contentType
        self.url = url
        self.params = params
        
        super.init()
    }
}

public enum Method: String {
    case get = "get"
    case post = "post"
    case put = "put"
    case delete = "delete"
    case patch = "patch"
}

public enum ContentType: String {
    case json = "application/json"
    case xml = "application/xml"
    case x_form = "application/x-www-form-urlencoded"
    case form_data = "multipart/form-data"
    case html = "text/html"
    case plain = "text/plain"
    case css = "text/css"
    case javascript = "text/javascript"
    case jpeg = "image/jpeg"
    case png = "image/png"
    case gif = "image/gif"
    case mpeg = "audio/mpeg"
    case mp4 = "video/mp4"
    case pdf = "application/pdf"
    case zip = "application/zip"
}

