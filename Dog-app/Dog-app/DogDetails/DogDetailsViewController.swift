//
//  DogDetailsViewController.swift
//  Dog-app
//
//  Created by Paul O'Neill on 3/30/21.
//

import UIKit
import Combine

class DogDetailsViewController: UIViewController {
    let contentView = DogDetailsView()
    let viewModel: DogDetailsViewModel
    
    var cancellables = Set<AnyCancellable>()
    
    override func loadView() {
        view = contentView
    }
    
    init(breed: BreedProtocol) {
        viewModel = DogDetailsViewModel(breed)
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }

    private func setupUI() {
        title = viewModel.breed.name
    }
    
    private func bind() {
        contentView.subBreedsTableView.dataSource = self
        contentView.subBreedsTableView.delegate = self
        contentView.subBreedsTableView.register(FindDogTableViewCell.self, forCellReuseIdentifier: FindDogTableViewCell.identifier)
        contentView.createAppointmentButton.addTarget(self, action: #selector(createAppointmentButtonPressed), for: .touchUpInside)
        
        viewModel.randomImageUrl
            .receive(on: DispatchQueue.main)
            .sink { [weak self] url in
                guard let self = self else { return }
                self.contentView.breedImageView.load(url: url,
                                                placeholder: UIImage(systemName: "hare.fill")!,
                                                cancellables: &self.cancellables)
            }.store(in: &cancellables)
    }
    
    @objc private func createAppointmentButtonPressed() {
        viewModel.createAppointment()
    }
}

extension DogDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let subBreed = viewModel.getSubBreed(at: indexPath) {
            navigationController?.pushViewController(DogDetailsViewController(breed: subBreed), animated: true)
        }
    }
}

extension DogDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.subBreeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FindDogTableViewCell.identifier, for: indexPath) as! FindDogTableViewCell
        cell.configureCell(viewModel.subBreeds[indexPath.row])
        return cell
    }
}
