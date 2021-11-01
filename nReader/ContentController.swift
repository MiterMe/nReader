//
//  ContentController.swift
//  nReader
//
//  Created by Miter on 2021/10/20.
//

import Foundation
import UIKit

internal final class ContentController: UIPageViewController {
    
    weak var reader: NovelReader?
    
    var realSafeAreaInsets: UIEdgeInsets? = nil

    var pages = [NovelReaderPage]()
    var novelString: NSMutableAttributedString = NSMutableAttributedString()

    var pagesCount: Int {
        pages.count
    }
    var pageIndex: Int {
        if let cv = viewControllers?.first as? NovelReaderPage {
            return pages.firstIndex(of: cv) ?? 0
        } else {
            return 0
        }
    }
    
    fileprivate func setupAppearance() {

    }

    fileprivate func setupWidgetAction() {

    }

    fileprivate func setupWidgetLayout() {

    }

    fileprivate func formatContent(_ str: String) -> String {
        var paragraphArray = [String]()
        str.enumerateLines { s , _ in
            paragraphArray.append(s)
        }

        var newParagraphString: String = ""
        for (index, paragraph) in paragraphArray.enumerated() {
            let string0 = paragraph.replacingOccurrences(of: " ", with: "")
            let string1 = string0.replacingOccurrences(of: "\t", with: "")
            var newParagraph = string1.trimmingCharacters(in: .whitespacesAndNewlines)

            if newParagraph.count != 0 {
                newParagraph = "\t" + newParagraph
                if index != paragraphArray.count - 1 {
                    newParagraph = newParagraph + "\n"
                }
                newParagraphString.append(String(newParagraph))
            }
        }
        return newParagraphString
    }

    fileprivate func washNovelContent(title: String, content: String) -> NSMutableAttributedString {

        let nTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        let nContent = formatContent(content)

        let aString = NSMutableAttributedString()

        guard let `reader` = reader else {return aString}
        let fcolor = reader.dataSource.colorSchema(for:reader).fontColor
        let font = reader.dataSource.fontSchema(for: reader)

        var attributesContent = [NSAttributedString.Key: Any]()
        attributesContent[.foregroundColor] = fcolor
        attributesContent[.font] = font

        let hao = NSString("好")
        let haoSize = hao.size(withAttributes: attributesContent)
        let haoHeight = haoSize.height.rounded(.down)

        let pstyleContent = NSMutableParagraphStyle()
        pstyleContent.alignment = NSTextAlignment.natural
        pstyleContent.minimumLineHeight = haoHeight*1.8
        attributesContent[.paragraphStyle] = pstyleContent

        var attributesTitle = [NSAttributedString.Key: Any]()
        attributesTitle[.foregroundColor] = fcolor
        attributesTitle[.font] = font
        let pstyleTitle = NSMutableParagraphStyle()
        pstyleTitle.alignment = NSTextAlignment.center
        pstyleTitle.lineHeightMultiple = 2
        attributesTitle[.paragraphStyle] = pstyleTitle

        let attrTitle = NSAttributedString(string: nTitle + "\n", attributes: attributesTitle)
        let attrContent = NSAttributedString(string: nContent, attributes: attributesContent)

        aString.append(attrTitle)
        aString.append(attrContent)

        return aString
    }
    
    fileprivate func renderTextView(chapter: Chapter) -> ([NSRange], [NSAttributedString]) {

        var ranges: [NSRange] = [NSRange]()
        var texts: [NSAttributedString] = [NSAttributedString]()

        guard let `reader` = reader else {return (ranges,texts)}

        let aString = washNovelContent(title: chapter.title, content: chapter.content)

        let textStorage = NSTextStorage(attributedString: aString)
        let layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)
        var conainers = [NSTextContainer]()

        let textAreaSizeWidth = UIScreen.main.bounds.width - 40
        var textAreaSizeHeight = UIScreen.main.bounds.height
        let usedAreaInsets: UIEdgeInsets = realSafeAreaInsets ?? .zero
        switch reader.dataSource.bannerPosition(for: reader) {
        case .top:
            textAreaSizeHeight -= max(reader.dataSource.bannerHeight(for: reader), usedAreaInsets.top)
            textAreaSizeHeight -= usedAreaInsets.bottom
        case .bottom:
            textAreaSizeHeight -= usedAreaInsets.top
            textAreaSizeHeight -= max(reader.dataSource.bannerHeight(for: reader), usedAreaInsets.bottom)
        case .none:
            textAreaSizeHeight -= usedAreaInsets.top
            textAreaSizeHeight -= usedAreaInsets.bottom
            break
        }
        textAreaSizeHeight -= reader.dataSource.readerHeadersHeight(in: reader)
        textAreaSizeHeight -= reader.dataSource.readerFootersHeight(in: reader)
        textAreaSizeHeight -= 10

        let textAreaSize = CGSize(width: textAreaSizeWidth, height: textAreaSizeHeight)

        while true {
            let textContainer = NSTextContainer(size: textAreaSize)
            layoutManager.addTextContainer(textContainer)

            let range = layoutManager.glyphRange(for: textContainer)
            conainers.append(textContainer)
            ranges.append(range)
            texts.append(aString.attributedSubstring(from: range))


            if range.lowerBound + range.length >= textStorage.length {
                break
            }
        }

        return (ranges, texts)
    }
    
    fileprivate func makeReaderPages() {
        guard let `reader` = reader else {return}
        if reader.currentProgress.index < 0 || reader.currentProgress.index >= reader.dataSource.numberOfChapters(in: reader) {
            fatalError("out of number of chapters!")
        }
        reader.dataSource.novelReader(reader, chapterForIndexAt: reader.currentProgress.index) { [weak self] chapter in
            if let result = self?.renderTextView(chapter: chapter) {
                zip(result.0, result.1).forEach { r, t in
                    self?.novelString.append(t)
                    self?.pages.append(NovelReaderPageContent(reader: reader, range: r, text: t) { _ in
                        let progress = ReadProgress(index: self?.reader?.currentProgress.index ?? 0, word: r.upperBound)
                        self?.reader?.delegate?.novelReader((self?.reader)!, updateProgress: progress)
                    })
                }
                if let page = self?.pages.first {
                    self?.setViewControllers([page], direction: .forward, animated: false, completion: nil)
                }
            }
        }
    }
    
    fileprivate func setupContent() {
        guard let `reader` = reader else {return}
        setViewControllers([NovelReaderPageLoading(reader: reader)], direction: .forward, animated: false) { _ in
            self.makeReaderPages()
        }
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        if realSafeAreaInsets == nil {
            realSafeAreaInsets = view.safeAreaInsets
            setupContent()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        setupWidgetLayout()
        setupWidgetAction()
        
    }
    
    init(reader: NovelReader, transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        self.reader = reader
        super.init(transitionStyle: style, navigationOrientation: navigationOrientation, options: options)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
