//
//  Networking.swift
//  TestTask
//
//  Created by Демьян on 22.04.2023.
//

import Foundation
import Alamofire

protocol NetworkingProtocol {
    func fetchData(completion: @escaping (SimpleModel) -> Void, failure: @escaping (String) -> Void)
}

class Networking: NetworkingProtocol {
    private let sessionManager: Session
    
    init(sessionManager: Session = AF) {
        self.sessionManager = sessionManager
    }
    
    func fetchData(completion: @escaping (SimpleModel) -> Void, failure: @escaping (String) -> Void) {
        guard let url = Bundle.main.url(forResource: "vendors", withExtension: "json") else { return }
        
        sessionManager.request(url, method: .get, encoding: JSONEncoding.default).validate()
            .responseString(encoding: String.Encoding.utf8) { (response) in
                print(url)
                
                guard let data = response.data else {
                    failure("No data")
                    return
                }
                
                let decoder = JSONDecoder()
                guard let decoded: SimpleModel = try? decoder.decode(SimpleModel.self, from: data) else {
                    failure("No current data")
                    return
                }
                completion(decoded)
            }
    }
}
