//
//  ContentViewViewModel.swift
//  TestTask
//
//  Created by Демьян on 22.04.2023.
//

import Foundation

class ContentViewViewModel: ObservableObject {
    
    // MARK: - Variables
    @Published var vendors: SimpleModel?
    @Published var data: SimpleModel?
    @Published var searching = false
    private let networking: NetworkingProtocol = Networking()

    
    func fetchData() {
        self.networking.fetchData { model in
            self.vendors = model
            self.data = model
        } failure: { error in
            print(error)
        }
    }
    
    func fetchNewData(completion: @escaping() -> Void) {
        self.networking.fetchData { model in
            if let newData = model.vendors {
                self.data?.vendors?.append(contentsOf: newData)
                self.vendors?.vendors?.append(contentsOf: newData)
                completion()
            }
        } failure: { error in
            print(error)
        }

    }
    
    func shouldLoadData(id: Int) -> Bool {
        if let data = self.data?.vendors {
            return id == data.count - 2
        } else {
            return false
        }
    }
}
