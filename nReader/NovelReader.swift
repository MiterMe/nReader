//
//  NovelReader.swift
//  nReader
//
//  Created by Miter on 2021/10/19.
//

import UIKit

public final class NovelReader: UIViewController {
    
    let btn: UIButton = {
        let widget = UIButton()
        widget.translatesAutoresizingMaskIntoConstraints = false
        widget.setTitle("Test", for: .normal)
        return widget
    }()

    fileprivate func setupAppearance() {
        view.backgroundColor = .systemRed
        modalPresentationStyle = .overFullScreen
        navigationController?.isNavigationBarHidden = true
    }
    
    fileprivate func setupWidgetAction() {
        
    }
    
    fileprivate func setupWidgetLayout() {
        view.addSubview(btn)
        NSLayoutConstraint.activate([
            btn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btn.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        setupWidgetLayout()
        setupWidgetAction()
    }
    
    deinit {
        Swift.debugPrint("Debug: Deinit \(self)")
    }
    
}
