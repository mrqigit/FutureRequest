//
//  Requestor.swift
//  FutureRequest
//
//  Created by MrQi on 2025/3/13.
//

import Foundation

public enum Method: MethodProtocol {
    
    case get(url: String, query: Query? = nil)
    case post(url: String, params: Params? = nil)
    case put(url: String, params: Params? = nil)
    case delete(url: String, params: Params? = nil)
    case patch(url: String, params: Params? = nil)
    
    var url: String? {
        switch self {
        case let .get(url: url, query: _):
            return url
        case let .post(url: url, params: _):
            return url
        case let .put(url: url, params: _):
            return url
        case let .delete(url: url, params: _):
            return url
        case let .patch(url: url, params: _):
            return url
        default:
            return nil
        }
    }
    
    var query: Query? {
        switch self {
        case let .get(url: _, query: query):
            return query
        default:
            return nil
        }
    }
    
    var params: Params? {
        switch self {
        case let .post(url: _, params: params):
            return params
        case let .put(url: _, params: params):
            return params
        case let .delete(url: _, params: params):
            return params
        case let .patch(url: _, params: params):
            return params
        default:
            return nil
        }
    }
}

public enum MethodType: String {
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
