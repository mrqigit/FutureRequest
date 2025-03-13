//
//  RequestProtocol.swift
//  FutureRequest
//
//  Created by MrQi on 2025/3/13.
//

import Foundation

typealias ProgressComplent = (_ progress: Progress, _ request: URLRequest) -> Void

/// 表单获取或提交协议
internal protocol FormProtocol {
    
    func get(url: String?, progress: @escaping @Sendable ProgressComplent, query: [String: Any?]?) -> Response
    
    func post(url: String?, progress: @escaping @Sendable ProgressComplent, params: [String: Any?]?) -> Response
    
    func put(url: String?, progress: @escaping @Sendable ProgressComplent, params: [String: Any?]?) -> Response
    
    func delete(url: String?, progress: @escaping @Sendable ProgressComplent, params: [String: Any?]?) -> Response
    
    func patch(url: String?, progress: @escaping @Sendable ProgressComplent, params: [String: Any?]?) -> Response
}

/// 文件下载协议
internal protocol DownloadProtocol {
    
    func download(url: String?, progress: @escaping @Sendable ProgressComplent, resumeData: Data?, params: [String: Any?]?) -> Response
}

/// 文件上传协议
internal protocol UploadProtocol {
    
    func upload(url: String?, progress: @escaping @Sendable ProgressComplent, forFile: Data?, resumeData: Data?, params: [String: Any?]?) -> Response
    
    func upload(url: String?, progress: @escaping @Sendable ProgressComplent, forURL: URL?, resumeData: Data?, params: [String: Any?]?) -> Response
    
    func upload(url: String?, progress: @escaping @Sendable ProgressComplent, forPath: String?, resumeData: Data?, params: [String: Any?]?) -> Response
}

