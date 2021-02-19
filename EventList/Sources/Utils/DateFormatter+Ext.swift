import Foundation

extension DateFormatter {
	static let monthName: DateFormatter = {
		let formatter = DateFormatter()
		formatter.setLocalizedDateFormatFromTemplate("LLLL")
		return formatter
	}()

	static let monthDay: DateFormatter = {
		let formatter = DateFormatter()
		formatter.setLocalizedDateFormatFromTemplate("dd MMMM")
		return formatter
	}()
}
