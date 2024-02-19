//
//  BaseViewController.swift
//  Habitude
//
//  Created by Atacan Sevim on 18.02.2024.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - Properties
    
    var activityIndicator: UIActivityIndicatorView!
    var backgroundFilterView: UIView!
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicator()
        setupBackgroundFilterView()
    }
    
    // MARK: - Setup Methods
    
    private func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = UIColor.Habitute.accent
        activityIndicator.center = view.center
        activityIndicator.layer.zPosition = 1
        view.addSubview(activityIndicator)
    }
    
    private func setupBackgroundFilterView() {
        backgroundFilterView = UIView(frame: view.bounds)
        backgroundFilterView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        backgroundFilterView.isHidden = true
        backgroundFilterView.layer.zPosition = 1
        view.addSubview(backgroundFilterView)
        view.sendSubviewToBack(backgroundFilterView)
    }
    
    // MARK: - Activity Indicator
    
    func setActivityIndicator(for flag: Bool) {
        if flag {
            activityIndicator.startAnimating()
            backgroundFilterView.isHidden = false
            view.isUserInteractionEnabled = false
        } else {
            activityIndicator.stopAnimating()
            backgroundFilterView.isHidden = true
            view.isUserInteractionEnabled = true
        }
    }
    
    // MARK: - Alert
    
    func showAlert(title: String = "Error", message: String = "Something went wrong") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}

