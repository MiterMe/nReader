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
    
    let textView: UITextView = {
        let widget = UITextView()
        widget.translatesAutoresizingMaskIntoConstraints = false
        widget.isScrollEnabled = true
        widget.isEditable = false
        widget.isSelectable = false
        
        return widget
    }()
    
    var header: UIView? = nil
    var footer: UIView? = nil
    
    fileprivate func setupAppearance() {

    }
    
    fileprivate func setupWidgetAction() {

    }
    
    fileprivate func setupWidgetLayout() {
        guard let `reader` = reader else {return}
        
        textView.backgroundColor = reader.dataSource.colorSchema(for: reader).backColor
        textView.attributedText = text
        
        view.addSubview(textView)
        NSLayoutConstraint.activate([
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
        
        header = reader.dataSource.readerHeaders(in: reader)
        let headerHeight = reader.dataSource.readerHeadersHeight(in: reader)
        footer = reader.dataSource.readerFooters(in: reader)
        let footerHeight = reader.dataSource.readerFootersHeight(in: reader)
        
        if let h = header {
            h.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(h)
            NSLayoutConstraint.activate([
                h.heightAnchor.constraint(equalToConstant: headerHeight),
                h.topAnchor.constraint(equalTo: view.topAnchor),
                h.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                h.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                h.bottomAnchor.constraint(equalTo: textView.topAnchor),
                textView.topAnchor.constraint(equalTo: h.bottomAnchor),
            ])
        } else {
            NSLayoutConstraint.activate([
                textView.topAnchor.constraint(equalTo: view.topAnchor),
            ])
        }
        if let f = footer {
            f.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(f)
            NSLayoutConstraint.activate([
                f.heightAnchor.constraint(equalToConstant: footerHeight),
                textView.bottomAnchor.constraint(equalTo: f.topAnchor),
                f.topAnchor.constraint(equalTo: textView.bottomAnchor),
                f.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                f.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                f.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
        } else {
            NSLayoutConstraint.activate([
                textView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
        }
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
