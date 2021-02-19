import Foundation

final class EventsViewModel {
	enum State: Equatable {
		case success([EventsTableSection])
		case loading
		case failure
		case offline
	}

	var numberOfSections: Int {
		switch state {
			case .success(let sections):
				return sections.count
			default:
				return 1
		}
	}

	var stateDidChange: (() -> Void)?

	private(set) var state: State = .loading {
		didSet {
			if state != oldValue {
				stateDidChange?()
			}
		}
	}

	private let eventsAPIService: IEventsAPIService

	init(eventsAPIService: IEventsAPIService) {
		self.eventsAPIService = eventsAPIService
	}

	func numberOfRowsInSection(_ section: Int) -> Int {
		switch state {
			case .success(let sections):
				assert(section < sections.count)
				return sections[section].items.count
			default:
				return 3
		}
	}

	func titleForHeaderInSection(_ section: Int) -> String? {
		switch state {
			case .success(let sections):
				assert(section < sections.count)
				return sections[section].name
			default:
				return nil
		}
	}

	func viewWillAppear() {
		fetchEvents()
	}
}

// MARK: - Private

private extension EventsViewModel {
	func fetchEvents() {
		eventsAPIService.fetchEvents { [weak self] result in
			guard let self = self else { return }

			let state: State
			switch result {
				case .success(let events):
					let sections = self.makeSections(from: events)
					state = .success(sections)
				case .failure:
					state = .failure
			}

			DispatchQueue.main.async { [weak self] in
				self?.state = state
			}
		}
	}

	func makeSections(from events: [Event]) -> [EventsTableSection] {
		let sortedEvents = events.sorted(by: { $0.startTime < $1.startTime })
		guard let firstEvent = sortedEvents.first else { return [] }

		// Traverse and start a new section when month/year changes
		var result = [EventsTableSection]()
		var currentDate = firstEvent.startTime
		var monthEvents = [Event]()
		for event in sortedEvents {
			let date = event.startTime
			guard Calendar.current.isDate(date, equalTo: currentDate, toGranularity: .month) else {
				let sectionName = DateFormatter.monthName.string(from: currentDate)
				let sectionItems = monthEvents.map { EventCellViewModel(model: $0) }
				result.append(EventsTableSection(name: sectionName, items: sectionItems))
				monthEvents = [event]
				currentDate = date
				continue
			}

			monthEvents.append(event)
		}

		if monthEvents.isEmpty == false {
			let sectionName = DateFormatter.monthName.string(from: currentDate)
			let sectionItems = monthEvents.map { EventCellViewModel(model: $0) }
			result.append(EventsTableSection(name: sectionName, items: sectionItems))
		}

		return result
	}
}
