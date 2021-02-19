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
		view.layer.cornerRadius = 6
		return view
	}()

	private let eventImageView: UIImageView = {
		let view = UIImageView()
		view.clipsToBounds = true
		view.contentMode = .scaleAspectFill
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

		if let imageURL = viewModel.imageURL {
			eventImageView.kf.setImage(
				with: imageURL,
				options: [
					// An empirically chosen fixed size to maintain smooth scrolling
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
