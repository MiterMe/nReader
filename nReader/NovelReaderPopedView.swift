//
//  NovelReaderMenuView.swift
//  nReader
//
//  Created by Miter on 2021/10/20.
//

import Foundation
import UIKit

open class NovelReaderPopedView: UIView {
    
    weak var reader: NovelReader?
    
    @objc fileprivate func tapAction(_ sender: Any) {
        UIView.animate(withDuration: 0.5, animations: {
            self.removeFromSuperview()
        }, completion: nil)
    }
    
    public func setupWidgetsAction() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction(_:)))
        tap.delegate = self
        self.addGestureRecognizer(tap)
    }
    
    public func setupWidgetsLayout() {
        
    }
    
    public init(_ reader: NovelReader) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isUserInteractionEnabled = true
        self.backgroundColor = .clear
        self.reader = reader
        
        setupWidgetsLayout()
        setupWidgetsAction()
        
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NovelReaderPopedView: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if self == touch.view {
            return true
        } else {
            return false
        }
    }
}
