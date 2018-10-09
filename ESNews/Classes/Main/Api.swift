//
//  Api.swift
//  ESNews
//
//  Created by Dean on 2018/10/8.
//  Copyright © 2018年 siridx. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire

//enum Api {
//
////    /// 通过用户名密码取得一个 token
////    static func token(username: String, password: String) -> Observable<String> { ... }
////
////    /// 通过 token 取得用户信息
////    static func userInfo(token: String) -> Observable<UserInfo> { ... }
//}

extension DataRequest {
    @discardableResult
    public func responseResult(completion: @escaping ([String:Any]) -> Void)
        -> Self
    {
        return responseJSON { (response) in
            if let value = response.result.value,
            let valueDic = value as? [String:Any] {
                completion(valueDic)
            }
        }
    }
}

class Api {
    
    static func getRadioList(_ repo: String) -> Single<[[String: Any]]> {
        
        return Single<[[String: Any]]>.create(subscribe: { (single) -> Disposable in
            
            Alamofire.request("https://httpbin.org/post", method: .get).responseResult(completion: { (dic) in
                
                
            })
            
            return Disposables.create()
        })
        
    }
    
}
