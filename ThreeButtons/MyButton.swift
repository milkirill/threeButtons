//
//  MyButton.swift
//  ThreeButtons
//
//  Created by Kirill Milekhin on 06/09/2023.
//

import UIKit

class MyButton: UIButton {

    let scaleFactor: CGFloat = 0.8
    let animationDuration: TimeInterval = 0.3
    var downscaleAnimator: UIViewPropertyAnimator?
    var upscaleAnimator: UIViewPropertyAnimator?
    var isDisabledByPresentingModally = false

    convenience init(with title: String) {
        var configuration = UIButton.Configuration.filled()
        
        configuration.title = title
        configuration.image = UIImage(systemName: "arrowshape.turn.up.right.circle.fill")
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 8
        configuration.contentInsets = .init(top: 10, leading: 14, bottom: 10, trailing: 14)

        var background = UIBackgroundConfiguration.clear()
        background.backgroundColor = .systemBlue
        background.cornerRadius = 12
        configuration.background = background

        self.init(configuration: configuration)

        configurationUpdateHandler = { button in
            switch button.state {
            case .normal:
                button.configuration?.background.backgroundColor = .systemBlue
                button.configuration?.baseForegroundColor = .white
            case .disabled:
                button.configuration?.background.backgroundColor = .systemGray2
                button.configuration?.baseForegroundColor = .systemGray3
            default:
                break
            }
        }
    }

    override func tintColorDidChange() {
        super.tintColorDidChange()
        isDisabledByPresentingModally.toggle()
        isEnabled = !isDisabledByPresentingModally
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        upscaleAnimator?.stopAnimation(true)
        downscaleAnimator?.stopAnimation(true)

        downscaleAnimator = UIViewPropertyAnimator(duration: animationDuration, curve: .linear) { [weak self] in
            guard let self else { return }
            self.transform = .init(scaleX: scaleFactor, y: scaleFactor)
        }

        downscaleAnimator?.startAnimation()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)

        downscaleAnimator?.stopAnimation(true)
        downscaleAnimator?.finishAnimation(at: .current)

        upscaleAnimator = UIViewPropertyAnimator(duration: animationDuration, curve: .linear) { [weak self] in
            self?.transform = .identity
        }

        upscaleAnimator?.startAnimation()
    }
}
