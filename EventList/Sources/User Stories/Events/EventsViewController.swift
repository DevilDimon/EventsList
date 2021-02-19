import UIKit

final class EventsViewController: UIViewController {
	private let viewModel: EventsViewModel

	init(viewModel: EventsViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}

	@available(*, unavailable)
	required init(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		viewModel.viewWillAppear()
	}
}

