//
//  AppointmentTableViewCell.swift
//  Dog-app
//
//  Created by Paul O'Neill on 3/30/21.
//

import UIKit
import Combine

class AppointmentTableViewCell: UITableViewCell {
    static let cellHeight: CGFloat = 90
    static let identifier = "AppointmentTableViewCell"
    let dogImageView: UIImageView
    let breedLabel: UILabel
    let appointmentDateLabel: UILabel
    private var cancellables = Set<AnyCancellable>()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        dogImageView = UIImageView()
        dogImageView.translatesAutoresizingMaskIntoConstraints = false
        dogImageView.contentMode = .scaleAspectFill
        dogImageView.layer.cornerRadius = 5
        dogImageView.clipsToBounds = true
        
        breedLabel = UILabel()
        breedLabel.font = .systemFont(ofSize: 14, weight: .regular)
        breedLabel.translatesAutoresizingMaskIntoConstraints = false
        
        appointmentDateLabel = UILabel()
        appointmentDateLabel.translatesAutoresizingMaskIntoConstraints = false
        appointmentDateLabel.font = .systemFont(ofSize: 14, weight: .heavy)
        
        let labelStackView = UIStackView(arrangedSubviews: [breedLabel, appointmentDateLabel])
        labelStackView.axis = .vertical
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(dogImageView)
        contentView.addSubview(labelStackView)
        
        NSLayoutConstraint.activate([
            dogImageView.heightAnchor.constraint(equalToConstant: 70),
            dogImageView.widthAnchor.constraint(equalToConstant: 70),
            dogImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            dogImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            labelStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            labelStackView.leadingAnchor.constraint(equalTo: dogImageView.trailingAnchor, constant: 16),
        ])
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(appointment: Appointment) {
        breedLabel.text = appointment.breed
        appointmentDateLabel.text = "April 5"
        if let breed = appointment.breed {
            fetchImage(for: breed)
        }
    }
    
    private func fetchImage(for breed: String) {
        let url = URL(string: "https://dog.ceo/api/breed/\(breed)/images/random")!
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .receive(on: DispatchQueue.main)
            .sink { result in
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    print("Image Loaded")
                }
            } receiveValue: { [dogImageView] image in
                dogImageView.image = image
            }.store(in: &cancellables)
    }
}
