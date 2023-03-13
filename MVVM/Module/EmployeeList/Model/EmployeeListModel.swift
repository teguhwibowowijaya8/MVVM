//
//  EmployeeListModel.swift
//  MVVM
//
//  Created by Teguh Wibowo Wijaya on 13/03/23.
//

import Foundation

struct EmployeeListModel: Codable {
    let status: String
    let data: [Employee]
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case status
        case data
        case message
    }
}

struct Employee: Codable {
    let id: Int
    let employeeName: String
    let employeeSalary: Int
    let employeeAge: Int
    let profileImage: String
    
    //    var employeeSalaryString: String {
    //        return String(format: "$ %d", locale: .current, employeeSalary)
    //    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case employeeName = "employee_name"
        case employeeSalary = "employee_salary"
        case employeeAge = "employee_age"
        case profileImage = "profile_image"
    }
}
