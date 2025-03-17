//
//  DownloadSession.swift
//  FutureRequest
//
//  Created by MrQi on 2025/3/13.
//

import Foundation

public class DownloadSession: FutureSession, DownloadProtocol {
    
    func download(url: String?, resumeData: Data?, params: Params?, progress: @escaping ProgressComplent) async throws -> Response {
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
        return await withCheckedContinuation { continuation in
            let urlSession = URLSession.init(
                configuration: config.config,
                delegate: proxy,
                delegateQueue: queue
            )
            var downloadTask: URLSessionDownloadTask?
            if resumeData == nil {
                downloadTask = urlSession
                    .downloadTask(with: requestURL) { (url, response, error) in
                        if error != nil {
                            continuation
                                .resume(
                                    returning: Response(
                                        code: 400,
                                        msg: error?.localizedDescription
                                    )
                                )
                        } else {
                            continuation
                                .resume(
                                    returning: Response(
                                        code: 200,
                                        data: response
                                    )
                                )
                        }
                    }
            } else {
                urlSession.downloadTask(with: requestURL)
                downloadTask = urlSession
                    .downloadTask(withResumeData: resumeData!){ (
                        url,
                        response,
                        error
                    ) in
                        if error != nil {
                            continuation
                                .resume(
                                    returning: Response(
                                        code: 400,
                                        msg: error?.localizedDescription
                                    )
                                )
                        } else {
                            continuation
                                .resume(
                                    returning: Response(
                                        code: 200,
                                        data: response
                                    )
                                )
                        }
                    }
            }
            downloadTask?.resume()
        }
    }
}
