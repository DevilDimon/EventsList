import UIKit

final class EventHeaderCellViewModel {
	enum HeaderType {
		case empty
		case offline
		case error
	}

	var didTapRetry: (() -> Void)?

	var iconImage: UIImage? {
		switch type {
			case .empty: return UIImage(named: "EmptyList")
			case .offline: return UIImage(named: "Offline")
			case .error: return UIImage(named: "Error")
		}
	}

	var nameText: String {
		switch type {
			case .empty: return NSLocalizedString("events.header.empty.title", comment: "")
			case .offline: return NSLocalizedString("events.header.offline.title", comment: "")
			case .error: return NSLocalizedString("events.header.error.title", comment: "")
		}
	}

	var captionText: String {
		switch type {
			case .empty: return NSLocalizedString("events.header.empty.caption", comment: "")
			case .offline: return NSLocalizedString("events.header.offline.caption", comment: "")
			case .error: return NSLocalizedString("events.header.error.caption", comment: "")
		}
	}

	var shouldShowRetry: Bool {
		switch type {
			case .empty:
				return false
			case .error, .offline:
				return true
		}
	}

	private let type: HeaderType

	init(type: HeaderType, didTapRetry: (() -> Void)? = nil) {
		self.type = type
		self.didTapRetry = didTapRetry
	}

	
}
