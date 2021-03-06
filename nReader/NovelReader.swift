//
//  NovelReader.swift
//  nReader
//
//  Created by Miter on 2021/10/19.
//

import UIKit

public final class NovelReader: UIViewController, UIGestureRecognizerDelegate {
    
    public var dataSource: NovelReaderDataSource
    public var delegate: NovelReaderDelegate?
    public var currentProgress: ReadProgress
    
    var contentController: ContentController?
    var bannerController: UIViewController?
    
    var turnPageTimesNxt: Int = 0

    public override var prefersStatusBarHidden: Bool {
        return true
    }
    
    fileprivate func setupAppearance() {
        view.backgroundColor = dataSource.colorSchema(for: self).backColor
        navigationController?.isNavigationBarHidden = true
    }
    
    fileprivate func setupWidgetAction() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction(_:)))
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
    
    fileprivate func uninstallContentController() {
        if let cc = contentController {
            cc.removeFromParent()
            cc.view.removeFromSuperview()
        }
        contentController = nil
    }
    
    fileprivate func uninstallBannerController() {
        if let bc = bannerController {
            bc.removeFromParent()
            bc.view.removeFromSuperview()
        }
        bannerController = nil
    }
    
    fileprivate func setupWidgetLayout() {
        contentController = makeContentController()
        bannerController = dataSource.bannerController(for: self)
        
        guard let cc = contentController else { fatalError() }
        
        cc.view.translatesAutoresizingMaskIntoConstraints = false
        self.addChild(cc)
        view.insertSubview(cc.view, at: 0)
        
        if let bc = bannerController {
            bc.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                bc.view.heightAnchor.constraint(equalToConstant: dataSource.bannerHeight(for: self))
            ])
            self.addChild(bc)
            view.insertSubview(bc.view, at: 1)
            
            switch dataSource.bannerPosition(for: self) {
            case .top:
                NSLayoutConstraint.activate([
                    bc.view.topAnchor.constraint(equalTo: view.topAnchor),
                    bc.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    bc.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    cc.view.topAnchor.constraint(equalTo: bc.view.bottomAnchor),
                    cc.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    cc.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    cc.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                ])
            case .bottom, .none:
                NSLayoutConstraint.activate([
                    cc.view.topAnchor.constraint(equalTo: view.topAnchor),
                    cc.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    cc.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    cc.view.bottomAnchor.constraint(equalTo: bc.view.topAnchor),
                    bc.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    bc.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                    bc.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                ])
            }
        } else {
            NSLayoutConstraint.activate([
                cc.view.topAnchor.constraint(equalTo: view.topAnchor),
                cc.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                cc.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                cc.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
        }
    }
    
    fileprivate func makeContentController() -> ContentController {
        
        let controller: ContentController
        
        switch dataSource.pageTurning(for: self) {
        case .horizontalCurl:
            controller = ContentController(reader: self, transitionStyle: .pageCurl, navigationOrientation: .horizontal, options: nil)
        case .horizontalScroll:
            controller = ContentController(reader: self, transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        case .verticalCurl:
            controller = ContentController(reader: self, transitionStyle: .pageCurl, navigationOrientation: .vertical, options: nil)
        case .verticalScroll:
            controller = ContentController(reader: self, transitionStyle: .scroll, navigationOrientation: .vertical, options: nil)
        }
        
        return controller
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        setupWidgetLayout()
        setupWidgetAction()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.delegate?.novelReader(self, willOpenAt: currentProgress)
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.delegate?.novelReader(self, didOpenedAt: currentProgress)
        if let poped = dataSource.novelReaderPopedIllustration(self) {
            present(poped, animated: true)
        }
    }
    
    public init(dataSource: NovelReaderDataSource, delegate: NovelReaderDelegate? = nil, from: ReadProgress = .head) {
        self.dataSource = dataSource
        self.delegate = delegate
        self.currentProgress = from
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .fullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        Swift.debugPrint("Debug: Deinit \(self)")
    }
    
    @objc fileprivate func tapAction(_ sender: Any) {
        openPopedView(self.dataSource.menuView(for: self))
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let touchClass = NSStringFromClass((touch.view?.classForCoder)!)
        if let v = touch.view {
            Swift.debugPrint("Debug: Reader ??????????????????: <\(touchClass) : \(String(format: "%p", v))>")
        }
        
        if touch.view == view {
            return true
        }
        
        if touchClass.contains("UIPageViewControllerContentView") {
            return true
        }
        return false
    }
    
// MARK: - ?????????????????????
    
    public func openPopedView(_ popView: NovelReaderPopedView?) {
        UIView.animate(withDuration: 0.5) {
            if let mv = popView {
                self.view.addSubview(mv)
                NSLayoutConstraint.activate([
                    mv.topAnchor.constraint(equalTo: self.view.topAnchor),
                    mv.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                    mv.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                    mv.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                ])
            }
        }
        
    }
    
    public func novelReaderExit(_ exitType: ExitType) {
        delegate?.novelReader(self, willExitAt: currentProgress, becauseOf: exitType)
     
        uninstallContentController()
        uninstallBannerController()
        
        self.dismiss(animated: true) {
            self.delegate?.novelReader(self, didExitedAt: self.currentProgress, becauseOf: exitType)
        }
    }
    
    public func reloadReader() {
        uninstallContentController()
        uninstallBannerController()
        setupWidgetLayout()
    }
}
