//
//  ViewController.swift
//  CleanArchitecture
//
//  Created by Saikal Toichueva on 18.05.2022.
//

import UIKit

class PiecesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let mainView = PiecesView()
    private var viewModel: PiecesViewModel
    
    init(viewModel: PiecesViewModel) {

        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        title = "List"

        viewModel.pieces.observe(on: self) { [weak self] pieces in
            self?.mainView.piecesTableView.reloadData()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.backButtonTitle = ""

        view.addSubview(mainView)
        view.addConstraint(mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor))
        view.addConstraint(mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor))
        view.addConstraint(mainView.topAnchor.constraint(equalTo: view.topAnchor))
        view.addConstraint(mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor))

        mainView.delegate = self
        mainView.piecesTableView.delegate = self
        mainView.piecesTableView.dataSource = self
        mainView.piecesTableView.register(PieceCell.self, forCellReuseIdentifier: "Cell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pieces.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        guard let cell = cell as? PieceCell else { return UITableViewCell() }

        cell.configure(piece: viewModel.pieces.value[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didTapOnPiece(at: indexPath.row)
    }
}

extension PiecesViewController: PiecesViewDelegate {
    func onNewPieceButtonTapped() {
        viewModel.addNewPiece()
    }

    func onRandomPieceButtonTapped() {
        viewModel.addRandomPiece()
    }
}
