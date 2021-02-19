import Foundation

final class EventCellViewModel: Equatable {
	static func ==(lhs: EventCellViewModel, rhs: EventCellViewModel) -> Bool {
		lhs.model == rhs.model
	}

	var imageURL: URL? {
		model.imageUrl
	}

	var costText: String {
		model.cost?.localizedUppercase ?? NSLocalizedString("events.cell.cost.unknown", comment: "")
	}

	var locationText: String {
		model.location ?? NSLocalizedString("events.cell.location.unknown", comment: "")
	}

	var venueText: String {
		model.venue ?? NSLocalizedString("events.cell.venue.unknown", comment: "")
	}

	var dateText: String {
		DateFormatter.monthDay.string(from: model.startTime)
	}

	var durationText: String {
		DateIntervalFormatter.shortTime.string(from: model.startTime, to: model.endTime)
	}

	private let model: Event

	init(model: Event) {
		self.model = model
	}
}
