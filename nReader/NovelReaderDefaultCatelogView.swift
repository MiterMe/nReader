//
//  NovelReaderDefaultCatelogView.swift
//  nReader
//
//  Created by Miter on 2021/11/4.
//


import Foundation
import UIKit

public final class NovelReaderDefaultCatelogView: NovelReaderPopedView {
    
    let leftView: UIView = {
        let widget = UIView()
        widget.translatesAutoresizingMaskIntoConstraints = false
        widget.backgroundColor = .black.withAlphaComponent(0.9)
        return widget
    }()
    
    let reloadBtn: UIButton = {
        let widget = UIButton()
        widget.translatesAutoresizingMaskIntoConstraints = false
        widget.setTitle("reload reader", for: .normal)
        return widget
    }()
    
    @objc func reloadBtnAction(_ sender: Any) {
        reader?.reloadReader()
    }
    
    public override func setupWidgetsAction() {
        super.setupWidgetsAction()
        
        
        reloadBtn.addTarget(self, action: #selector(reloadBtnAction(_:)), for: .touchUpInside)
    }
    
    public override func setupWidgetsLayout() {
        super.setupWidgetsLayout()
        
        self.backgroundColor = .black.withAlphaComponent(0.1)
        
        
        leftView.addSubview(reloadBtn)
        self.addSubview(leftView)
        
        NSLayoutConstraint.activate([
            
            reloadBtn.centerXAnchor.constraint(equalTo: leftView.centerXAnchor),
            reloadBtn.centerYAnchor.constraint(equalTo: leftView.centerYAnchor),
            
            leftView.topAnchor.constraint(equalTo: self.topAnchor),
            leftView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            leftView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            leftView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -80),

        ])
        
    }
}
