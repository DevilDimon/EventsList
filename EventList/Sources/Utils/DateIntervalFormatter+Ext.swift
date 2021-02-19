import Foundation

extension DateIntervalFormatter {
	static let shortTime: DateIntervalFormatter = {
		let formatter = DateIntervalFormatter()
		formatter.timeStyle = .short
		formatter.dateStyle = .none
		return formatter
	}()
}
