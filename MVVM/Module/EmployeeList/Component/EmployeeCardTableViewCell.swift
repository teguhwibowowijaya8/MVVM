//
//  EmployeeCardTableViewCell.swift
//  MVVM
//
//  Created by Teguh Wibowo Wijaya on 13/03/23.
//

import UIKit

class EmployeeCardTableViewCell: UITableViewCell {
    static let identifier = "EmployeeCardTableViewCell"
    
    @IBOutlet weak var employeeImageView: UIImageView!
    @IBOutlet weak var employeeNameLabel: UILabel!
    @IBOutlet weak var employeeSalaryLabel: UILabel!
    @IBOutlet weak var employeeAgeLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func setupCell(employee: Employee) {
        setupEmployeeImage(imageUri: employee.profileImage)
        
        employeeNameLabel.text = employee.employeeName
        employeeSalaryLabel.text = "\(employee.employeeSalary)"
        employeeAgeLabel.text = "I am \(employee.employeeAge) years old"
    }
    
    func setupEmployeeImage(imageUri: String) {
        guard let urlImage = URL(string: imageUri) else {
            return assignDefaultImage()
        }
        
        URLSession.shared.dataTask(with: urlImage) { data, response, error in
            if let data = data {
                self.employeeImageView.image = UIImage(data: data)
            } else {
                self.assignDefaultImage()
            }
        }.resume()
    }
    
    func assignDefaultImage() {
        self.employeeImageView.image = UIImage(systemName: "person.fill")
    }
    
}
