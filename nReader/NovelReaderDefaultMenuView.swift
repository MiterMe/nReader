//
//  NovelReaderDefaultMenuView.swift
//  nReader
//
//  Created by Miter on 2021/10/20.
//

import Foundation
import UIKit

public final class NovelReaderDefaultMenuView: NovelReaderPopedView {
    
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
    
    let reloadBtn: UIButton = {
        let widget = UIButton()
        widget.translatesAutoresizingMaskIntoConstraints = false
        widget.setTitle("reload reader", for: .normal)
        widget.backgroundColor = .systemRed
        return widget
    }()
    
    @objc func reloadBtnAction(_ sender: Any) {
        reader?.reloadReader()
    }
    
    
    let catelogBtn: UIButton = {
        let widget = UIButton()
        widget.translatesAutoresizingMaskIntoConstraints = false
        widget.setTitle("open catelog", for: .normal)
        widget.backgroundColor = .systemBlue
        return widget
    }()
    
    @objc func catelogBtnAction(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            self.removeFromSuperview()
        } completion: { _ in
            self.reader?.openPopedView(NovelReaderDefaultCatelogView(self.reader!))
        }
    }
    
    public override func setupWidgetsAction() {
        super.setupWidgetsAction()
        
        exitBtn.addTarget(self, action: #selector(exitBtnAction(_:)), for: .touchUpInside)
        reloadBtn.addTarget(self, action: #selector(reloadBtnAction(_:)), for: .touchUpInside)
        catelogBtn.addTarget(self, action: #selector(catelogBtnAction(_:)), for: .touchUpInside)
    }
    
    public override func setupWidgetsLayout() {
        super.setupWidgetsLayout()
        
        self.backgroundColor = .black.withAlphaComponent(0.1)
        
        let bstack: UIStackView = {
            let widget = UIStackView()
            widget.translatesAutoresizingMaskIntoConstraints = false
            widget.axis = .horizontal
            widget.distribution = .equalSpacing
            widget.alignment = .fill
            widget.spacing = 50
            return widget
        }()
        
        bstack.addArrangedSubview(catelogBtn)
        bstack.addArrangedSubview(reloadBtn)
        
        topView.addSubview(exitBtn)
        bottomView.addSubview(bstack)
        self.addSubview(topView)
        self.addSubview(bottomView)
        
        NSLayoutConstraint.activate([
            exitBtn.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            exitBtn.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 20),
            
            bstack.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
            bstack.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            
            topView.topAnchor.constraint(equalTo: self.topAnchor),
            topView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            bottomView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bottomView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            
        ])
        
    }
}
