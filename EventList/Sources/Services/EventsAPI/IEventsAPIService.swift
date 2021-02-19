enum EventsAPIServiceError: Error {
	case requestFailure
	case decodingFailure
	case invalidURL
}

protocol IEventsAPIService {
	func fetchEvents(completion: @escaping (Result<[Event], EventsAPIServiceError>) -> Void)
}
