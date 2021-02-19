import struct Foundation.URL

final class EventCellViewModel: Equatable {
	static func ==(lhs: EventCellViewModel, rhs: EventCellViewModel) -> Bool {
		lhs.model == rhs.model
	}

	var imageURL: URL? {
		model.imageUrl
	}

	private let model: Event

	init(model: Event) {
		self.model = model
	}
}
