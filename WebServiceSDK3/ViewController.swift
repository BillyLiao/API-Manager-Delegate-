//
//  ViewController.swift
//  WebServiceSDK3
//
//  Created by 廖慶麟 on 2016/5/6.
//  Copyright © 2016年 廖慶麟. All rights reserved.
//

import UIKit

class ViewController: UIViewController, WebServiceDelegate {

    var manager: APIManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager = APIManager()
        manager.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func sendRequest(sender: AnyObject) {
        manager.getRequest()
        manager.postCustomerName("Billy")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getRequestDidFinished(r: NSDictionary?){
        print(r)
        return
    }
    func fetchImageDidFinished(i: UIImage?){
        print(i)
        return
    }
    func postNameDidFinished(r: NSDictionary?){
        print(r)
        return
    }
    func requestFailed(e: NSError?){
        return
    }



}

