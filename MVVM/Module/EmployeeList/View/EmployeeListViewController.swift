//
//  ViewController.swift
//  MVVM
//
//  Created by Teguh Wibowo Wijaya on 13/03/23.
//

import UIKit

class EmployeeListViewController: UIViewController {
    
    var viewModel: EmployeeListViewModel!
    
    @IBOutlet weak var employeeListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupViewModel()
        setupTableView()
    }
    
    func setupViewModel() {
        viewModel = EmployeeListViewModel(bindViewModelToController: self.bindViewModelToController)
    }
    
    func setupTableView() {
        employeeListTableView.delegate = self
        employeeListTableView.dataSource = self
        
        employeeListTableView.register(UINib(nibName: EmployeeCardTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: EmployeeCardTableViewCell.identifier)
    }
    
    func bindViewModelToController() {
        DispatchQueue.main.async {
            self.employeeListTableView.reloadData()
        }
    }
}

extension EmployeeListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.employeeList?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let employee = viewModel.employeeList?.data[indexPath.row],
            let employeeCardCell = tableView.dequeueReusableCell(withIdentifier: EmployeeCardTableViewCell.identifier, for: indexPath) as? EmployeeCardTableViewCell
        else { return UITableViewCell() }
        
        employeeCardCell.setupCell(employee: employee)
        
        return employeeCardCell
    }
}

