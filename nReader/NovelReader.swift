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
        navigationController?.isNavigationBarHidden = true
    }
    
    @objc fileprivate func pressBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func setupWidgetAction() {
        btn.addTarget(self, action: #selector(pressBtn(_:)), for: .touchUpInside)
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
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        Swift.debugPrint("Debug: Deinit \(self)")
    }
    
}
