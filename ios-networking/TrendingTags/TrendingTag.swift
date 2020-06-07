//
//  TrendingTag.swift
//  Runner
//
//  Created by Pratik on 21/05/20.
//  Copyright © 2020 The Chromium Authors. All rights reserved.
//

import Foundation

public struct TrendingTag {
    
    public let tagId: Int
    public let tagName: String
    
    public init(tagId: Int, tagName: String) {
        self.tagId = tagId
        self.tagName = tagName
    }
}
