//
//  UploadSession.swift
//  FutureRequest
//
//  Created by MrQi on 2025/3/13.
//

import Foundation

public class UploadSession: FutureSession, UploadProtocol {
    func upload(url: String?, forFile: Data?, resumeData: Data?, params: Params?, progress: @escaping ProgressComplent) async throws -> Response {
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
            if resumeData != nil {
                return try! await uploadTask(
                    requestURL: request,
                    resumeData: resumeData
                )
            } else if forFile != nil {
                return try! await requestSessionTask(
                    requestURL: request,
                    form: forFile
                )
            } else {
                return response_upload
            }
        }
        return response_400
    }
    
    func upload(url: String?, forURL: URL?, resumeData: Data?, params: Params, progress: @escaping ProgressComplent) async throws -> Response {
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
            if resumeData != nil {
                return try! await uploadTask(
                    requestURL: request,
                    resumeData: resumeData
                )
            } else if forURL != nil {
                return try! await requestSessionTask(
                    requestURL: request,
                    form: forURL
                )
            } else {
                return response_upload
            }
        }
        return response_400
    }
    
    func upload(url: String?, forPath: String?, resumeData: Data?, params: Params?, progress: @escaping ProgressComplent) async throws -> Response {
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
            if resumeData != nil {
                return try! await uploadTask(
                    requestURL: request,
                    resumeData: resumeData
                )
            } else if forPath != nil {
                return try! await requestSessionTask(
                    requestURL: request,
                    form: forPath
                )
            } else {
                return response_upload
            }
        }
        return response_400
    }
    
    private func requestSessionTask(requestURL: URLRequest, form: Any?) async throws -> Response {
        return await withCheckedContinuation { continuation in
            var uRLSessionDataTask: URLSessionUploadTask?
            
            if form is URL {
                uRLSessionDataTask = session
                    .uploadTask(
                        with: requestURL,
                        fromFile: form as! URL,
                        completionHandler: { (
                            data,
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
                                            data: data
                                        )
                                    )
                            }
                        })
            } else if form is String {
                guard let uRL = URL.init(
                    string: form as! String
                ) else { return continuation
                        .resume(
                            returning: response_400
                        ) }
                uRLSessionDataTask = session
                    .uploadTask(
                        with: requestURL,
                        fromFile: uRL,
                        completionHandler: { (
                            data,
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
                                            data: data
                                        )
                                    )
                            }
                        })
            } else if form is Data {
                uRLSessionDataTask = session
                    .uploadTask(with: requestURL, from: form as? Data, completionHandler: { (
                        data,
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
                                        data: data
                                    )
                                )
                        }
                    })
            }
            uRLSessionDataTask?.resume()
        }
    }
    
    private func uploadTask(requestURL: URLRequest, resumeData: Data?) async throws -> Response {
        return await withCheckedContinuation { continuation in
            var uRLSessionDataTask: URLSessionUploadTask?
            if #available(iOS 17.0, *) {
                uRLSessionDataTask = session
                    .uploadTask(withResumeData: resumeData!) { (
                        data,
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
                                    returning: Response(code: 200, data: data)
                                )
                        }
                    }
            } else {
                //                requestURL.setValue("bytes=\(resumeData!.count)", forHTTPHeaderField: "Content-Range")
                uRLSessionDataTask = session
                    .uploadTask(with: requestURL, from: resumeData!) { (
                        data,
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
                                    returning: Response(code: 200, data: data)
                                )
                        }
                    }
            }
            uRLSessionDataTask?.resume()
        }
    }
}
