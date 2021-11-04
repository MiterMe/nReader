//
//  NovelReaderDefaultMenuView.swift
//  nReader
//
//  Created by Miter on 2021/10/20.
//

import Foundation
import UIKit

public final class NovelReaderDefaultMenuView: NovelReaderMenuView {
    
    let topView: UIView = {
        let widget = UIView()
        widget.translatesAutoresizingMaskIntoConstraints = false
        widget.backgroundColor = .black.withAlphaComponent(0.9)
        NSLayoutConstraint.activate([
            widget.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.height * 0.1).rounded(.down))
        ])
        return widget
    }()
    
    let bottomView: UIView = {
        let widget = UIView()
        widget.translatesAutoresizingMaskIntoConstraints = false
        widget.backgroundColor = .black.withAlphaComponent(0.9)
        NSLayoutConstraint.activate([
            widget.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.height * 0.2).rounded(.down))
        ])
        return widget
    }()
    
    let exitBtn: UIButton = {
        let widget = UIButton()
        widget.translatesAutoresizingMaskIntoConstraints = false
        widget.setTitle("Exit", for: .normal)
        return widget
    }()
    
    
    @objc func exitBtnAction(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            self.removeFromSuperview()
        } completion: { _ in
            self.reader?.novelReaderExit(.user)
        }

    }
    
    public override func setupWidgetsAction() {
        super.setupWidgetsAction()
        
        exitBtn.addTarget(self, action: #selector(exitBtnAction(_:)), for: .touchUpInside)
    }
    
    public override func setupWidgetsLayout() {
        super.setupWidgetsLayout()
        
        self.backgroundColor = .black.withAlphaComponent(0.1)
        
        topView.addSubview(exitBtn)
        self.addSubview(topView)
        self.addSubview(bottomView)
        
        NSLayoutConstraint.activate([
            exitBtn.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            exitBtn.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 20),
            
            topView.topAnchor.constraint(equalTo: self.topAnchor),
            topView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            bottomView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bottomView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            
        ])
        
    }
}
