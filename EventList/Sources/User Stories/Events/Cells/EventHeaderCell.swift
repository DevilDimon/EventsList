import UIKit

final class EventHeaderCell: UITableViewCell {
	static let reuseIdentifier = String(describing: EventHeaderCell.self)

	var viewModel: EventHeaderCellViewModel? {
		didSet {
			viewModelChanged()
		}
	}

	private let stackView: UIStackView = {
		let stack = UIStackView()
		stack.axis = .vertical
		stack.alignment = .center
		stack.isLayoutMarginsRelativeArrangement = true
		stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 35, bottom: 60, trailing: 35)
		return stack
	}()

	private let iconImageView: UIImageView = {
		let view = UIImageView()
		view.tintColor = .els_dustyGrey_silver
		return view
	}()

	private let nameLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 1
		label.font = .systemFont(ofSize: 17, weight: .medium)
		label.textColor = .els_dustyGrey_silver
		return label
	}()

	private let captionLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.textAlignment = .center
		label.font = .systemFont(ofSize: 16, weight: .regular)
		label.textColor = .els_dustyGrey_silver
		return label
	}()

	private let retryButton: UIButton = {
		let button = UIButton(type: .custom)
		let attributedTitle = NSAttributedString(
			string: NSLocalizedString("events.header.retry", comment: ""),
			attributes: [.foregroundColor: UIColor.els_white_codGrey, .font: UIFont.systemFont(ofSize: 16, weight: .medium)]
		)
		button.setAttributedTitle(attributedTitle, for: .normal)
		button.backgroundColor = .els_pizazz_brightTurquoise
		button.layer.cornerRadius = 8
		button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 25, bottom: 10, right: 25)
		return button
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		contentView.backgroundColor = .els_white_codGrey

		contentView.addSubview(stackView)
		stackView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}

		stackView.addArrangedSubview(iconImageView)
		stackView.setCustomSpacing(20, after: iconImageView)

		stackView.addArrangedSubview(nameLabel)
		stackView.setCustomSpacing(6, after: nameLabel)

		stackView.addArrangedSubview(captionLabel)
		stackView.setCustomSpacing(20, after: captionLabel)

		stackView.addArrangedSubview(retryButton)
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init?(coder:) not implemented")
	}
}

// MARK: - Private

private extension EventHeaderCell {
	func viewModelChanged() {
		guard let viewModel = viewModel else { return }

		iconImageView.image = viewModel.iconImage
		nameLabel.text = viewModel.nameText
		captionLabel.text = viewModel.captionText
		retryButton.isHidden = !viewModel.shouldShowRetry
	}
}
