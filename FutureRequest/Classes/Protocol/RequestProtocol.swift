//
//  RequestProtocol.swift
//  FutureRequest
//
//  Created by MrQi on 2025/3/13.
//

import Foundation

/// 表单获取或提交协议
internal protocol FormProtocol {
    
    func request(method: Method, progress: ProgressComplent?) async throws -> Response
}

/// 文件下载协议
internal protocol DownloadProtocol {
    
    func download(url: String?, resumeData: Data?, params: Params?, progress: @escaping ProgressComplent) async throws -> Response
}

/// 文件上传协议
internal protocol UploadProtocol {
    
    func upload(url: String?, forFile: Data?, resumeData: Data?, params: Params?, progress: @escaping @Sendable ProgressComplent) async throws -> Response
    
    func upload(url: String?, forURL: URL?, resumeData: Data?, params: Params, progress: @escaping @Sendable ProgressComplent) async throws -> Response
    
    func upload(url: String?, forPath: String?, resumeData: Data?, params: Params?, progress: @escaping @Sendable ProgressComplent) async throws -> Response
}

internal protocol MethodProtocol {
    
    var url: String? {get}
    var query: Query? {get}
    var params: Params? {get}
}
