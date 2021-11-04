//
//  NoverReaderIllustrationContrller.swift
//  nReader
//
//  Created by Miter on 2021/11/4.
//

import Foundation
import UIKit

open class NovelReaderIllustrationController: UIViewController {
    
    
    @objc fileprivate func coverIllustrationSwapAction(_ sender: Any) {
        self.dismiss(animated: true) {
            
        }
    }
    
    fileprivate func setupWidgetsActions() {
        let swap = UISwipeGestureRecognizer(target: self, action: #selector(coverIllustrationSwapAction(_:)))
        swap.direction = .left
        view.addGestureRecognizer(swap)
    }
    
    fileprivate func setupWidgetsLayout() {}
    
    open override func viewDidLoad() {
        super.viewDidLoad()
    
        let transitionDelegate = CustomAnimationTransitioning()
        modalPresentationStyle = .custom
        transitioningDelegate = transitionDelegate
        
        setupWidgetsLayout()
        setupWidgetsActions()
    }
}
