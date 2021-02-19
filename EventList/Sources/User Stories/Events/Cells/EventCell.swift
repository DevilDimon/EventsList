import Kingfisher
import UIKit

private enum Constants {
	static let imageTransitionTimeInterval: TimeInterval = 0.5
}

final class EventCell: UITableViewCell {
	static let reuseIdentifier = String(describing: self)

	var viewModel: EventCellViewModel? {
		didSet {
			viewModelDidChange()
		}
	}

	private let containerView: UIView = {
		let view = UIView()
		view.clipsToBounds = true
		view.backgroundColor = .els_alabaster_tuatara
		view.layer.cornerRadius = 4
		return view
	}()

	private let eventImageView: UIImageView = {
		let view = UIImageView()
		view.clipsToBounds = true
		view.contentMode = .scaleAspectFill
		return view
	}()

	private let costContainer: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor.black.withAlphaComponent(0.72)
		view.layer.cornerRadius = 4
		return view
	}()

	private let costLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 1
		label.font = .boldSystemFont(ofSize: 12)
		label.textColor = .white
		return label
	}()

	private let venueLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 1
		label.font = .systemFont(ofSize: 17, weight: .medium)
		label.textColor = .white
		return label
	}()

	private let locationLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 1
		label.font = .systemFont(ofSize: 16, weight: .regular)
		label.textColor = .els_silver
		return label
	}()

	private let dateLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 1
		label.textAlignment = .right
		label.font = .systemFont(ofSize: 17, weight: .medium)
		label.textColor = .white
		return label
	}()

	private let durationLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 1
		label.textAlignment = .right
		label.font = .systemFont(ofSize: 16, weight: .regular)
		label.textColor = .els_silver
		return label
	}()

	private let backgroundGradientView: GradientView = {
		let colors = [UIColor.clear, UIColor.clear, UIColor.black]
		let locations: [CGFloat] = [0, 0.5, 1]
		let view = GradientView(frame: .zero, colors: colors, locations: locations)
		return view
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		contentView.backgroundColor = .els_white_codGrey

		contentView.addSubview(containerView)
		containerView.snp.makeConstraints { make in
			make.height.equalTo(175).priority(999)
			make.leading.equalToSuperview().offset(12)
			make.top.equalToSuperview()
			make.trailing.equalToSuperview().offset(-12)
			make.bottom.equalToSuperview().offset(-20)
		}

		containerView.addSubview(eventImageView)
		eventImageView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}

		containerView.addSubview(backgroundGradientView)
		backgroundGradientView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}

		containerView.addSubview(costContainer)
		costContainer.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(12)
			make.leading.equalToSuperview().offset(16)
			make.trailing.lessThanOrEqualToSuperview().offset(-12)
		}

		costContainer.addSubview(costLabel)
		costLabel.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(4)
			make.leading.equalToSuperview().offset(8)
			make.trailing.equalToSuperview().offset(-8)
			make.bottom.equalToSuperview().offset(-4)
		}

		containerView.addSubview(venueLabel)
		venueLabel.snp.makeConstraints { make in
			make.leading.equalToSuperview().offset(16)
		}

		venueLabel.setContentHuggingPriority(.init(249), for: .horizontal)

		containerView.addSubview(locationLabel)
		locationLabel.snp.makeConstraints { make in
			make.top.equalTo(venueLabel.snp.bottom).offset(6)
			make.leading.equalToSuperview().offset(16)
			make.bottom.equalToSuperview().offset(-10)
		}

		locationLabel.setContentHuggingPriority(.init(249), for: .horizontal)

		containerView.addSubview(dateLabel)
		dateLabel.snp.makeConstraints { make in
			make.leading.equalTo(venueLabel.snp.trailing).offset(6)
			make.trailing.equalToSuperview().offset(-16)
		}

		dateLabel.setContentCompressionResistancePriority(.init(751), for: .horizontal)

		containerView.addSubview(durationLabel)
		durationLabel.snp.makeConstraints { make in
			make.top.equalTo(dateLabel.snp.bottom).offset(6)
			make.trailing.equalToSuperview().offset(-16)
			make.leading.equalTo(locationLabel.snp.trailing).offset(6)
			make.bottom.equalToSuperview().offset(-10)
		}

		durationLabel.setContentCompressionResistancePriority(.init(751), for: .horizontal)
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init?(coder:) not implemented")
	}

	override func prepareForReuse() {
		super.prepareForReuse()
		eventImageView.kf.cancelDownloadTask()
	}
}

// MARK: - Private

private extension EventCell {
	func viewModelDidChange() {
		guard let viewModel = viewModel else { return }

		costLabel.text = viewModel.costText
		venueLabel.text = viewModel.venueText
		locationLabel.text = viewModel.locationText
		dateLabel.text = viewModel.dateText
		durationLabel.text = viewModel.durationText

		if let imageURL = viewModel.imageURL {
			eventImageView.kf.setImage(
				with: imageURL,
				options: [
					.processor(DownsamplingImageProcessor(size: CGSize(width: 350, height: 175))),
					.transition(.fade(Constants.imageTransitionTimeInterval)),
					.scaleFactor(UIScreen.main.scale)
				]
			)
		} else {
			eventImageView.image = nil
		}
	}
}
