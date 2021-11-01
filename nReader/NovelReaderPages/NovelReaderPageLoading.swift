//
//  NovelReaderPageLoading.swift
//  nReader
//
//  Created by Miter on 2021/10/22.
//

import Foundation
import UIKit

public final class NovelReaderPageLoading: NovelReaderPage {
    
    lazy var indicator: UIActivityIndicatorView = {
        let widget = UIActivityIndicatorView()
        widget.translatesAutoresizingMaskIntoConstraints = false
        widget.hidesWhenStopped = true
        widget.style = .large
        widget.color = reader?.dataSource.colorSchema(for: reader!).fontColor
        return widget
    }()
    
    fileprivate func setupAppearance() {

    }
    
    fileprivate func setupWidgetAction() {

    }
    
    fileprivate func setupWidgetLayout() {
        indicator.startAnimating()
        view.addSubview(indicator)
        
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        setupWidgetLayout()
        setupWidgetAction()
    }
}
