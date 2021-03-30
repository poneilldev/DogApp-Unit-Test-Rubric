//
//  DogDetailsView.swift
//  Dog-app
//
//  Created by Paul O'Neill on 3/30/21.
//

import UIKit

class DogDetailsView: UIView {
    let contentStackView: UIStackView
    let breedImageView: UIImageView
    let subBreedsLabel: UILabel
    let subBreedsTableView: UITableView
    let createAppointmentButton: UIButton
    
    override init(frame: CGRect) {
        breedImageView = UIImageView()
        breedImageView.translatesAutoresizingMaskIntoConstraints = false
        breedImageView.contentMode = .scaleAspectFill
        breedImageView.layer.cornerRadius = 5
        breedImageView.layer.borderWidth = 1
        breedImageView.layer.borderColor = UIColor.systemGroupedBackground.cgColor
        breedImageView.clipsToBounds = true
        
        subBreedsLabel = UILabel()
        subBreedsLabel.translatesAutoresizingMaskIntoConstraints = false
        subBreedsLabel.textAlignment = .left
        subBreedsLabel.text = "Sub-breeds"
        subBreedsLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        
        subBreedsTableView = UITableView()
        subBreedsTableView.translatesAutoresizingMaskIntoConstraints = false
        subBreedsTableView.estimatedRowHeight = 50
        subBreedsTableView.tableFooterView = UIView()
        
        createAppointmentButton = UIButton()
        createAppointmentButton.translatesAutoresizingMaskIntoConstraints = false
        createAppointmentButton.setTitle("Create Appointment", for: .normal)
        createAppointmentButton.backgroundColor = .systemBlue
        createAppointmentButton.setTitleColor(.white, for: .normal)
        
        contentStackView = UIStackView()
        contentStackView.axis = .vertical
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        contentStackView.addArrangedSubview(breedImageView)
        contentStackView.setCustomSpacing(16, after: breedImageView)
        contentStackView.addArrangedSubview(subBreedsLabel)
        contentStackView.setCustomSpacing(8, after: subBreedsLabel)
        contentStackView.addArrangedSubview(subBreedsTableView)
        
        addSubview(contentStackView)
        insertSubview(createAppointmentButton, aboveSubview: contentStackView)
        
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            contentStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
            contentStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            breedImageView.heightAnchor.constraint(equalToConstant: 200),
            breedImageView.widthAnchor.constraint(equalToConstant: 200),
            
            createAppointmentButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8),
            createAppointmentButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            createAppointmentButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            createAppointmentButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
