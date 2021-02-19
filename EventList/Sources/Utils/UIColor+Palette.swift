import class UIKit.UIColor

extension UIColor {
	static func color(_ light: UIColor, dark: UIColor) -> UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { $0.userInterfaceStyle == .dark ? dark : light }
		} else {
			return light
		}
	}


	static let els_codGrey: UIColor = #colorLiteral(red: 0.06666666667, green: 0.06666666667, blue: 0.06666666667, alpha: 1)
	static let els_tuatara: UIColor = #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
	static let els_tuna: UIColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
	static let els_alabaster: UIColor = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)

	static let els_white_codGrey = UIColor.color(.white, dark: .els_codGrey)
	static let els_alabaster_tuna = UIColor.color(.els_alabaster, dark: .els_tuna)
	static let els_alabaster_tuatara = UIColor.color(.els_alabaster, dark: .els_tuatara)
}