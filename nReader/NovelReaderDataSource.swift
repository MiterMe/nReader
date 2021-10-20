//
//  NovelReaderDataSource.swift
//  nReader
//
//  Created by Miter on 2021/10/19.
//

import Foundation
public protocol NovelReaderDataSource {
    
    /// 返回总章节数
    func numberOfChapters(in: NovelReader) -> Int
    
    /// 根据index返回章节对象
    func novelReader(_: NovelReader, chapterForIndexAt: Int) -> Chapter
    
    

}
