import UIKit

final class GradientView: UIView {
	override class var layerClass: AnyClass {
		CAGradientLayer.self
	}

	private var gradientLayer: CAGradientLayer {
		assert(layer is CAGradientLayer)
		return layer as! CAGradientLayer
	}

	private let colors: [UIColor]
	private let locations: [CGFloat]

	init(frame: CGRect, colors: [UIColor], locations: [CGFloat]) {
		self.colors = colors
		self.locations = locations
		super.init(frame: frame)
		updateGradient()
	}

	@available(*, unavailable)
	required init(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func updateGradient() {
		gradientLayer.colors = colors.map { $0.cgColor }
		gradientLayer.locations = locations.map { $0 as NSNumber }
	}
}
