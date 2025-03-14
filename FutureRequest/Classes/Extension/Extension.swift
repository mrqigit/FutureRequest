//
//  Extension.swift
//  FutureRequest
//
//  Created by MrQi on 2025/3/14.
//

import Foundation

public extension Query {
    
    var jsonQuery: String? {
        do {
            let data = try JSONSerialization.data(withJSONObject: self, options: [])
            guard let jsonString = String(data: data, encoding: .utf8) else {
                return nil
            }
            return jsonString
        } catch {
            return nil
        }
    }
    
    var queryString: String? {
        var tempList: [String] = []
        for (key, value) in self {
            tempList.append("\(key)=\(value ?? "")")
        }
        if self.keys.isEmpty {
            return nil
        }
        if tempList.isEmpty {
            return nil
        }
        return tempList.joined(separator: "&")
    }
}

public extension Params {
    var jsonParams: String? {
        do {
            let data = try JSONSerialization.data(withJSONObject: self, options: [])
            guard let jsonString = String(data: data, encoding: .utf8) else {
                return nil
            }
            return jsonString
        } catch {
            return nil
        }
    }
    
    var paramsString: String? {
        var tempList: [String] = []
        for (key, value) in self {
            tempList.append("\(key)=\(value ?? "")")
        }
        if self.keys.isEmpty {
            return nil
        }
        if tempList.isEmpty {
            return nil
        }
        return tempList.joined(separator: "&")
    }
}

public extension String {
    
    var query: Query? {
        if count < 1 {
            return nil
        }
        let queryList: [String] = self.components(separatedBy: "&")
        if queryList.isEmpty {
            return nil
        }
        var tempQuery: Query = [:]
        for item in queryList {
            if item.count < 1 {
                continue
            }
            let tempList = item.components(separatedBy: "=")
            if tempList.count < 2 {
                continue
            }
            tempQuery[tempList[0]] = tempList[1]
        }
        if tempQuery.isEmpty {
            return nil
        }
        return tempQuery
    }
    
    var params: Params? {
        guard let jsonData = data(using: .utf8) else { return nil }
        do {
            guard let data = try JSONSerialization.jsonObject(with: jsonData, options: []) as? Params else {
                return nil
            }
            return data
        } catch {
            return nil
        }
    }
    
    var isHttp: Bool {
        return hasPrefix("http://")
    }
    
    var isHttps: Bool {
        return hasPrefix("https://")
    }
    
    var isValidPath: Bool {
        return hasSuffix("/")
    }
    
    var isValidUrl: Bool {
        return hasPrefix("/")
    }
}

public extension Query? {
    
    var jsonQuery: String? {
        guard let self = self else { return nil }
        return self.jsonQuery
    }
    
    var queryString: String? {
        guard let self = self else { return nil }
        return self.queryString
    }
}

public extension Params? {
    var jsonParams: String? {
        guard let self = self else { return nil }
        return self.jsonParams
    }
    
    var paramsString: String? {
        guard let self = self else { return nil }
        return self.paramsString
    }
}

public extension String? {
    
    var query: Query? {
        guard let self = self else { return nil }
        return self.query
    }
    
    var params: Params? {
        guard let self = self else { return nil }
        return self.params
    }
}
