import Foundation

struct Event: Codable, Equatable {
	let imageUrl: URL?
	let cost: String?
	let location: String?
	let venue: String?
	let startTime: Date
	let endTime: Date
}
