//
//  FindDogViewController.swift
//  Dog-app
//
//  Created by Paul O'Neill on 3/26/21.
//

import UIKit
import Foundation

class FindDogViewController: UIViewController {
    let contentView = FindDogView()
    let viewModel: FindDogViewModel
    
    override func loadView() {
        view = contentView
    }
    
    init(viewModel: FindDogViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setupUI()
    }

    private func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = TabItem.find.tabTitle
    }
    
    private func bind() {
        contentView.dogTableView.delegate = self
        contentView.dogTableView.dataSource = self
        
        contentView.dogTableView.register(FindDogTableViewCell.self, forCellReuseIdentifier: FindDogTableViewCell.identifier)
        
        viewModel.viewState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                switch state {
                case .loading:
                    self?.contentView.loadingIndicator.startAnimating()
                case .error(let error):
                    self?.contentView.loadingIndicator.stopAnimating()
                    print(error.localizedDescription)
                case .noAuth:
                    self?.contentView.loadingIndicator.stopAnimating()
                    print("No AUTH")
                case .oneResult, .results:
                    self?.contentView.loadingIndicator.stopAnimating()
                    self?.contentView.dogTableView.reloadData()
                }
            }.store(in: &viewModel.cancellables)
    }
}

extension FindDogViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let breed = viewModel.getBreed(at: indexPath) {
            navigationController?.pushViewController(DogDetailsViewController(breed: breed), animated: true)
        }
    }
}

extension FindDogViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getBreedCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FindDogTableViewCell.identifier, for: indexPath) as! FindDogTableViewCell
        cell.configureCell(viewModel.getBreed(at: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return FindDogTableViewCell.cellHeight
    }
}
