//
//  NoverReaderIllustrationContrller.swift
//  nReader
//
//  Created by Miter on 2021/11/4.
//

import Foundation
import UIKit

open class NovelReaderIllustrationController: UIViewController {
    
    var customAnimation: CustomAnimationTransitioning
    
    
    @objc fileprivate func coverIllustrationSwapAction(_ sender: Any) {
        if let gesture = sender as? UISwipeGestureRecognizer {
            switch gesture.direction {
            case .left:
                customAnimation.direction = .left
            case .right:
                customAnimation.direction = .right
            case .up:
                customAnimation.direction = .up
            case .down:
                customAnimation.direction = .down
            default:
                customAnimation.direction = .left
            }
        }
        self.dismiss(animated: true)
    }
    
    fileprivate func setupWidgetsActions() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(coverIllustrationSwapAction(_:)))
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(coverIllustrationSwapAction(_:)))
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(coverIllustrationSwapAction(_:)))
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(coverIllustrationSwapAction(_:)))
        swipeLeft.direction = .left
        swipeRight.direction = .right
        swipeUp.direction = .up
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeLeft)
        view.addGestureRecognizer(swipeRight)
        view.addGestureRecognizer(swipeUp)
        view.addGestureRecognizer(swipeDown)
    }
    
    fileprivate func setupWidgetsLayout() {}
    
    open override func viewDidLoad() {
        super.viewDidLoad()
    
        setupWidgetsLayout()
        setupWidgetsActions()
    }
    
    public init() {
        customAnimation = CustomAnimationTransitioning()
        
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .custom
        transitioningDelegate = customAnimation
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        Swift.debugPrint("Debug: Deinit \(self)")
    }
}
