import Foundation
import UIKit
extension UIView {
    func roundCorners(radius: CGFloat? = 10) {
        self.layer.cornerRadius = radius ?? 10
    }
    
    func dropShadow(color: UIColor, shadowOpacity: Float, shadowRadius: CGFloat){
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}
