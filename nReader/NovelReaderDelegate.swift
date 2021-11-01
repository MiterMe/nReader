//
//  NovelReaderDelegate.swift
//  nReader
//
//  Created by Miter on 2021/10/19.
//

import Foundation

public protocol NovelReaderDelegate {
    
    /// 通知delegate对象 阅读器将要从progress进度打开
    func novelReader(_ reader: NovelReader, willOpenAt progress: ReadProgress)
    
    /// 通知delegate对象 阅读器从progress进度打开了
    func novelReader(_ reader: NovelReader, didOpenedAt progress: ReadProgress)
    
    /// 通知delegate对象 阅读器更新了阅读进度progress
    func novelReader(_ reader: NovelReader, updateProgress progress: ReadProgress)
    
    /// 通知delegate对象 阅读器将要从progress进度退出
    func novelReader(_ reader: NovelReader, willExitAt progress: ReadProgress, becauseOf type: ExitType)
    
    /// 通知delegate对象 阅读器从progress进度退出了
    func novelReader(_ reader: NovelReader, didExitedAt progress: ReadProgress, becauseOf type: ExitType)
}


public extension NovelReaderDelegate {
    
    func novelReader(_ reader: NovelReader, willOpenAt progress: ReadProgress) {
        
    }
    
    func novelReader(_ reader: NovelReader, didOpenedAt progress: ReadProgress){
        
    }
    
    func novelReader(_ reader: NovelReader, updateProgress progress: ReadProgress){
        
    }
    
    func novelReader(_ reader: NovelReader, willExitAt progress: ReadProgress, becauseOf type: ExitType){
        
    }
    
    func novelReader(_ reader: NovelReader, didExitedAt progress: ReadProgress, becauseOf type: ExitType){
        
    }
}

