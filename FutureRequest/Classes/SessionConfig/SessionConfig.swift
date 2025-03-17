//
//  SessionConfig.swift
//  FutureRequest
//
//  Created by MrQi on 2025/3/13.
//

import Foundation

public class SessionConfig: NSObject, NSCopying, @unchecked Sendable  {
    
    /// config类型
    var type: ConfigType
    
    /// HTTP认证用户密码
    var credential: Credential?
    
    /// 配置对象的后台会话标识符。
    var identifier: String? { return config.identifier }
    
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
    
    /// 网络会话中所有任务的网络服务类型，用于启用 Cellular Network Ssliceing。
    var networkServiceType: NSURLRequest.NetworkServiceType
    
    /// 用于确定是否应通过手机网络建立连接。
    var allowsCellularAccess: Bool
    
    /// 指示连接是否可以使用系统认为昂贵的网络接口。
    var allowsExpensiveNetworkAccess: Bool
    
    /// 指示当用户指定 Low Data Mode 时，连接是否可以使用网络。
    var allowsConstrainedNetworkAccess: Bool
    
    /// 是否启用DNS解析验证
    var requiresDNSSECValidation: Bool
       
    /// 指示会话是应等待连接变为可用，还是立即失败
    var waitsForConnectivity: Bool
       
    /// 用于确定是否可以由系统自行决定安排后台任务以获得最佳性能
    var isDiscretionary: Bool
    
    /// 共享容器的标识符，应将后台 URL 会话中的文件下载到该容器中。
    var sharedContainerIdentifier: String?
    
    /// 指示传输完成后应是否应在后台恢复或启动应用程序
    var sessionSendsLaunchEvents: Bool
    
    /// 代理的信息配置
    var connectionProxyDictionary: [AnyHashable : Any]?
    
    /// 最小协议版本
    var tlsMinimumSupportedProtocolVersion: tls_protocol_version_t
    
    /// 最大协议版本
    var tlsMaximumSupportedProtocolVersion: tls_protocol_version_t

    /// 用于确定会话是否应使用 HTTP 管道。
    var httpShouldUsePipelining: Bool
    
    /// 确定请求是否应包含来自 Cookie 存储的 Cookie。
    var httpShouldSetCookies: Bool
    
    /// 确定何时应接受 Cookie。
    var httpCookieAcceptPolicy: HTTPCookie.AcceptPolicy
    
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
    
    /// 处理 session 中请求的额外协议子类数组。
    var protocolClasses: [AnyClass]?
    
    /// 指定用于通过 Wi-Fi 和蜂窝接口传输数据的多路径 TCP 连接策略。
    var multipathServiceType: URLSessionConfiguration.MultipathServiceType
    
    var config: URLSessionConfiguration {
        var _config = URLSessionConfiguration.default
        switch type {
        case let .background(identifier: temp):
            _config = URLSessionConfiguration.background(withIdentifier: temp)
            break
        case .ephemeral:
            _config = URLSessionConfiguration.ephemeral
            break
        default:
            _config = URLSessionConfiguration.default
            break
        }
        _config.requestCachePolicy = requestCachePolicy
        _config.timeoutIntervalForRequest = timeoutIntervalForRequest
        _config.timeoutIntervalForResource = timeoutIntervalForResource
        _config.networkServiceType = networkServiceType
        _config.allowsCellularAccess = allowsCellularAccess
        _config.allowsExpensiveNetworkAccess = allowsExpensiveNetworkAccess
        _config.allowsConstrainedNetworkAccess = allowsConstrainedNetworkAccess
        if #available(iOS 16.0, *) {
            _config.requiresDNSSECValidation = requiresDNSSECValidation
        }
        _config.waitsForConnectivity = waitsForConnectivity
        _config.isDiscretionary = isDiscretionary
        _config.sharedContainerIdentifier = sharedContainerIdentifier
        _config.sessionSendsLaunchEvents = sessionSendsLaunchEvents
        _config.connectionProxyDictionary = connectionProxyDictionary
        _config.tlsMinimumSupportedProtocolVersion = tlsMinimumSupportedProtocolVersion
        _config.tlsMaximumSupportedProtocolVersion = tlsMaximumSupportedProtocolVersion
        _config.httpShouldUsePipelining = httpShouldUsePipelining
        _config.httpShouldSetCookies = httpShouldSetCookies
        _config.httpCookieAcceptPolicy = httpCookieAcceptPolicy
        _config.httpAdditionalHeaders = httpAdditionalHeaders
        _config.httpMaximumConnectionsPerHost = httpMaximumConnectionsPerHost
        _config.httpCookieStorage = httpCookieStorage
        _config.urlCredentialStorage = urlCredentialStorage
        _config.urlCache = urlCache
        _config.shouldUseExtendedBackgroundIdleMode = shouldUseExtendedBackgroundIdleMode
        _config.protocolClasses = protocolClasses
        _config.multipathServiceType = multipathServiceType
        return _config
    }
    
    private override init() {
        self.type = .default
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
        self.networkServiceType = .default
        self.allowsCellularAccess = true
        self.allowsExpensiveNetworkAccess = true
        self.allowsConstrainedNetworkAccess = true
        self.tlsMinimumSupportedProtocolVersion = .TLSv10
        self.tlsMaximumSupportedProtocolVersion = .DTLSv12
        self.httpShouldUsePipelining = true
        self.httpShouldSetCookies = true
        self.httpCookieAcceptPolicy = .always
        self.multipathServiceType = .aggregate
        super.init()
    }
    
    public init(type: ConfigType) {
        self.type = type
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
        self.networkServiceType = .default
        self.allowsCellularAccess = true
        self.allowsExpensiveNetworkAccess = true
        self.allowsConstrainedNetworkAccess = true
        self.tlsMinimumSupportedProtocolVersion = .TLSv10
        self.tlsMaximumSupportedProtocolVersion = .DTLSv12
        self.httpShouldUsePipelining = true
        self.httpShouldSetCookies = true
        self.httpCookieAcceptPolicy = .always
        self.multipathServiceType = .aggregate
        super.init()
    }
    
    public enum ConfigType {
        case `default`
        case ephemeral
        case background(identifier: String)
    }
    
    public func copy(with zone: NSZone? = nil) -> Any {
        let obj = SessionConfig(type: .default)
        obj.type = type
        obj.requestCachePolicy = requestCachePolicy
        obj.timeoutIntervalForRequest = timeoutIntervalForRequest
        obj.timeoutIntervalForResource = timeoutIntervalForResource
        obj.networkServiceType = networkServiceType
        obj.allowsCellularAccess = allowsCellularAccess
        obj.allowsExpensiveNetworkAccess = allowsExpensiveNetworkAccess
        obj.allowsConstrainedNetworkAccess = allowsConstrainedNetworkAccess
        obj.requiresDNSSECValidation = requiresDNSSECValidation
        obj.waitsForConnectivity = waitsForConnectivity
        obj.isDiscretionary = isDiscretionary
        obj.sharedContainerIdentifier = sharedContainerIdentifier
        obj.sessionSendsLaunchEvents = sessionSendsLaunchEvents
        obj.connectionProxyDictionary = connectionProxyDictionary
        obj.tlsMinimumSupportedProtocolVersion = tlsMinimumSupportedProtocolVersion
        obj.tlsMaximumSupportedProtocolVersion = tlsMaximumSupportedProtocolVersion
        obj.httpShouldUsePipelining = httpShouldUsePipelining
        obj.httpShouldSetCookies = httpShouldSetCookies
        obj.httpCookieAcceptPolicy = httpCookieAcceptPolicy
        obj.httpAdditionalHeaders = httpAdditionalHeaders
        obj.httpMaximumConnectionsPerHost = httpMaximumConnectionsPerHost
        obj.httpCookieStorage = httpCookieStorage
        obj.urlCredentialStorage = urlCredentialStorage
        obj.urlCache = urlCache
        obj.shouldUseExtendedBackgroundIdleMode = shouldUseExtendedBackgroundIdleMode
        obj.protocolClasses = protocolClasses
        obj.multipathServiceType = multipathServiceType
        
        return obj
    }
}

/// 证书认证
public struct Credential {
    var userName: String
    var passWord: String
}
