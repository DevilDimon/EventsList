import Foundation

extension DateFormatter {
	static let monthName: DateFormatter = {
		let formatter = DateFormatter()
		formatter.timeZone = TimeZone(secondsFromGMT: 0)
		formatter.setLocalizedDateFormatFromTemplate("MMMM")
		return formatter
	}()
}
