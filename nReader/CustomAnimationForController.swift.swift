//
//  CustomAnimationForController.swift.swift
//  nReader
//
//  Created by Miter on 2021/11/4.
//

import Foundation
import UIKit

public final class ModalOpenAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let toViewController = transitionContext.viewController(forKey: .to)
        let containerView = transitionContext.containerView

        guard  let toView = toViewController?.view else { return }
                        
        containerView.addSubview(toView)
        toView.frame = transitionContext.finalFrame(for: toViewController!)
        transitionContext.completeTransition(true)
    }
    
}

public final class ModalCloseAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewController(forKey: .from)
        let containerView = transitionContext.containerView
    
        guard let fromView = fromViewController?.view else { return }
        
        
        // iOS8引入了viewForKey方法，尽可能使用这个方法而不是直接访问controller的view属性
        // 比如在form sheet样式中，我们为presentedViewController的view添加阴影或其他decoration，animator会对整个decoration view
        // 添加动画效果，而此时presentedViewController的view只是decoration view的一个子视图
        // fromView = transitionContext.view(forKey: .from)
        // toView = transitionContext.view(forKey: .to)

        let transitionDuration = self.transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: transitionDuration) {
            fromView.frame = CGRect(x: 0 - fromView.frame.width, y: fromView.frame.origin.y, width: fromView.frame.width, height: fromView.frame.height)
            
        } completion: { finished in
            if let v = containerView.subviews.first(where: { $0 == fromView }) {
                v.removeFromSuperview()
            }
            let wasCancelled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!wasCancelled)
        }
    }
}

public final class CustomAnimationTransitioning: NSObject, UIViewControllerTransitioningDelegate {
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ModalOpenAnimator()
    }
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ModalCloseAnimator()
    }
}
