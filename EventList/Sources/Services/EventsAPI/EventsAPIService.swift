import Foundation

private enum Constants {
	static let baseURLString = "https://api.jsonbin.io/b/6026992b435c323ba1c55165/2"
	static let apiKey = "$2b$10$UYzh11htUekIGiMu6E.L2uJNU7HQAhOd5moG2KA7Fr1LuiESICroq"
}

final class EventsAPIService: IEventsAPIService {
	private let urlSession = URLSession(configuration: .default)
	private lazy var dateFormatter: ISO8601DateFormatter = {
		let formatter = ISO8601DateFormatter()
		formatter.formatOptions = [
			.withFullDate, .withTime, .withDashSeparatorInDate, .withSpaceBetweenDateAndTime, .withColonSeparatorInTime
		]
		return formatter
	}()

	func fetchEvents(completion: @escaping (Result<[Event], EventsAPIServiceError>) -> Void) {
		guard let url = URL(string: Constants.baseURLString) else {
			completion(.failure(.invalidURL))
			return
		}

		var request = URLRequest(url: url)
		request.httpMethod = "GET"
		request.setValue(Constants.apiKey, forHTTPHeaderField: "secret-key")
		sendRequest(request, completion: completion)
	}

	private func sendRequest<T: Decodable>(
		_ request: URLRequest,
		completion: @escaping (Result<T, EventsAPIServiceError>) -> Void
	) {
		urlSession.dataTask(with: request) { [weak self] (data, _, error) in
			if error != nil {
				completion(.failure(.requestFailure))
				return
			} else if let data = data {
				do {
					let decoder = JSONDecoder()
					decoder.dateDecodingStrategy = .custom({
						let dateString = try $0.singleValueContainer().decode(String.self)
						if let date = self?.dateFormatter.date(from: dateString) {
							return date
						} else {
							throw EventsAPIServiceError.decodingFailure
						}
					})
					
					let decodedResponse = try decoder.decode(T.self, from: data)
					completion(.success(decodedResponse))
					return
				} catch {
					completion(.failure(.decodingFailure))
					return
				}
			}
		}
		.resume()
	}
}
