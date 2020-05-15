//
//  Models.swift
//  stateMachine
//
//  Created by Jie liang Huang on 2020/5/15.
//  Copyright © 2020 com.jie.stateMachine. All rights reserved.
//

import Foundation

struct Models<T: Codable>: Codable {
    let results: T
}

struct Info: Codable {
    var email: String?
    var gender: String?
}

