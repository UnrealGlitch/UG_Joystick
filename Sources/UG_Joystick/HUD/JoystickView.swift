//
//  JoystickView.swift
//  
//
//  Created by Andrey Goryunov on 03.09.2021.
//

import UIKit

/// Delegate of Joystick View
public protocol JoystickViewOutput: AnyObject {
    
    /// Сalled when the user changes the position of the joystick.
    /// Top position returns -100.
    /// Left position returns -100.
    /// Center returns 0.
    /// Right position returns 100.
    /// Bottom position returns 100.
    /// - Parameter newCoordinateProcent: Returns the percentage of the joystick position.
    func onJoystickViewNewCoordinate(_ newCoordinateProcent: CGPoint)
    
    /// Called when the user releases the joystick
    func onJoystickViewDrop()
    
}

final class JoystickView: UIButton {
    
    // MARK: - Private properties
    
    private let tumblerWidth: CGFloat
    private let dragButtonImage: UIImage
    private weak var output: JoystickViewOutput?
    
    private lazy var dragButton: UIButton = {
        let dragButton = UIButton()
        
        dragButton.setImage(dragButtonImage, for: .normal)
        dragButton.isUserInteractionEnabled = true
        dragButton.backgroundColor = .green
        dragButton.adjustsImageWhenHighlighted = false
        
        dragButton.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(draggedView(_:))))
        
        return dragButton
    }()
    
    // MARK: - Life cycle
    
    init(
        dragButtonImage: UIImage,
        joystickImage: UIImage,
        tumblerWidth: CGFloat,
        output: JoystickViewOutput
    ) {
        self.dragButtonImage = dragButtonImage
        self.tumblerWidth = tumblerWidth
        self.output = output
        
        super.init(frame: .zero)

        configureView(joystickImage: joystickImage)
        configureSubviews(tumblerWidth: tumblerWidth)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Private

private extension JoystickView {
    
    func configureView(joystickImage: UIImage) {
        layer.cornerRadius = tumblerWidth
        setImage(joystickImage, for: .normal)
        adjustsImageWhenHighlighted = false
    }
    
    func configureSubviews(tumblerWidth: CGFloat) {
        addSubview(dragButton)
        
        dragButton.layer.cornerRadius = tumblerWidth / 2
        dragButton.translatesAutoresizingMaskIntoConstraints = false
        dragButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        dragButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        dragButton.widthAnchor.constraint(equalToConstant: tumblerWidth).isActive = true
        dragButton.heightAnchor.constraint(equalToConstant: tumblerWidth).isActive = true
    }
    
}

// MARK: - Private actions

private extension JoystickView {
    
    @objc func draggedView(_ sender: UIPanGestureRecognizer) {
        if sender.state == .ended {
            dragButton.center = CGPoint(
                x: bounds.origin.x + bounds.width / 2,
                y: bounds.origin.y + bounds.height / 2
            )
            output?.onJoystickViewDrop()
            return
        }
        
        let translation = sender.translation(in: self)
        let newXCoord = dragButton.center.x + translation.x
        let newYCoord = dragButton.center.y + translation.y
        if
            newXCoord < 0 ||
            newYCoord < 0 ||
            newXCoord > bounds.width ||
            newYCoord > bounds.height
        {
            return
        }
        dragButton.center = CGPoint(
            x: dragButton.center.x + translation.x,
            y: dragButton.center.y + translation.y
        )
        sender.setTranslation(CGPoint.zero, in: self)
        
        let procentX = dragButton.center.x * 100 / (bounds.width / 2) - 100
        let procentY = dragButton.center.y * 100 / (bounds.height / 2) - 100
        output?.onJoystickViewNewCoordinate(CGPoint(x: procentX, y: procentY))
    }
    
}
