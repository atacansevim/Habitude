//
//  DrawViewController.swift
//  Habitude
//
//  Created by Atacan Sevim on 17.05.2023.
//

import UIKit

class DrawViewController: BaseViewController {
    
    // MARK: -Constants
    
    private enum Constants {
        static let smallSpacing: CGFloat = 4
        static let spacing: CGFloat = 20
        static let customSpacing: CGFloat = 30
        static let customNegativeSpacing: CGFloat = -30
        static let customLargeSpacing: CGFloat = 60
        static let stackSpacing: CGFloat = 20
        static let infoLabelSpacingBetween: CGFloat = 24
        static let drawViewTopSpacing: CGFloat = 34
        static let drawAreaCornerRadius: CGFloat = 20
        static let drawAreaBorderWidth: CGFloat = 3
        static let saveButtonTitle: String = "Save"
        static let infoText: String = "Mark your progress"
        static let markInfoText: String = "Draw tick mark, if you done the habit."
        static let crossInfoText: String = "Draw cross mark, if you un-done the habit."
    }
    
    // MARK: -Properties
    
    private let scrollView = UIScrollView()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Habitude.paragraphRegular
        label.textColor = UIColor.Habitute.primaryLight
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        //TODO: (change dummy name)
        label.text = "Hi Beka"
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Habitude.titleLarge
        label.textColor = UIColor.Habitute.primaryLight
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.infoText
        return label
    }()
    
    private let markInfoText: UILabel = {
        let label = UILabel()
        label.font = UIFont.Habitude.paragraphExtraSmall
        label.textColor = UIColor.Habitute.primaryLight
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.markInfoText
        return label
    }()
    
    private let crossInfoText: UILabel = {
        let label = UILabel()
        label.font = UIFont.Habitude.paragraphExtraSmall
        label.textColor = UIColor.Habitute.primaryLight
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.crossInfoText
        return label
    }()
    
    private let markImageView: UIImageView = {
        let imageView = UIImageView(image: Images.mark.image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return imageView
    }()
    
    private let crossImageView: UIImageView = {
        let imageView = UIImageView(image: Images.cross.image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return imageView
    }()
    
    private let markInfoStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = Constants.smallSpacing
        return stack
    }()
    
    private let crossInfoStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = Constants.smallSpacing
        return stack
    }()
    
    private let contentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let subView = UIView()
    
    private let drawnImage = DrawingView()
    
    private let addHabitButton = HabitudeCornerButton(title: Constants.saveButtonTitle, width: 250)
    
    private let clearButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Clear", for: .normal)
        button.setTitleColor(UIColor.Habitute.primaryLightHalfAlpha, for: .normal)
        button.titleLabel?.font = UIFont.Habitude.titleSmall
        button.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return button
    }()
    
    private let buttonsStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = Constants.stackSpacing
        return stack
    }()
    
    private var viewModel: DrawViewModelContracts!
    
    convenience init(viewModel: DrawViewModelContracts){
        self.init()
        self.viewModel = viewModel
        self.viewModel.delegate = self
        clearButton.addTarget(self, action: #selector(clearButtonAction), for: .touchUpInside)
        addHabitButton.addTarget(self, action: #selector(saveButton), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        style()
        layout()
        drawnImage.delegate = self
    }
}

extension DrawViewController {
    func style() {
        //TODO: (could be unneccesary)
        view.backgroundColor = UIColor.Habitute.primaryDark
        title = viewModel.title
    }
    
    func layout() {
        scrollView.contentInsetAdjustmentBehavior = .never
        var constraints: [NSLayoutConstraint] = []
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        constraints.append(contentsOf: [
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        scrollView.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        
        constraints.append(contentsOf: [
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
        constraints.last?.priority = .defaultLow
        
        contentView.addSubview(buttonsStack)
        contentView.addSubview(contentStackView)
        
        NSLayoutConstraint.activate([
            buttonsStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.spacing),
            contentView.trailingAnchor.constraint(equalTo: buttonsStack.trailingAnchor, constant: Constants.spacing),
            contentView.bottomAnchor.constraint(equalTo: buttonsStack.bottomAnchor, constant: Constants.spacing)
        ])
        
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.spacing),
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.spacing),
            contentView.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor, constant: Constants.spacing),
            contentStackView.bottomAnchor.constraint(equalTo: buttonsStack.topAnchor, constant: Constants.customNegativeSpacing)
        ])
        
        NSLayoutConstraint.activate(constraints)
        
        //MARK: -setStacks
        buttonsStack.addArrangedSubview(addHabitButton)
        buttonsStack.addArrangedSubview(clearButton)
        
        markInfoStack.addArrangedSubview(markImageView)
        markInfoStack.addArrangedSubview(markInfoText)
        
        crossInfoStack.addArrangedSubview(crossImageView)
        crossInfoStack.addArrangedSubview(crossInfoText)
        
        contentStackView.addArrangedSubview(nameLabel)
        contentStackView.addArrangedSubview(infoLabel)
        contentStackView.setCustomSpacing(Constants.spacing, after: infoLabel)
        contentStackView.addArrangedSubview(markInfoStack)
        contentStackView.setCustomSpacing(Constants.infoLabelSpacingBetween, after: markInfoStack)
        contentStackView.addArrangedSubview(crossInfoStack)
        contentStackView.setCustomSpacing(Constants.drawViewTopSpacing, after: crossInfoStack)
        contentStackView.addArrangedSubview(subView)
        contentStackView.setCustomSpacing(Constants.customSpacing, after: subView)
        contentStackView.addArrangedSubview(UIView())
        
        setDrawArea()
    }
    
    private func setDrawArea() {
        subView.addSubview(drawnImage)
        subView.layer.cornerRadius = Constants.drawAreaCornerRadius
        subView.layer.borderColor = UIColor.Habitute.secondaryLight.cgColor
        subView.layer.borderWidth = Constants.drawAreaBorderWidth
        drawnImage.clipsToBounds = true
        subView.backgroundColor = .white
        subView.translatesAutoresizingMaskIntoConstraints = false
        drawnImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subView.heightAnchor.constraint(equalToConstant: 300),
            drawnImage.leadingAnchor.constraint(equalToSystemSpacingAfter: subView.leadingAnchor, multiplier: 2),
            subView.trailingAnchor.constraint(equalToSystemSpacingAfter: drawnImage.trailingAnchor, multiplier: 2),
            subView.bottomAnchor.constraint(equalToSystemSpacingBelow: drawnImage.bottomAnchor,  multiplier: 2),
            drawnImage.topAnchor.constraint(equalToSystemSpacingBelow: subView.topAnchor, multiplier: 2),
        ])
    }
}


// MARK: -HandleViewOutput

extension DrawViewController: DrawViewModelDelegate {
    
    func handleViewOutput(_ output: DrawViewModelOutput) {
        switch output {
        case .setLoading(let bool):
            setActivityIndicator(for: bool)
        case .setState(let state):
            break
        case .goToAddHabit:
            break
        case .showError(let errorMessage):
            showAlert(message: errorMessage)
        }
    }
}

// MARK: -Button Actions

extension DrawViewController {
    
    @objc private func clearButtonAction() {
        //subView.clearDrawing()
    }
    
    @objc private func saveButton() {
        drawnImage.recognize()
    }
}

// MARK: -DrawingView Delegate

extension DrawViewController: DrawingViewDelegate {
    
    func getResult(result: PredictResult) {
        var message: String = ""
        switch result {
        case .tick:
            message = "Congratulations"
        case .crossMark:
            message = "Tomorrow is a new chance"
        case .undefined(let errorMessage):
            message = errorMessage
        }
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in}))
        present(alert, animated: true, completion: nil)
    }
}
