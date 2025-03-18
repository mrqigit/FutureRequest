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
        
        if #available(iOS 13.0, *) {
            Task {
                await requestNetworking()
            }
            Task.detached {
                
            }
        } else {
            
        }
    }
    
    func requestNetworking() async {
        print("开始请求")
        do {
            if #available(iOS 15.0, *) {
                try await DownloadSession.shareInstance().download(url: "https://codeload.github.com/CocoaPods/Specs/zip/refs/heads/master", resumeData: nil, params: nil) { progress, request in
                    print("---------")
                }
            } else {
                // Fallback on earlier versions
            }
        } catch {
            print(error)
        }
        print("完成请求")
    }

}

