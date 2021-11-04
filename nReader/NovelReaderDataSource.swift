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
    
    /// 根据chapter index获取章节对象（异步），获取后调用callback
    func novelReader(_ reader: NovelReader, chapterForIndexAt index: Int, afterObtained callback: @escaping (Chapter)->Void)
    
    /// 根据chapter index以及向下、向上翻页的次数以及当前要展示的页来获取对应的插页（广告页）此方法不能阻塞，提前获取好广告素材
    func novelReaderIllustration(_ reader: NovelReader,
                                 chapterForIndexAt index: Int,  //章节index
                                 countOfPages pagesCount: Int,  //本章共多少页
                                 AtPageIndex pageIndex: Int,    //当前要展示第几页（以0开始）
                                 pageDownTimes: Int)            //目前向后翻页次数
                                 -> NovelReaderPageIllustration?
    
    /// 返回阅读器打开后显示的书面封皮页面
    func novelReaderCover(for reader: NovelReader) -> NovelReaderPageCover?
    
    /// 返回阅读器中banner广告位置
    func bannerPosition(for reader: NovelReader) -> BannerPosition
    
    /// 返回阅读器中banner广告高度
    func bannerHeight(for reader: NovelReader) -> CGFloat
    
    /// 返回阅读器中banner广告
    func bannerController(for reader: NovelReader) -> UIViewController?
    
    /// 返回阅读器页眉
    func readerHeaders(in reader: NovelReader, countOfPages pagesCount: Int, AtPageIndex pageIndex: Int, andChapterIndex chpaterIndex: Int) -> UIView?
    
    /// 返回阅读器页眉高度
    func readerHeadersHeight(in reader: NovelReader) -> CGFloat
    
    /// 返回阅读器页脚
    func readerFooters(in reader: NovelReader, countOfPages pagesCount: Int, AtPageIndex pageIndex: Int, andChapterIndex chpaterIndex: Int) -> UIView?
    
    /// 返回阅读器页脚高度
    func readerFootersHeight(in reader: NovelReader) -> CGFloat
    
    /// 返回阅读器翻页效果的类型
    func pageTurning(for reader: NovelReader) -> PageTurningType
    
    /// 返回阅读器翻页效果的类型
    func menuView(for reader: NovelReader) -> NovelReaderPopedView?
    
    /// 返回阅读器的配色
    func colorSchema(for reader: NovelReader) -> ColorSchema
    
    /// 返回阅读器的字体大小
    func fontSchema(for reader: NovelReader) -> UIFont

}

public extension NovelReaderDataSource {
    
    
    func novelReaderIllustration(_ reader: NovelReader,
                                 chapterForIndexAt index: Int,
                                 countOfPages pagesCount: Int,
                                 AtPageIndex pageIndex: Int,
                                 pageDownTimes: Int) -> NovelReaderPageIllustration? {
        
        return nil
        
    }
    
    func novelReaderCover(for reader: NovelReader) -> NovelReaderPageCover? {
        return nil
    }
    
    func bannerPosition(for reader: NovelReader) -> BannerPosition {
        return .none
    }
    
    func bannerHeight(for reader: NovelReader) -> CGFloat {
        return 0
    }
    
    func bannerController(for reader: NovelReader) -> UIViewController? {
        return nil
    }
    
    func readerHeaders(in reader: NovelReader, countOfPages pagesCount: Int, AtPageIndex pageIndex: Int, andChapterIndex chpaterIndex: Int) -> UIView? {
        return nil
    }
    
    func readerHeadersHeight(in reader: NovelReader) -> CGFloat {
        return 0
    }
    
    func readerFooters(in reader: NovelReader, countOfPages pagesCount: Int, AtPageIndex pageIndex: Int, andChapterIndex chpaterIndex: Int) -> UIView? {
        return nil
    }
    
    func readerFootersHeight(in reader: NovelReader) -> CGFloat {
        return 0
    }
    
    func pageTurning(for reader: NovelReader) -> PageTurningType {
        return .horizontalCurl
    }
    
    func menuView(for reader: NovelReader) -> NovelReaderPopedView? {
        return nil
    }
    
    func colorSchema(for reader: NovelReader) -> ColorSchema {
        return .defaultSchema
    }
    
    func fontSchema(for reader: NovelReader) -> UIFont {
        return .systemFont(ofSize: 20)
    }
    
}
