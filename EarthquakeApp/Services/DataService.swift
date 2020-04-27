//
//  DataService.swift
//  EarthquakeApp
//
//  Created by Prasad Patil on 4/25/20.
//  Copyright © 2020 Prasad Patil. All rights reserved.
//

import Foundation
import UIKit

/* Handling all the Network calls */

struct DataService {
    
    // MARK: - Properties
    enum ResultType {
        case success
        case failure
    }
    
    typealias NetworkRouterCompletion = (_ data:Data? ,_ error:Error?)->();
    
    // MARK: - Services
    
    // For API Network call and handling response
    func httpResponse(request: URLRequest, completionHandler:@escaping NetworkRouterCompletion){
        
        let session = URLSession.shared;
        
        let task = session.dataTask(with: request){ (data, response, error) -> Void in
            
            guard let data = data else {
                completionHandler(nil,error);
                return;
            }
            if let response = response as? HTTPURLResponse{
                
                let Result = self.handleRsponse(response);
                
                switch Result{
                case .success:
                    completionHandler(data,nil);
                    break;
                case .failure:
                    completionHandler(nil,error);
                    break;
                }
            }
        }
        task.resume();
        
    }
    
    // For handling response Code
    private func handleRsponse (_ response:HTTPURLResponse) -> ResultType {
        
        switch response.statusCode {
        case 200...299:
            return .success
        default:
            return .failure;
        }
    }
}
