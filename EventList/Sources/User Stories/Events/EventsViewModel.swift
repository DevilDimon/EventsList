import Foundation

final class EventsViewModel {
	enum State: Equatable {
		case success([EventsTableSection])
		case loading([EventPlaceholderCellViewModel])
		case empty(EventHeaderCellViewModel, [EventPlaceholderCellViewModel])
		case failure(EventHeaderCellViewModel, [EventPlaceholderCellViewModel])
		case offline(EventHeaderCellViewModel, [EventPlaceholderCellViewModel])

		static func ==(lhs: State, rhs: State) -> Bool {
			switch (lhs, rhs) {
				case let (.success(leftItems), .success(rightItems)):
					return leftItems == rightItems
				case (.loading, .loading),
					 (.empty, .empty),
					 (.failure, .failure),
					 (.offline, .offline):
					return true
				default:
					return false
			}
		}
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

	private(set) var state: State = .loading([.init(), .init(), .init()]) {
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
			case .loading(let placeholders),
				 .empty(_, let placeholders),
				 .failure(_, let placeholders),
				 .offline(_, let placeholders):
				return placeholders.count + 1
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


	// MARK: View events
	
	func viewWillAppear() {
		fetchEvents()
	}

}

// MARK: - Private

private extension EventsViewModel {
	func fetchEvents() {
		state = .loading([.init(), .init(), .init()])
		eventsAPIService.fetchEvents { [weak self] result in
			guard let self = self else { return }

			let retryClosure: () -> Void = { [weak self] in self?.fetchEvents() }

			let state: State
			switch result {
				case .success(let events) where events.isEmpty == true:
					state = .empty(.init(type: .empty), [.init(), .init()])
				case .success(let events):
					let sections = self.makeSections(from: events)
					state = .success(sections)
				case .failure(let error) where error == .noInternet:
					state = .failure(.init(type: .offline, didTapRetry: retryClosure), [.init(), .init()])
				case .failure:
					state = .failure(.init(type: .error, didTapRetry: retryClosure), [.init(), .init()])
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
