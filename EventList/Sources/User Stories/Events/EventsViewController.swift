import SnapKit
import UIKit

final class EventsViewController: UIViewController {
	private let viewModel: EventsViewModel

	private let tableView = UITableView(frame: .zero, style: .grouped)

	init(viewModel: EventsViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)

		self.viewModel.stateDidChange = { [weak self] in
			self?.tableView.reloadData()
		}
	}

	@available(*, unavailable)
	required init(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		title = NSLocalizedString("events.title", comment: "")
		view.backgroundColor = .els_white_codGrey

		view.addSubview(tableView)
		tableView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}

		configureTableView()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		viewModel.viewWillAppear()
	}
}

// MARK: - Private

private extension EventsViewController {
	func configureTableView() {
		tableView.separatorStyle = .none
		tableView.sectionFooterHeight = 1
		tableView.backgroundColor = .els_white_codGrey
		tableView.dataSource = self
		tableView.delegate = self
		tableView.register(EventCell.self, forCellReuseIdentifier: EventCell.reuseIdentifier)
		tableView.register(EventPlaceholderCell.self, forCellReuseIdentifier: EventPlaceholderCell.reuseIdentifier)
		tableView.register(EventHeaderCell.self, forCellReuseIdentifier: EventHeaderCell.reuseIdentifier)
		tableView.estimatedRowHeight = 250
	}
}

// MARK: - UITableViewDataSource

extension EventsViewController: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		viewModel.numberOfSections
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewModel.numberOfRowsInSection(section)
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		switch viewModel.state {
			case .success(let items):
				let cell = tableView.dequeueReusableCell(withIdentifier: EventCell.reuseIdentifier, for: indexPath)
					as? EventCell
				cell?.viewModel = items[indexPath.section].items[indexPath.row]
				return cell ?? UITableViewCell()
			case let .empty(headerVM, _),
				 let .failure(headerVM, _),
				 let .offline(headerVM, _):
				if indexPath.row == 0 {
					let cell = tableView.dequeueReusableCell(withIdentifier: EventHeaderCell.reuseIdentifier)
						as? EventHeaderCell
					cell?.viewModel = headerVM
					return cell ?? UITableViewCell()
				} else {
					let cell = tableView.dequeueReusableCell(withIdentifier: EventPlaceholderCell.reuseIdentifier, for: indexPath)
					return cell
				}
			case .loading:
				let cell = tableView.dequeueReusableCell(withIdentifier: EventPlaceholderCell.reuseIdentifier, for: indexPath)
				return cell
		}
	}

	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		viewModel.titleForHeaderInSection(section)
	}
}

// MARK: - UITableViewDelegate

extension EventsViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		let footer = UIView()
		footer.backgroundColor = .els_alabaster_tuna
		return footer
	}
}

