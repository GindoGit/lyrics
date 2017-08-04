//
//  Datas.swift
//  lyrics
//
//  Created by 유병재 on 2017. 8. 4..
//  Copyright © 2017년 유병재. All rights reserved.
//

import Foundation

struct LyricsListData {
    var title       : String = ""
    var time        : String = ""
    var typeArr     : [LyricsData]
    var lyricsArr   : [LyricsData]
}

extension LyricsListData : Equatable {
    public static func == (lhs: LyricsListData, rhs: LyricsListData) -> Bool {
        return (lhs.title == rhs.title)
    }
}

struct LyricsData {
    var type    : String = ""
    var lyrics  : String = ""
}
