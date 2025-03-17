//
//  FutureSession.swift
//  FutureRequest
//
//  Created by MrQi on 2025/3/13.
//

import Foundation

public class FutureSession: NSObject {
    
    public var config: SessionConfig
    public var baseUrl: String? { return _baseUrl }
    private var _baseUrl: String?
    public var proxy: BlockProxy?
    public var queue: OperationQueue?
    
    required init(config: SessionConfig, baseUrl: String?) {
        self.config = config
        self._baseUrl = baseUrl
        self.queue = OperationQueue()
        
        super.init()
    }
    
    public func configRequest(method: MethodType, url: String?, query: Query?, params: Params?, progress: @escaping ProgressComplent) -> ResponseEnum {
        let validRes = checkUrlValid(url: url)
        if case let .lose(response) = validRes {
            return .fail(response: response)
        } else if case let .valid(url) = validRes {
            guard let _url = URL.init(string: url) else {
                return .fail(response: response_400)
            }
            var requestURL = URLRequest(url: _url)
            requestURL.httpMethod = method.rawValue
            if method != .get {
                requestURL.httpBody = params?.jsonParams?.data(using: .utf8)
            }
            proxy = BlockProxy.init(
                target: self,
                progress: progress,
                credential: config.credential
            )
            return .succ(request: requestURL)
        }
        return .fail(response: response_400)
    }
    
    private func checkUrlValid(url: String?) -> URLValid {
        guard var url = url else { return .lose(response: response_400)}
        if url.isHttp || url.isHttps {
            return .valid(url: url)
        }
        guard var baseUrl = baseUrl else {
            return .lose(response: response_404)
        }
        if baseUrl.isValidPath {
            let endIndex = baseUrl.index(baseUrl.endIndex, offsetBy: -1)
            baseUrl = String(baseUrl[baseUrl.startIndex...endIndex])
        }
        if url.isValidUrl {
            let startIndex = url.index(url.startIndex, offsetBy: 1)
            url = String(url[startIndex...url.endIndex])
        }
        return .valid(url: "\(baseUrl)/\(url)")
    }
    
    private enum URLValid {
        case valid(url: String)
        case lose(response: Response)
    }
}
