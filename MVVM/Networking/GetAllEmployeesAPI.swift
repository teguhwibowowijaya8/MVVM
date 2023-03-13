//
//  GetAllEmployeesAPI.swift
//  MVVM
//
//  Created by Teguh Wibowo Wijaya on 13/03/23.
//

import Foundation

enum GetAllEmployeeAPIError: Error {
    case invalidUri
    case fetchError
    case noData
    case failDecodeData
}

protocol EmployeeListAPIProtocol {
    var uri: String { get }
    func callApi(onCompletion: @escaping (Result<EmployeeListModel, GetAllEmployeeAPIError>) -> Void)
}

struct GetAllEmployeeAPI: EmployeeListAPIProtocol {
    var uri: String
    
    func callApi(onCompletion: @escaping (Result<EmployeeListModel, GetAllEmployeeAPIError>) -> Void) {
        guard let url = URL(string: uri) else {
            return onCompletion(.failure(GetAllEmployeeAPIError.invalidUri))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            print(error)
            print(response)
            if error != nil {
                return onCompletion(.failure(GetAllEmployeeAPIError.fetchError))
            }
            
            guard let data = data else {
                return onCompletion(.failure(GetAllEmployeeAPIError.noData))
            }
            
//            do {
//                let decoder = JSONDecoder()
//                let employeeData = try decoder.decode(EmployeeListModel.self, from: data)
//                onCompletion(.success(employeeData))
//            } catch {
//                onCompletion(.failure(GetAllEmployeeAPIError.failDecodeData))
//            }
            
            do {
                let decoder = JSONDecoder()
                let employeeData = try decoder.decode(EmployeeListModel.self, from: data)
                print(employeeData)
                return onCompletion(.success(employeeData))
            } catch _ {
                return onCompletion(.failure(GetAllEmployeeAPIError.failDecodeData))
            }
            
        }.resume()
    }
    
    
}
