//
//  NovelReaderDataSource.swift
//  nReader
//
//  Created by Miter on 2021/10/19.
//

import Foundation
import UIKit

public protocol NovelReaderDataSource {
    
    /// 返回总章节数
    func numberOfChapters(in reader: NovelReader) -> Int
    
    /// 根据index获取章节对象（异步），获取后调用callback
    func novelReader(_ reader: NovelReader, chapterForIndexAt index: Int, afterObtained callback: @escaping (Chapter)->Void)
    
    /// 根据index获取对应的插页（广告页）（异步），获取后调用callback
    func novelReaderIllustration(_ reader: NovelReader, chapterForIndexAt index: Int, afterObtained callback: @escaping ([NovelReaderPage]?)->Void)
    
    /// 返回阅读器中banner广告位置
    func bannerPosition(for reader: NovelReader) -> BannerPosition
    
    /// 返回阅读器中banner广告高度
    func bannerHeight(for reader: NovelReader) -> CGFloat
    
    /// 返回阅读器中banner广告
    func bannerController(for reader: NovelReader) -> BannerController?
    
    /// 返回阅读器页眉
    func readerHeaders(in reader: NovelReader) -> UIView?
    
    /// 返回阅读器页眉高度
    func readerHeadersHeight(in reader: NovelReader) -> CGFloat
    
    /// 返回阅读器页脚
    func readerFooters(in reader: NovelReader) -> UIView?
    
    /// 返回阅读器页脚高度
    func readerFootersHeight(in reader: NovelReader) -> CGFloat
    
    /// 返回阅读器翻页效果的类型
    func pageTurning(for reader: NovelReader) -> PageTurningType
    
    /// 返回阅读器翻页效果的类型
    func menuView(for reader: NovelReader) -> NovelReaderMenuView?
    
    /// 返回阅读器的配色
    func colorSchema(for reader: NovelReader) -> ColorSchema
    
    /// 返回阅读器的字体大小
    func fontSchema(for reader: NovelReader) -> UIFont

}

public extension NovelReaderDataSource {
    
    
    func novelReaderIllustration(_ reader: NovelReader, chapterForIndexAt index: Int, afterObtained callback: @escaping ([NovelReaderPage]?)->Void) {
        callback(nil)
    }
    
    func bannerPosition(for reader: NovelReader) -> BannerPosition {
        return .none
    }
    
    func bannerHeight(for reader: NovelReader) -> CGFloat {
        return 0
    }
    
    func bannerController(for reader: NovelReader) -> BannerController? {
        return nil
    }
    
    func readerHeaders(in reader: NovelReader) -> UIView? {
        return nil
    }
    
    func readerHeadersHeight(in reader: NovelReader) -> CGFloat {
        return 0
    }
    
    func readerFooters(in reader: NovelReader) -> UIView? {
        return nil
    }
    
    func readerFootersHeight(in reader: NovelReader) -> CGFloat {
        return 0
    }
    
    func pageTurning(for reader: NovelReader) -> PageTurningType {
        return .horizontalCurl
    }
    
    func menuView(for reader: NovelReader) -> NovelReaderMenuView? {
        return nil
    }
    
    func colorSchema(for reader: NovelReader) -> ColorSchema {
        return .defaultSchema
    }
    
    func fontSchema(for reader: NovelReader) -> UIFont {
        return .systemFont(ofSize: 20)
    }
    
}
