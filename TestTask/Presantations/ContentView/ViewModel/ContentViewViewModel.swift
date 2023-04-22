//
//  ContentViewViewModel.swift
//  TestTask
//
//  Created by Демьян on 22.04.2023.
//

import Foundation

class ContentViewViewModel: ObservableObject {

    private let networking: NetworkingProtocol = Networking()
    
    func fetchData(completion: @escaping (SimpleModel) -> Void, failure: @escaping (String) -> Void) {
        self.networking.fetchData { model in
            completion(model)
        } failure: { error in
            failure(error)
        }
    }
}
