//
//  GourmetServiceDM.swift
//  Gourmet
//
//  Created by David Martinez on 11/12/2016.
//  Copyright © 2016 Atenea. All rights reserved.
//

import Foundation

class GourmetServiceDM : NSObject {
    
    func validate(account : Account, callback : @escaping (_ url: URL?, _ error : Error?) -> Void) {
        
        let headers = [
            "authorization": "Basic dmFsaWRhVXN1YXJpb1RhcmpldGE6Y2gzcXUzR291cm1ldA==",
            "content-type": "text/xml",
            "cache-control": "no-cache"
        ]
        
        let bodyString =
        "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ws=\"http://ws.tarjetaWeb.gourmet.com/\">" +
        "<soapenv:Header />" +
        "<soapenv:Body>" +
        "<ws:consultaUsuarios>" +
        "<pan>\(account.cardId)</pan>" +
        "<contrasena>\(account.password)</contrasena>" +
        "</ws:consultaUsuarios>" +
        "</soapenv:Body>" +
        "</soapenv:Envelope>"
        
        let postData = bodyString.data(using: String.Encoding.utf8)
        
        let url = URL(string: "http://wsvut.chequegourmet.com/ConsultaUsuarios?wdsl=")!
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData
        
        let session = URLSession.shared
        let downloadTask = session.downloadTask(with: request) { (resultUrl: URL?, response: URLResponse?, resultError: Error?) in
            if (resultError != nil) {
                callback(nil, resultError)
            } else {
                callback(resultUrl, nil)
            }
        }
        
        print("[Resquest] \(url.absoluteString)")
        downloadTask.resume()
    }
    
    func getBalance (account : Account, callback: @escaping (_ url: URL?, _ error : Error?) -> Void) {
        
        let token = "xAeSYsTQQTCVyPOGWLpR"
        let sUrl = "http://tarjetagourmet.chequegourmet.com/processLogin_iphoneApp.jsp?usuario=\(account.cardId)&contrasena=\(account.password)&token=\(token)"
        let url = URL(string: sUrl)!
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "POST"
        
        let session = URLSession.shared
        let downloadTask = session.downloadTask(with: request) { (resultUrl: URL?, response: URLResponse?, resultError: Error?) in
            if (resultError != nil) {
                callback(nil, resultError)
            } else {
                callback(resultUrl, nil)
            }
        }
        
        print("[Resquest] \(url.absoluteString)")
        downloadTask.resume()
    }
}
