//
//  InsetTextField.swift
//  DesireMind
//
//  Created by Vlad Rusu on 17/05/2020.
//  Copyright © 2020 Linnify. All rights reserved.
//

import UIKit

@IBDesignable class InsetTextField: UITextField {

    @IBInspectable var leftInset: CGFloat = 0.0 {
        didSet {
            self.edgeInsets.left = leftInset
        }
    }
    
    @IBInspectable var rightInset: CGFloat = 0.0 {
        didSet {
            self.edgeInsets.right = rightInset
        }
    }
    
    @IBInspectable var topInset: CGFloat = 0.0 {
        didSet {
            self.edgeInsets.top = topInset
        }
    }
    
    @IBInspectable var bottomInset: CGFloat = 0.0 {
        didSet {
            self.edgeInsets.bottom = bottomInset
        }
    }
    
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    var edgeInsets: UIEdgeInsets = .zero
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return super.textRect(forBounds: bounds).inset(by: edgeInsets)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return super.editingRect(forBounds: bounds).inset(by: edgeInsets)
    }

}
