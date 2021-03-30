//
//  FindDogView.swift
//  Dog-app
//
//  Created by Paul O'Neill on 3/29/21.
//

import UIKit

class FindDogView: UIView {
    let dogTableView: UITableView
    let loadingIndicator: UIActivityIndicatorView
    
    override init(frame: CGRect) {
        let viewFrame = UIScreen.main.bounds
        dogTableView = UITableView(frame: viewFrame, style: .plain)
        dogTableView.estimatedRowHeight = 50
        dogTableView.tableFooterView = UIView()
        dogTableView.translatesAutoresizingMaskIntoConstraints = false
        
        loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        super.init(frame: viewFrame)
        backgroundColor = .systemBackground
        
        addSubview(dogTableView)
        addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            loadingIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            loadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
}
