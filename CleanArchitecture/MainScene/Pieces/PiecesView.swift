//
//  MainView.swift
//  test-task-halbestunde
//
//  Created by Iurii Gubanov on 18.05.2022.
//

import UIKit

protocol PiecesViewDelegate: AnyObject {
    func onNewPieceButtonTapped()
    func onRandomPieceButtonTapped()
}

class PiecesView: UIView {
    
    private let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8.0
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var newPieceButton: UIButton = {
        let configuration = getButtonConfiguration(title: "Add new piece", imageTitle: "plus")
        let button = UIButton(configuration: configuration)
        return button
    }()
    
    private lazy var randomPieceButton: UIButton = {
        let configuration = getButtonConfiguration(title: "Add random piece", imageTitle: "questionmark")
        let button = UIButton(configuration: configuration)
        return button
    }()

    let buttonConfiguration : UIButton.Configuration = {
        var config = UIButton.Configuration.filled()
        config.imagePlacement = .top
        config.imagePadding = 16
        config.cornerStyle = .fixed
        config.baseBackgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.00)
        return config
    }()

    let piecesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        return tableView
    }()

    let navigationBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    weak var delegate: PiecesViewDelegate?

    init() {
        super.init(frame: .zero)

        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        
        addSubviews()
        setupConstraints()
        setupButtonTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addSubviews() {
        addSubview(buttonsStackView)
        addSubview(piecesTableView)
        addSubview(navigationBackgroundView)

        buttonsStackView.addArrangedSubview(newPieceButton)
        buttonsStackView.addArrangedSubview(randomPieceButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            navigationBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            navigationBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            navigationBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            navigationBackgroundView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),

            buttonsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            buttonsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 100),
            buttonsStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),

            piecesTableView.topAnchor.constraint(equalTo: buttonsStackView.bottomAnchor, constant: 20),
            piecesTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            piecesTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            piecesTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func setupButtonTargets() {
        newPieceButton.addTarget(self, action: #selector(newPieceButtonTapped), for: .touchUpInside)
        randomPieceButton.addTarget(self, action: #selector(randomPieceButtonTapped), for: .touchUpInside)
    }

    private func getButtonConfiguration(title: String, imageTitle: String) -> UIButton.Configuration {
        var config = UIButton.Configuration.filled()
        config.imagePlacement = .top
        config.imagePadding = 16
        config.cornerStyle = .fixed
        config.baseBackgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.00)
        config.attributedTitle = AttributedString(title)
        config.attributedTitle?.foregroundColor = .black
        config.image = UIImage(systemName: imageTitle, withConfiguration: UIImage.SymbolConfiguration(scale: .large))
        return config
    }

    @objc private func newPieceButtonTapped() {
        delegate?.onNewPieceButtonTapped()
    }

    @objc private func randomPieceButtonTapped() {
        delegate?.onRandomPieceButtonTapped()
    }
}
