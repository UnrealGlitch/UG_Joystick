//
//  JoystickFabric.swift
//  
//
//  Created by Andrey Goryunov on 03.09.2021.
//

import UIKit

/// Сontrol factory
final public class JoystickFabric {
    
    // MARK: - Public enums
    
    /// Control types
    public enum Types {
        /// Create joystick. The control is gripped by the user and moved in the desired direction.
        /// Each time you interact with a control, a coordinate change is signaled
        /// - Parameter dragButtonImage: The picture for the joystick control.
        /// - Parameter backgroundImage: Joystick background picture.
        /// - Parameter width: The width of the entire joystick.
        /// - Parameter output: Delegate
        case joystick(
                dragButtonImage: UIImage,
                backgroundImage: UIImage,
                width: CGFloat,
                output: JoystickViewOutput
        )
        
        /// Create button
        /// - Parameter image: The picture for the button.
        /// - Parameter output: Delegate
        case button(image: UIImage, output: JoystickButtonOutput)
    }
    
    // MARK: - Public life cycle
    
    /// Initializer
    public init() {
        
    }
    
    // MARK: - Public functions
    
    /// Creating a control
    /// - Parameter type: control type
    /// - Returns: required control
    public func create(type: Types) -> UIButton {
        switch type {
        case .button(let image, let output):
            return JoystickButton(image: image, output: output)
        case .joystick(let dragButtonImage, let backgroundImage, let width, let output):
            return JoystickView(
                dragButtonImage: dragButtonImage,
                joystickImage: backgroundImage,
                tumblerWidth: width,
                output: output
            )
        }
    }
    
}
