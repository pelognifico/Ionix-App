//
//  UIButton+CE.swift
//  Ionix App
//
//  Created by Carlos Villamizar on 27/7/21.
//

import Foundation
import UIKit

extension UIButton {
    func leftImage(image: UIImage, renderMode: UIImage.RenderingMode) {
        self.setImage(image.withRenderingMode(renderMode), for: .normal)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: image.size.width / 2)
        self.contentHorizontalAlignment = .center
        self.imageView?.contentMode = .scaleAspectFit
    }

    func rightImage(image: UIImage, renderMode: UIImage.RenderingMode){
        self.setImage(image.withRenderingMode(renderMode), for: .normal)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left:image.size.width / 2, bottom: 0, right: 0)
        self.contentHorizontalAlignment = .right
        self.imageView?.contentMode = .scaleAspectFit
    }
    
    func setEdgeInsets() {
        self.titleEdgeInsets = UIEdgeInsets(top: 10,left: 20,bottom: 10,right: 10)
        self.imageEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 0)
    }
}
