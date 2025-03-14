//
//  ViewController.swift
//  FutureRequest
//
//  Created by Mr.Qi on 03/13/2025.
//  Copyright (c) 2025 Mr.Qi. All rights reserved.
//

import UIKit
import FutureRequest

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        let query: Query = [
            "name": "John",
            "age": 30,
            "isStudent": false,
            "sex": nil,
        ]
        print("-----queryString:\(query.queryString)\n")
        print("-----jsonQuery:\(query.jsonQuery)\n")
        
        let params: Params = [
            "name": "John",
            "age": 30,
            "isStudent": false,
            "sex": nil,
        ]
        
        print("-----paramsString:\(params.paramsString)\n")
        print("-----jsonParams:\(params.jsonParams)\n")
        
        let jsonString = "{\"isStudent\":false,\"sex\":null,\"name\":\"John\",\"age\":30}"
        let string = "isStudent=false&sex=&name=John&age=30"
        
        print("-----jsonString.params:\(jsonString.params)\n")
        print("-----jsonString.query:\(jsonString.query)\n")
        print("-----string.query:\(string.query)\n")
        print("-----string.params:\(string.params)\n")
        
        if #available(iOS 13.0, *) {
            Task {
                await requestNetworking()
            }
        } else {
            
        }
    }
    
    func requestNetworking() async {
        print("开始请求")
        do {
//            let request = Requestor.get(url:"/mall-refuel/app/merchant/order/getOrderByNo", query:["orderNo":"123981237"]).requestUrl
//            print(request)
//            request.a
        } catch {
            print(error)
        }
        print("完成请求")
    }

}

