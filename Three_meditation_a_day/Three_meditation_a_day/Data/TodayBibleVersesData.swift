//
//  TodayBibleVersesData.swift
//  Three_meditation_a_day
//
//  Created by 박길남 on 11/10/2018.
//  Copyright © 2018 ParkGilNam. All rights reserved.
//

import Foundation

struct TodayBibleVersesData:Decodable {
    let _id:String
    let year:Int
    let month:Int
    let day:Int
    let bibleverses:String
}
