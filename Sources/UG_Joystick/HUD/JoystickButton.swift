//
//  JoystickButton.swift
//  
//
//  Created by Andrey Goryunov on 03.09.2021.
//

import UIKit

public protocol JoystickButtonOutput: AnyObject {
    
    func onJumpButtonPress()
    
}

final class JoystickButton: UIButton {
    
    // MARK: - Private properties
    
    private weak var output: JoystickButtonOutput?
    
    // MARK: - Life cycle
    
    init(image: UIImage, output: JoystickButtonOutput) {
        self.output = output
        
        super.init(frame: .zero)
        
        configureView(image: image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Private

private extension JoystickButton {
    
    func configureView(image: UIImage) {
        setImage(image, for: .normal)
        addTarget(self, action: #selector(onJumpButtonTap), for: .touchUpInside)
    }
    
}

// MARK: - Private actions

private extension JoystickButton {
    
    @objc func onJumpButtonTap() {
        output?.onJumpButtonPress()
    }
    
}
