import UIKit

extension UIColor {
	static func color(_ light: UIColor, dark: UIColor) -> UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { $0.userInterfaceStyle == .dark ? dark : light }
		} else {
			return light
		}
	}

	func cgColor(with traitCollection: UITraitCollection) -> CGColor {
		if #available(iOS 13.0, *) {
			return self.resolvedColor(with: traitCollection).cgColor
		} else {
			return self.cgColor
		}
	}

	static let els_codGrey: UIColor = #colorLiteral(red: 0.06666666667, green: 0.06666666667, blue: 0.06666666667, alpha: 1)
	static let els_tuatara: UIColor = #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
	static let els_tuna: UIColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
	static let els_silver: UIColor = #colorLiteral(red: 0.7411764706, green: 0.7411764706, blue: 0.7411764706, alpha: 1)
	static let els_mercury: UIColor = #colorLiteral(red: 0.8901960784, green: 0.8901960784, blue: 0.8901960784, alpha: 1)
	static let els_alabaster: UIColor = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)

	static let els_white_codGrey = UIColor.color(.white, dark: .els_codGrey)
	static let els_mercury_tuna = UIColor.color(.els_mercury, dark: .els_tuna)
	static let els_alabaster_tuna = UIColor.color(.els_alabaster, dark: .els_tuna)
	static let els_alabaster_tuatara = UIColor.color(.els_alabaster, dark: .els_tuatara)
}
