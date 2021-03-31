//
//  AppointmentsViewController.swift
//  Dog-app
//
//  Created by Paul O'Neill on 3/30/21.
//

import UIKit
import Combine

class AppointmentsViewController: UIViewController {
    let contentView = AppointmentView()
    let viewModel: AppointmentsViewModel
    
    private var cancellables = Set<AnyCancellable>()
    
    override func loadView() {
        view = contentView
    }
    
    init(viewModel: AppointmentsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        bind()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = TabItem.appointments.tabTitle
    }
    
    private func bind() {
        contentView.appointmentTableView.dataSource = self
        contentView.appointmentTableView.register(AppointmentTableViewCell.self, forCellReuseIdentifier: AppointmentTableViewCell.identifier)
        
        viewModel.appointments
            .receive(on: DispatchQueue.main)
            .sink { [contentView] _ in
                contentView.appointmentTableView.reloadData()
            }.store(in: &cancellables)
    }
}

extension AppointmentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.appointments.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AppointmentTableViewCell.identifier, for: indexPath) as! AppointmentTableViewCell
        cell.configureCell(appointment: viewModel.appointments.value[indexPath.row])
        return cell
    }
}
