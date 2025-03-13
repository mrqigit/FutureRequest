//
//  SessionConfig.swift
//  FutureRequest
//
//  Created by MrQi on 2025/3/13.
//

import Foundation

public class SessionConfig: NSObject {
    
    /// 缓存策略
    /// useProtocolCachePolicy: 默认缓存策略，如果缓存不存在，直接从服务器获取，如果缓存存在，会根据response中的Cache-Control字段哦安短下一步操作，如果Cacha-Control字段为must-revalidata，则询问服务端改数据是否更新，无更新的话直接返回给用户缓存数据，若已更新，则请求服务端
    /// reloadIgnoringLocalAndRemoteCacheData: 忽略本地以及代理，直接请求服务器
    /// reloadIgnoringLocalCacheData && reloadIgnoringCacheData: 忽略本地缓存，每次直接从服务端请求数据
    /// returnCacheDataElseLoad: 只有当没有缓存数据才会请求服务器
    /// returnCacheDataDontLoad: 使用现有缓存数据，而不考虑使用期限或到期日期，如果没有可用的缓存数据，则失败
    /// reloadRevalidatingCacheData: 如果服务端可以验证缓存疏忽，则使用缓存数据，否则从服务器加载
    var requestCachePolicy: NSURLRequest.CachePolicy
        
    /// 建立请求超时时间
    var timeoutIntervalForRequest: TimeInterval
        
    /// 请求建立后获取数据超时时间
    var timeoutIntervalForResource: TimeInterval
    
    /// 是否启用DNS解析验证
    var requiresDNSSECValidation: Bool
       
    /// 指示会话是应等待连接变为可用，还是立即失败
    var waitsForConnectivity: Bool
       
    /// 用于确定是否可以由系统自行决定安排后台任务以获得最佳性能
    var isDiscretionary: Bool
    
    /// 指示传输完成后应是否应在后台恢复或启动应用程序
    var sessionSendsLaunchEvents: Bool
    
    /// 要与请求一起发送的其他标头的字典。
    var httpAdditionalHeaders: [AnyHashable : Any]?
    
    /// 要与给定主机建立的最大同时连接数。
    var httpMaximumConnectionsPerHost: Int
    
    /// 用于在此会话中存储 Cookie 的 Cookie 存储。
    var httpCookieStorage: HTTPCookieStorage?
       
    /// 提供用于身份验证的凭据的凭据存储。
    var urlCredentialStorage: URLCredentialStorage?
       
    /// 用于为会话中的请求提供缓存响应的 URL 缓存。
    var urlCache: URLCache?
       
    /// 指示当应用程序移至后台时是否应保持 TCP 连接打开状态。
    var shouldUseExtendedBackgroundIdleMode: Bool
    
    var config: URLSessionConfiguration {
        let _config = URLSessionConfiguration.default
        _config.requestCachePolicy = requestCachePolicy
        _config.timeoutIntervalForRequest = timeoutIntervalForRequest
        _config.timeoutIntervalForResource = timeoutIntervalForResource
        if #available(iOS 16.0, *) {
            _config.requiresDNSSECValidation = requiresDNSSECValidation
        }
        if #available(iOS 11.0, *) {
            _config.waitsForConnectivity = waitsForConnectivity
        }
        _config.isDiscretionary = isDiscretionary
        _config.sessionSendsLaunchEvents = sessionSendsLaunchEvents
        _config.httpAdditionalHeaders = httpAdditionalHeaders
        _config.httpMaximumConnectionsPerHost = httpMaximumConnectionsPerHost
        _config.httpCookieStorage = httpCookieStorage
        _config.urlCredentialStorage = urlCredentialStorage
        _config.urlCache = urlCache
        _config.shouldUseExtendedBackgroundIdleMode = shouldUseExtendedBackgroundIdleMode
        return _config
    }
    
    override init() {
        self.requestCachePolicy = .useProtocolCachePolicy
        self.timeoutIntervalForRequest = 15
        self.timeoutIntervalForResource = 15
        self.requiresDNSSECValidation = true
        self.waitsForConnectivity = true
        self.isDiscretionary = true
        self.sessionSendsLaunchEvents = true
        self.httpAdditionalHeaders = [:]
        self.httpMaximumConnectionsPerHost = 4
        self.httpCookieStorage = HTTPCookieStorage.shared
        self.urlCredentialStorage = URLCredentialStorage.shared
        self.urlCache = URLCache.shared
        self.shouldUseExtendedBackgroundIdleMode = true
        
        super.init()
    }
}
