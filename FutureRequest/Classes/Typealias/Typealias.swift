//
//  Typealias.swift
//  FutureRequest
//
//  Created by MrQi on 2025/3/14.
//

import Foundation

public typealias Query = [AnyHashable: Any?]
public typealias Params = [AnyHashable: Any?]

public typealias ProgressComplent = (_ progress: Progress, _ request: URLRequest) -> Void

public let response_400: Response = Response(code: 400, msg: "客户端发送的请求有语法错误或不符合服务器的要求，服务器无法理解请求")
public let response_401: Response = Response(code: 401, msg: "客户端需要进行身份验证才能访问请求的资源，但客户端未提供有效的身份凭证或身份验证失败")
public let response_403: Response = Response(code: 403, msg: "客户端具有访问资源的权限，但服务器拒绝了请求。可能是因为客户端没有足够的权限或资源被禁止访问")
public let response_404: Response = Response(code: 404, msg: "服务器无法找到请求的资源。可能是因为 URL 输入错误或资源已被删除")
public let response_405: Response = Response(code: 405, msg: "客户端使用的HTTP方法(如:GET、POST、PUT、DELETE等)不被服务器允许用于请求的资源")
