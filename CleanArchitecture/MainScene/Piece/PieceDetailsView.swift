//
//  PieceView.swift
//  test-task-halbestunde
//
//  Created by Iurii Gubanov on 18.05.2022.
//

import UIKit

class PieceDetailsView: UIView {

    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.isUserInteractionEnabled = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let authorTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isUserInteractionEnabled = true
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = true
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.layer.cornerRadius = 6
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 0.2
        textView.isUserInteractionEnabled = true
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    var descriptionTextViewHeightConstraint: NSLayoutConstraint = .init()

    init() {
        super.init(frame: .zero)

        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        
        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {
        addSubview(posterImageView)

        addSubview(titleTextField)
        addSubview(authorTextField)
        addSubview(descriptionTextView)
    }

    private func setupConstraints() {
        descriptionTextViewHeightConstraint = descriptionTextView.heightAnchor
            .constraint(equalToConstant: UIScreen.main.bounds.height * 0.63)

        NSLayoutConstraint.activate([
            posterImageView.heightAnchor.constraint(equalToConstant: 100),
            posterImageView.topAnchor.constraint(equalTo: topAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor),

            titleTextField.heightAnchor.constraint(equalToConstant: 30),
            titleTextField.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 24),
            titleTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            authorTextField.heightAnchor.constraint(equalToConstant: 30),
            authorTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20),
            authorTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            authorTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            descriptionTextView.topAnchor.constraint(equalTo: authorTextField.bottomAnchor, constant: 20),
            descriptionTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            descriptionTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with piece: PieceDetails) {
        posterImageView.image = UIImage(named: piece.iconName)
        titleTextField.text = piece.title
        authorTextField.text = piece.author
        descriptionTextView.text = piece.description

        let isOversize = descriptionTextView.contentSize.height >= descriptionTextViewHeightConstraint.constant
        descriptionTextViewHeightConstraint.isActive = isOversize
        descriptionTextView.isScrollEnabled = isOversize
    }

    func adjustTextViewHeight() {
        let contentHeight = descriptionTextView.contentSize.height
        let isOversize = contentHeight >= descriptionTextViewHeightConstraint.constant


        if descriptionTextView.frame.height > 300 {
            descriptionTextViewHeightConstraint.constant = 250
            descriptionTextViewHeightConstraint.isActive = isOversize
            descriptionTextView.isScrollEnabled = true
        }
    }
}
