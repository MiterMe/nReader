//
//  NovelReaderPageContent.swift
//  nReader
//
//  Created by Miter on 2021/10/22.
//

import UIKit

public final class NovelReaderPageContent: NovelReaderPage {

    let range: NSRange
    let text: NSAttributedString
    
    fileprivate func setupAppearance() {

    }
    
    fileprivate func setupWidgetAction() {

    }
    
    fileprivate func setupWidgetLayout() {
        
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        setupWidgetLayout()
        setupWidgetAction()
    }
    
    public init(reader: NovelReader, range: NSRange, text: NSAttributedString, afterAppear: NovelReaderPage.AfterAppearCall? = nil) {
        self.range = range
        self.text = text
        super.init(reader: reader, afterAppear: afterAppear)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
