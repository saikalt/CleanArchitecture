//
//  PieceViewController.swift
//  test-task-halbestunde
//
//  Created by Iurii Gubanov on 18.05.2022.
//

import UIKit

class PieceDetailsViewController: UIViewController {
    private let mainView = PieceDetailsView()
    private let viewModel: PieceDetailsViewModel

    var saveButton: UIBarButtonItem?
    var isKeyboardShown: Bool = false

    init(viewModel: PieceDetailsViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.configure(with: viewModel.piece)

        setupNavigationBar()
        setupTargets()
        setupView()
    }

    private func setupView() {
        view.addSubview(mainView)

        mainView.translatesAutoresizingMaskIntoConstraints = false

        view.addConstraint(mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor))
        view.addConstraint(mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor))
        view.addConstraint(mainView.topAnchor.constraint(equalTo: view.topAnchor))
        view.addConstraint(mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor))
    }

    private func setupNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.tintColor = .white

        saveButton = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveAction))
        navigationItem.rightBarButtonItem = saveButton
        saveButton?.isEnabled = false
    }

    private func setupTargets() {
        mainView.titleTextField.addTarget(self, action: #selector(textFieldsOrViewsDidChange), for: .editingChanged)
        mainView.authorTextField.addTarget(self, action: #selector(textFieldsOrViewsDidChange), for: .editingChanged)

        mainView.descriptionTextView.delegate = self
    }

    @objc func textFieldsOrViewsDidChange() {
        let isTitleNotEmpty = !(mainView.titleTextField.text?.isEmpty ?? true)
        let isAuthorNotEmpty = !(mainView.authorTextField.text?.isEmpty ?? true)
        let isTextChanged = mainView.titleTextField.text != viewModel.piece.title || mainView.authorTextField.text != viewModel.piece.author

        let isDescriptionNotEmpty = !mainView.descriptionTextView.text.isEmpty
        let wasDescriptionEdited = mainView.descriptionTextView.text != viewModel.piece.description

        let canEdit = (isTitleNotEmpty && isAuthorNotEmpty && isDescriptionNotEmpty) && (isTextChanged || wasDescriptionEdited)
        saveButton?.isEnabled = canEdit
    }

    @objc private func saveAction() {
        viewModel.save(piece: .init(title: mainView.titleTextField.text!,
                                    author: mainView.authorTextField.text!,
                                    description: mainView.descriptionTextView.text!,
                                    iconName: viewModel.piece.iconName))
    }
}

extension PieceDetailsViewController: UITextViewDelegate {

    func textViewDidBeginEditing(_ textView: UITextView) {
        mainView.adjustTextViewHeight()
    }

    func textViewDidChange(_ textView: UITextView) {
        mainView.adjustTextViewHeight()
        textFieldsOrViewsDidChange()
    }
}
