//
//  DownloadSession.swift
//  FutureRequest
//
//  Created by MrQi on 2025/3/13.
//

import Foundation

@available(iOS 15.0, *)
public class DownloadSession: FutureSession, DownloadProtocol {
    
    private static var instance: DownloadSession?
    
    public class func shareInstance(baseUrl: String? = nil) -> DownloadSession {
        if instance != nil {
            return instance!
        }
        instance = DownloadSession.init(config: SessionConfig(), baseUrl: baseUrl)
        return instance!
    }
    
    public func download(url: String?, resumeData: Data?, params: Params?, progress: @escaping ProgressComplent) async throws -> Response {
        let result: ResponseEnum = configRequest(
            method: .post,
            url: url,
            query: nil,
            params: params,
            progress: progress
        )
        if case let .fail(response) = result {
            return response
        } else if case let .succ(request) = result {
            return try! await requestSessionTask(
                requestURL: request,
                resumeData: resumeData
            )
        }
        return response_400
    }
    
    private func requestSessionTask(requestURL: URLRequest, resumeData: Data?) async throws -> Response {
        if resumeData == nil {
            try await session.download(for: requestURL, delegate: proxy)
            return response_200
        } else {
            try await session.download(resumeFrom: resumeData!, delegate: proxy)
        }
        return response_200
    }
}
