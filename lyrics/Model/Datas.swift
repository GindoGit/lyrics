//
//  Datas.swift
//  lyrics
//
//  Created by 유병재 on 2017. 8. 4..
//  Copyright © 2017년 유병재. All rights reserved.
//

import Foundation
import Gloss

struct LyricsListData {
    var title       : String = ""
    var time        : String = ""
    var typeArr     : [LyricsData]
    var lyricsArr   : [LyricsData]
    var id          : String = ""
}

extension LyricsListData : Decodable {
    init?(json: JSON) {
        self.title = ("title" <~~ json) ?? ""
        self.time = ("edit_date" <~~ json) ?? ""
        self.id = ("_id" <~~ json) ?? ""
        self.lyricsArr = ("lyrics" <~~ json) ?? []
        self.typeArr = ("patterns" <~~ json) ?? []
    }
}

extension LyricsListData : Equatable {
    public static func == (lhs: LyricsListData, rhs: LyricsListData) -> Bool {
        return (lhs.title == rhs.title)
    }
}

struct LyricsData {
    var type    : String = ""
    var lyrics  : String = ""
    var id      : String = ""
}

extension LyricsData : Decodable {
    init?(json: JSON) {
        self.type = ("type" <~~ json) ?? ""
        self.id = ("_id" <~~ json) ?? ""
        self.lyrics = ("text" <~~ json) ?? ""
    }
}
