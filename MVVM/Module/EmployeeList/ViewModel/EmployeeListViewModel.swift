//
//  EmployeeListViewModel.swift
//  MVVM
//
//  Created by Teguh Wibowo Wijaya on 13/03/23.
//

import Foundation

protocol EmployeeListViewModelDelegate {
    func onEmployeeFetched()
}

class EmployeeListViewModel {
    
    private var uri: String
    private var apiService: EmployeeListAPIProtocol
    private(set) var employeeList: EmployeeListModel? {
        didSet {
//            self.bindEmployeeListViewModelToController()
            self.delegate?.onEmployeeFetched()
        }
    }
    private(set) var errorMessage: String?
    
    var delegate: EmployeeListViewModelDelegate?
    
    var bindEmployeeListViewModelToController: () -> Void = {}
    
//    init(bindViewModelToController: @escaping () -> Void) {
//        self.bindEmployeeListViewModelToController = bindViewModelToController
    init() {
        self.uri = "https://dummy.restapiexample.com/api/v1/employees"
        apiService = GetAllEmployeeAPI(uri: self.uri)
        apiService.callApi { result in
            self.assignResult(result)
        }
    }
    
    private func assignResult(_ result: Result<EmployeeListModel, GetAllEmployeeAPIError>) {
        switch result {
        case .success(let employeeList):
            self.employeeList = employeeList
            self.errorMessage = nil
            
        case .failure(let resultError):
            switch resultError {
            case .failDecodeData:
                self.errorMessage = "Failed to Decode API"
            case .noData:
                self.errorMessage = "No Data Found"
            case .fetchError:
                self.errorMessage = "Error Happen When Fetching The Data"
            case .invalidUri:
                self.errorMessage = "Invalid Uri"
            }
        }
    }
}
