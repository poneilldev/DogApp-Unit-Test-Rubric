//
//  AppointmentView.swift
//  Dog-app
//
//  Created by Paul O'Neill on 3/30/21.
//

import Foundation
import UIKit


class AppointmentView: UIView {
    let appointmentTableView: UITableView
    
    override init(frame: CGRect) {
        appointmentTableView = UITableView()
        appointmentTableView.translatesAutoresizingMaskIntoConstraints = false
        appointmentTableView.tableFooterView = UIView()
        
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(appointmentTableView)
        
        NSLayoutConstraint.activate([
            appointmentTableView.topAnchor.constraint(equalTo: topAnchor),
            appointmentTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            appointmentTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            appointmentTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
