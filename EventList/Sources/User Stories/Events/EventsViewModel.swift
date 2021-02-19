final class EventsViewModel {
	private let eventsAPIService: IEventsAPIService

	init(eventsAPIService: IEventsAPIService) {
		self.eventsAPIService = eventsAPIService
	}

	func viewWillAppear() {
		eventsAPIService.fetchEvents {
			print($0)
		}
	}
}
