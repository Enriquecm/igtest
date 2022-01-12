//
//  ArticlesViewController.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 08/01/22.
//

import Combine
import UIKit

class ArticlesViewController: UIViewController {

    private let viewModel: ArticlesViewModel

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

    private var dataSource = [ReportSection]() {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: - Life cycle

    init(viewModel: ArticlesViewModel) {
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
    }

    // MARK: - Private methods

    private func setupBindings() {
        isLoadingSubject
            .assign(to: \.showLoading, on: self)
            .store(in: &cancellables)

        viewModel.fetchDashboard()
            .receive(on: RunLoop.main)
            .observeFetchStatus(with: isLoadingSubject)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.showSimpleAlert("Alert", message: error.message)
                case .finished:
                    break
                }
            } receiveValue: { [weak self] reportSections in
                self?.dataSource = reportSections
            }
            .store(in: &cancellables)

    }

    private func setupUI() {
        extendedLayoutIncludesOpaqueBars = true
        view.backgroundColor = ColorPalette.background

        view.addSubview(tableView)
        tableView.constraintToMatch(view: view)

        setupTableView()
    }

    private func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.tableHeaderView = UIView()
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(ReportTableViewCell.self, forCellReuseIdentifier: ReportTableViewCell.identifier)
    }
}

extension ArticlesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].reports.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReportTableViewCell.identifier, for: indexPath)
        if let cell = cell as? ReportTableViewCell {
            let report = dataSource[indexPath.section].reports[indexPath.row]
            cell.setup(with: report)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataSource[section].title
    }
}

extension ArticlesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let report = dataSource[indexPath.section].reports[indexPath.row]
        viewModel.didSelect(report: report)
    }
}

extension ArticlesViewController: UISplitViewControllerDelegate {
    func splitViewController(
        _ splitViewController: UISplitViewController,
        collapseSecondary secondaryViewController: UIViewController,
        onto primaryViewController: UIViewController
    ) -> Bool {
        if let navigationController = secondaryViewController as? UINavigationController,
            navigationController.topViewController is ArticleDetailViewController {
            return true
        } else {
            return false
        }
    }

    @available(iOS 14.0, *)
    func splitViewController(
        _ svc: UISplitViewController,
        topColumnForCollapsingToProposedTopColumn proposedTopColumn: UISplitViewController.Column
    ) -> UISplitViewController.Column {
        return .primary
    }
}
