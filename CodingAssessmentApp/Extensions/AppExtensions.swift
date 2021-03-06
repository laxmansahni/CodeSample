//
//  AppExtensions.swift
//  CodingAssessmentApp
//
//  Created by Laxman Sahni on 26/06/18.
//  Copyright © 2018 Nagarro. All rights reserved.
//

import UIKit

extension URLComponents
{
    static func generateUrl(urlString:String, params:[String:Any]) -> URL? {
        var urlComponents = URLComponents(string: urlString)
        var arrQueryItems = [URLQueryItem]()
        for (myKey, myValue) in params {
            let value = "\(myValue)".addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
            
            let queryItem = URLQueryItem(name: myKey, value: value)
            arrQueryItems.append(queryItem)
        }
        urlComponents?.queryItems = arrQueryItems
        return URL(string: (urlComponents?.url?.absoluteString.replacingOccurrences(of: "+", with: "%2B"))!)
    }
}

extension UISplitViewController {
    var primaryViewController: UIViewController? {
        return self.viewControllers.first
    }
    
    var secondaryViewController: UIViewController? {
        return self.viewControllers.count > 1 ? self.viewControllers[1] : nil
    }
}
