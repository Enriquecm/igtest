//
//  MarketsViewController.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 08/01/22.
//

import Combine
import UIKit

class MarketsViewController: UIViewController {

    private let viewModel: MarketsViewModel

    // MARK: - UI Elements

    private let loadingView = LoadingView()
    private let tableView = UITableView(frame: .zero, style: .plain)

    // MARK: - Private properties

    private var cancellables = Set<AnyCancellable>()
    private var isLoadingSubject = PassthroughSubject<Bool, Never>()

    private var showLoading: Bool = false {
        didSet {
            showLoading ? loadingView.startLoading() : loadingView.stopLoading()
        }
    }

    private var dataSource = [MarketSection]() {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: - Life cycle

    init(viewModel: MarketsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupBindings()
        setupUI()
        loadContent()
    }

    // MARK: - Private methods

    private func setupBindings() {
        isLoadingSubject
            .assign(to: \.showLoading, on: self)
            .store(in: &cancellables)
    }

    private func setupUI() {
        extendedLayoutIncludesOpaqueBars = false
        view.backgroundColor = ColorPalette.background

        view.addSubview(tableView)
        tableView.constraintToMatch(view: view)

        setupTableView()
    }

    private func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.tableHeaderView = UIView()
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    }

    private func loadContent() {
        viewModel.fetchMarkets()
            .receive(on: RunLoop.main)
            .observeFetchStatus(with: isLoadingSubject)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.showSimpleAlert("Alert", message: error.message) { _ in
                        self?.loadContent()
                    }
                case .finished:
                    break
                }
            } receiveValue: { [weak self] marketSections in
                self?.dataSource = marketSections
            }
            .store(in: &cancellables)
    }
}

extension MarketsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].markets.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let market = dataSource[indexPath.section].markets[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.text = market.displayName

        if let rateDetailURL = market.rateDetailURL,
           let url = URL(string: rateDetailURL),
           UIApplication.shared.canOpenURL(url) {
            cell.accessoryType = .detailButton
        } else {
            cell.accessoryType = .none
        }
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataSource[section].title
    }
}

extension MarketsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let market = dataSource[indexPath.section].markets[indexPath.row]

        guard
            let rateDetailURL = market.rateDetailURL,
            let url = URL(string: rateDetailURL),
            UIApplication.shared.canOpenURL(url)
        else { return }

        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
