import UIKit

final class EventLoadingCell: UITableViewCell {
	static let reuseIdentifier = String(describing: EventLoadingCell.self)

	private let containerView: UIView = {
		let view = UIView()
		view.clipsToBounds = true
		view.backgroundColor = .els_alabaster_tuatara
		view.layer.cornerRadius = 4
		view.layer.borderWidth = 1
		return view
	}()

	private let cameraIconImageView: UIImageView = {
		let imageView = UIImageView(image: UIImage(named: "Camera"))
		imageView.contentMode = .scaleAspectFit
		imageView.tintColor = .els_mercury_tuna
		return imageView
	}()

	private let firstFakeLine: UIView = {
		let view = UIView()
		view.backgroundColor = .els_mercury_tuna
		view.layer.cornerRadius = 4
		return view
	}()

	private let secondFakeLine: UIView = {
		let view = UIView()
		view.backgroundColor = .els_mercury_tuna
		view.layer.cornerRadius = 4
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
		containerView.layer.borderColor = UIColor.els_mercury_tuna.cgColor(with: traitCollection)

		containerView.addSubview(cameraIconImageView)
		cameraIconImageView.snp.makeConstraints { make in
			make.width.height.equalTo(48)
			make.top.equalToSuperview().offset(24)
			make.leading.equalToSuperview().offset(20)
		}

		containerView.addSubview(firstFakeLine)
		firstFakeLine.snp.makeConstraints { make in
			make.width.equalToSuperview().multipliedBy(0.7)
			make.height.equalTo(16)
			make.leading.equalToSuperview().offset(16)
		}

		containerView.addSubview(secondFakeLine)
		secondFakeLine.snp.makeConstraints { make in
			make.width.equalToSuperview().multipliedBy(0.45)
			make.height.equalTo(16)
			make.top.equalTo(firstFakeLine.snp.bottom).offset(6)
			make.leading.equalToSuperview().offset(16)
			make.bottom.equalToSuperview().offset(-10)
		}
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init?(coder:) not implemented")
	}

	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		super.traitCollectionDidChange(previousTraitCollection)

		if #available(iOS 13, *), traitCollection.userInterfaceStyle != previousTraitCollection?.userInterfaceStyle {
			containerView.layer.borderColor = UIColor.els_mercury_tuna.cgColor(with: traitCollection)
		}
	}
}
