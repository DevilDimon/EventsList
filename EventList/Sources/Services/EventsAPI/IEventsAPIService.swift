enum EventsAPIServiceError: Error {
	case requestFailure
	case decodingFailure
	case invalidURL
	case noInternet
}

protocol IEventsAPIService {
	func fetchEvents(completion: @escaping (Result<[Event], EventsAPIServiceError>) -> Void)
}
