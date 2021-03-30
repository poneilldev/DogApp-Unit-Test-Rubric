//
//  UIImageView+Extensions.swift
//  Dog-app
//
//  Created by Paul O'Neill on 3/30/21.
//

import Foundation
import UIKit
import Combine

extension UIImageView {
    func load(url: URL, placeholder: UIImage, cancellables: inout Set<AnyCancellable>) {
        let loadingView = UIActivityIndicatorView(style: .large)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.hidesWhenStopped = true
        addSubview(loadingView)
        
        loadingView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        loadingView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        loadingView.startAnimating()
        URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                loadingView.stopAnimating()
                switch result {
                case .failure(let error):
                    print(error.failingURL?.absoluteString ?? "bad_url")
                    print(error.localizedDescription)
                    self?.image = placeholder
                case .finished:
                    break
                }
            } receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
            }.store(in: &cancellables)

    }
}
