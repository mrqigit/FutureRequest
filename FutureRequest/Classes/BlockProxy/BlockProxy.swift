//
//  BlockProxy.swift
//  FutureRequest
//
//  Created by MrQi on 2025/3/14.
//

import Foundation
import CoreFoundation
import AVFoundation

public class BlockProxy: NSObject {
    
    weak var target: NSObject?
    var progress: ProgressComplent?
    
    /// HTTP认证用户密码
    var credential: Credential?
    
    required init(target: NSObject?, progress: ProgressComplent?, credential: Credential?) {
        self.target = target
        self.progress = progress
        self.credential = credential
        super.init()
    }
}

extension BlockProxy: URLSessionDelegate {
    
    /// 向委托请求凭证，以响应来自远程服务器的会话级身份验证请求
    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge) async -> (URLSession.AuthChallengeDisposition, URLCredential?) {
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
            /// 处理服务器证书验证
            guard let serverTrust = challenge.protectionSpace.serverTrust else {
                return (.performDefaultHandling, nil)
            }
            return (.useCredential, URLCredential(trust: serverTrust))
        } else if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodHTTPBasic {
            /// 处理基本的HTTP认证，需要获取用户名以及密码
            guard let credential = credential else {
                return (.performDefaultHandling, nil)
            }
            return (.useCredential, URLCredential(user: credential.userName, password: credential.passWord, persistence: .forSession))
        } else {
            /// 对于其他认证方式，执行默认处理
            return (.performDefaultHandling, nil)
        }
    }
    
    /// 告知 URL 会话会话已失效
    public func urlSession(_ session: URLSession, didBecomeInvalidWithError error: (any Error)?) {
        
    }
    
    /// 通知代理，为会话排队的所有消息都已传送
    public func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        
    }
}

extension BlockProxy: URLSessionTaskDelegate {
    
    /// 告知代理任务已完成数据传输
    public func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: (any Error)?) {
        
    }
    
    /// 告知代理远程服务器请求了 HTTP 重定向
    public func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest request: URLRequest, completionHandler: @escaping (URLRequest?) -> Void) {
        
    }
    
    /// 定期通知代理将正文内容发送到服务器的进度
    public func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        
    }
    
    /// 当任务需要将新的请求正文流发送到远程服务器时，通知代理
    public func urlSession(_ session: URLSession, task: URLSessionTask, needNewBodyStream completionHandler: @escaping (InputStream?) -> Void) {
        
    }
    
    /// 向委托请求凭据，以响应来自远程服务器的身份验证请求
    public func urlSession(_ session: URLSession, task: URLSessionTask, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
    }
    
    /// 告知代理延迟的 URL 会话任务现在将开始加载
    public func urlSession(_ session: URLSession, task: URLSessionTask, willBeginDelayedRequest request: URLRequest, completionHandler: @escaping (URLSession.DelayedRequestDisposition, URLRequest?) -> Void) {
        
    }
    
    /// 告知代理任务正在等待，直到有合适的连接可用，然后再开始网络加载
    public func urlSession(_ session: URLSession, taskIsWaitingForConnectivity task: URLSessionTask) {
        
    }
    
    /// 告知代理会话已完成任务的指标收集
    public func urlSession(_ session: URLSession, task: URLSessionTask, didFinishCollecting metrics: URLSessionTaskMetrics) {
        
    }
}

extension BlockProxy: AVAssetDownloadDelegate {
    
    /// 告知代理下载任务已解析要下载的媒体选择，包括任何自动选择
    public func urlSession(_ session: URLSession, assetDownloadTask: AVAssetDownloadTask, didResolve resolvedMediaSelection: AVMediaSelection) {
        
    }
    
    /// 告知委托下载任务加载了新的时间范围
    public func urlSession(_ session: URLSession, assetDownloadTask: AVAssetDownloadTask, didLoad timeRange: CMTimeRange, totalTimeRangesLoaded loadedTimeRanges: [NSValue], timeRangeExpectedToLoad: CMTimeRange) {
        
    }
    
    /// 告知委托下载任务已完成下载请求的资产
    public func urlSession(_ session: URLSession, assetDownloadTask: AVAssetDownloadTask, didFinishDownloadingTo location: URL) {
        
    }
    
    /// 告知委托 download 任务已完成变体选择
    @available(iOS 15.0, *)
    public func urlSession(_ session: URLSession, assetDownloadTask: AVAssetDownloadTask, willDownloadVariants variants: [AVAssetVariant]) {
        
    }
    
    /// 通知代理下载任务何时确定其下载位置
    public func urlSession(_ session: URLSession, assetDownloadTask: AVAssetDownloadTask, willDownloadTo location: URL) {
        
    }
    
    /// 告知代理下载完成后资产的最终位置
    public func urlSession(_ session: URLSession, aggregateAssetDownloadTask: AVAggregateAssetDownloadTask, willDownloadTo location: URL) {
        
    }
    
    /// 告知委托聚合下载任务加载了新的时间范围
    public func urlSession(_ session: URLSession, aggregateAssetDownloadTask: AVAggregateAssetDownloadTask, didLoad timeRange: CMTimeRange, totalTimeRangesLoaded loadedTimeRanges: [NSValue], timeRangeExpectedToLoad: CMTimeRange, for mediaSelection: AVMediaSelection) {
        
    }
    
    /// 告知代理子任务已完成媒体选择的下载
    public func urlSession(_ session: URLSession, aggregateAssetDownloadTask: AVAggregateAssetDownloadTask, didCompleteFor mediaSelection: AVMediaSelection) {
        
    }
}

extension BlockProxy: URLSessionDataDelegate {
    
    /// 询问代理数据（或上传）任务是否应将响应存储在缓存中
    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, willCacheResponse proposedResponse: CachedURLResponse, completionHandler: @escaping (CachedURLResponse?) -> Void) {
        
    }
    
    /// 告知委托数据任务已收到一些预期数据
    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        
    }
    
    /// 告诉委托数据任务已更改为流任务
    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didBecome streamTask: URLSessionStreamTask) {
        
    }
    
    /// 告知代理数据任务已更改为下载任务
    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didBecome downloadTask: URLSessionDownloadTask) {
        
    }
    
    /// 告知委托数据任务已从服务器收到初始回复（标头）
    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        
    }
}

extension BlockProxy: URLSessionDownloadDelegate {
    
    /// 告知代理下载任务已完成下载
    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
    }
    
    /// 告知代理下载任务已恢复下载
    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {
        
    }
    
    /// 定期通知代理下载进度
    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
    }
}

extension BlockProxy: URLSessionStreamDelegate {
    
    /// 告诉委托已为流检测到到主机的更好路由
    public func urlSession(_ session: URLSession, betterRouteDiscoveredFor streamTask: URLSessionStreamTask) {
        
    }
    
    /// 告知代理，由于流任务调用 captureStreams() 方法，流任务已完成
    public func urlSession(_ session: URLSession, streamTask: URLSessionStreamTask, didBecome inputStream: InputStream, outputStream: OutputStream) {
        
    }
    
    /// 告诉委托基础套接字的读取端已关闭
    public func urlSession(_ session: URLSession, readClosedFor streamTask: URLSessionStreamTask) {
        
    }
    
    /// 告诉委托基础套接字的写入端已关闭
    public func urlSession(_ session: URLSession, writeClosedFor streamTask: URLSessionStreamTask) {
        
    }
}

extension BlockProxy: URLSessionWebSocketDelegate {
    
/// 告知委托 WebSocket 任务已成功协商与终端节点的握手，指示协商的协议
    public func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        
    }
    
    /// 告知委托 WebSocket 任务从服务器终端节点收到关闭帧，可以选择包括来自服务器的关闭代码和原因
    public func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        
    }
}
