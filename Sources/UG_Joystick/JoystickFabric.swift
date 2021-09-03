//
//  JoystickFabric.swift
//  
//
//  Created by Andrey Goryunov on 03.09.2021.
//

import UIKit

final public class JoystickFabric {
    
    // MARK: - Public enums
    
    public enum Types {
        case joystick(
                dragButtonImage: UIImage,
                backgroundImage: UIImage,
                width: CGFloat,
                output: JoystickViewOutput
        )
        case button(image: UIImage, output: JoystickButtonOutput)
    }
    
    // MARK: - Public life cycle
    
    public init() {
        
    }
    
    // MARK: - Public functions
    
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
