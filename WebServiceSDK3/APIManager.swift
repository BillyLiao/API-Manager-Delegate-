//
//  APIManager.swift
//  
//
//  Created by 廖慶麟 on 2016/5/6.
//
//


import UIKit
import AFNetworking

protocol WebServiceDelegate: class {
    func getRequestDidFinished(r: NSDictionary?) -> Void
    func fetchImageDidFinished(i: UIImage?) -> Void
    func postNameDidFinished(r: NSDictionary?) -> Void
    func requestFailed(e: NSError?) -> Void
}

class APIManager: NSObject {
    
    weak var delegate: WebServiceDelegate?
    let baseURL = "http://httpbin.org"
    let error = NSError(domain: "webService", code: 200, userInfo: [NSLocalizedDescriptionKey : "Empty responseObject"])
    var manager = AFURLSessionManager()
    var currentTask: NSURLSessionDataTask?
    let session = NSURLSession.sharedSession()

    func getRequest(){
        
        let url = "\(baseURL)/get"
        if(currentTask != nil) {
            currentTask?.cancel()
        }
        currentTask = session.dataTaskWithURL(NSURL(string: url)!) { (data, response, error) -> Void in
            if (error == nil) {
                guard let rdata = data else {
                    self.delegate?.requestFailed(self.error)
                    return
                }
                var err:NSError?
                do{
                    let result = try NSJSONSerialization.JSONObjectWithData(rdata, options: []) as! NSDictionary
                    self.delegate?.getRequestDidFinished(result)
                    self.currentTask = nil
                }catch{
                    print(err?.localizedDescription)
                }
            }else{
                self.delegate?.requestFailed(error)
            }
        }
        currentTask?.resume()
    }
    
    
    func postCustomerName(name: NSString){
        
        let url = "\(baseURL)/post"
        
        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = "POST"
        var params = ["custname":String(name)] as! Dictionary<String, String>
        
        var err:NSError?
        do {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: [])
        }catch{
            print(err?.localizedDescription)
        }

        if currentTask != nil {
            currentTask?.cancel()
        }
        
        currentTask = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            
            if error == nil {
                guard let rdata = data else {
                    self.delegate?.requestFailed(self.error)
                    return
                }
                var err: NSError?
                do{
                    let result = try NSJSONSerialization.JSONObjectWithData(rdata, options: []) as! NSDictionary
                    self.delegate?.postNameDidFinished(result)
                    self.currentTask = nil
                    
                }catch{
                    self.delegate?.requestFailed(err)
                }
            }else {
                print(error)
                self.delegate?.requestFailed(error)
            }
        })
        currentTask?.resume()
        
    }
    
    func fetchImage(){
        let url = "\(baseURL)/image/png"
        
        if currentTask != nil {
            currentTask?.cancel()
        }
        
        currentTask = session.dataTaskWithURL(NSURL(string: url)!) { (data, response, error) -> Void in
            
            if error == nil {
                guard let rdata = data else {
                    self.delegate?.requestFailed(self.error)
                    return
                }
                let result = UIImage(data: rdata)
                self.delegate?.fetchImageDidFinished(result)
                self.currentTask = nil
            }else {
                self.delegate?.requestFailed(error)
            }
        }
        currentTask?.resume()
    }
}
