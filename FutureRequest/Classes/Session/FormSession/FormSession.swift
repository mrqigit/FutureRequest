//
//  FormSession.swift
//  FutureRequest
//
//  Created by MrQi on 2025/3/13.
//

import Foundation

public class FormSession: FutureSession, FormProtocol {
    
    private static var instance: FormSession?
    
    public class func shareInstance(baseUrl: String? = nil) -> FormSession {
        if instance != nil {
            return instance!
        }
        instance = FormSession.init(config: SessionConfig(), baseUrl: baseUrl)
        return instance!
    }

    public func request(method: Method, progress: ProgressComplent?) async throws -> Response {
        var result: ResponseEnum = .fail(response: response_400)
        if case .get(_, _) = method {
            result = configRequest(
                method: .get,
                url: method.url,
                query: method.query,
                params: method.params,
                progress: progress
            )
        } else if case .post(_, _) = method {
            result = configRequest(
                method: .post,
                url: method.url,
                query: method.query,
                params: method.params,
                progress: progress
            )
        } else if case .put(_, _) = method {
            result = configRequest(
                method: .put,
                url: method.url,
                query: method.query,
                params: method.params,
                progress: progress
            )
        } else if case .delete(_, _) = method {
            result = configRequest(
                method: .delete,
                url: method.url,
                query: method.query,
                params: method.params,
                progress: progress
            )
        } else if case .patch(_, _) = method {
            result = configRequest(
                method: .patch,
                url: method.url,
                query: method.query,
                params: method.params,
                progress: progress
            )
        }
        if case let .fail(response) = result {
            return response
        } else if case let .succ(request) = result {
            return try! await requestSessionTask(requestURL: request)
        }
        return response_400
    }
    
    private func requestSessionTask(requestURL: URLRequest) async throws -> Response {
        return await withCheckedContinuation { continuation in
            let uRLSessionDataTask = session.dataTask(with: requestURL) { (
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
                        .resume(returning: Response(code: 200, data: data))
                }
            }
            uRLSessionDataTask.resume()
        }
    }
}
