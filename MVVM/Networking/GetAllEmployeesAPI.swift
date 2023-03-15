//
//  GetAllEmployeesAPI.swift
//  MVVM
//
//  Created by Teguh Wibowo Wijaya on 13/03/23.
//

import Foundation

enum GetAllEmployeeAPIError: Error {
    case invalidUri(message: String)
    case fetchError(message: String)
    case noData(message: String)
    case failDecodeData(message: String)
}

protocol EmployeeListAPIProtocol {
    var uri: String { get }
    func callApi(onCompletion: @escaping (Result<EmployeeListModel, GetAllEmployeeAPIError>) -> Void)
}

struct GetAllEmployeeAPI: EmployeeListAPIProtocol {
    var uri: String
    
    func callApi(onCompletion: @escaping (Result<EmployeeListModel, GetAllEmployeeAPIError>) -> Void) {
        guard let url = URL(string: uri) else {
            return onCompletion(.failure(GetAllEmployeeAPIError.invalidUri(message: "Invalid uri")))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                return onCompletion(.failure(GetAllEmployeeAPIError.fetchError(message: "\(error)")))
            } else if let response = response as? HTTPURLResponse, response.statusCode > 299 {
                return onCompletion(.failure(GetAllEmployeeAPIError.fetchError(message: "\(response.statusCode) Error")))
            }
            
            guard let data = data else {
                return onCompletion(.failure(GetAllEmployeeAPIError.noData(message: "No Data Available")))
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
                return onCompletion(.failure(GetAllEmployeeAPIError.failDecodeData(message: "Failed to Decode Data")))
            }
            
        }.resume()
    }
    
    
}
