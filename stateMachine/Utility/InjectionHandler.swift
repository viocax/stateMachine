//
//  InjectionHandler.swift
//  stateMachine
//
//  Created by Jie liang Huang on 2020/5/15.
//  Copyright © 2020 com.jie.stateMachine. All rights reserved.
//

import Foundation

protocol InjectionHandler {
    associatedtype Object
    func inject(object: Object)
}
