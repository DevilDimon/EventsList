struct EventsTableSection: Equatable {
	static func ==(lhs: EventsTableSection, rhs: EventsTableSection) -> Bool {
		lhs.items == rhs.items
	}


	let name: String
	let items: [EventCellViewModel]
}
