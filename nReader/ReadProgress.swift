//
//  ReadProgress.swift
//  nReader
//
//  Created by Miter on 2021/10/20.
//

import Foundation

public struct ReadProgress {
    public var index: Int
    public var word: Int
    
    public init() {
        self.index = 0
        self.word = 0
    }
    
    public init(index: Int, word: Int) {
        self.index = index
        self.word = word
    }
}

extension ReadProgress {
    public static var head: ReadProgress {
        get {
            ReadProgress()
        }
    }
}
