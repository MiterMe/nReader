//
//  NovelReaderPage.swift
//  nReader
//
//  Created by Miter on 2021/10/22.
//

import UIKit

enum NovelReaderType {
    case loading
    case content
    case illustration
    case cover
    case base
}

open class NovelReaderPage: UIViewController {
    
    internal var pageType: NovelReaderType {
        .base
    }

    public typealias AfterAppearCall = (NovelReaderPage) -> Void
    
    weak var reader: NovelReader?
    
    var afterAppear: AfterAppearCall?
    
    fileprivate func setupAppearance() {
        if let `reader` = reader {
            view.backgroundColor = reader.dataSource.colorSchema(for: reader).backColor
        }
    }
    
    fileprivate func setupWidgetAction() {
        view.isUserInteractionEnabled = false
    }
    
    fileprivate func setupWidgetLayout() {
        
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        setupWidgetLayout()
        setupWidgetAction()
    }
    
    public init(reader: NovelReader, afterAppear: AfterAppearCall? = nil) {
        self.reader = reader
        self.afterAppear = afterAppear
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        Swift.debugPrint("Debug: Deinit \(self)")
    }
    
}
