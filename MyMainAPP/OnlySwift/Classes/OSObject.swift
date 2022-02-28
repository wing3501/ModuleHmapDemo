//
//  OSObject.swift
//  OnlySwift
//
//  Created by styf on 2022/1/21.
//

import Foundation
import MyPodD

@objc public class OSObject:NSObject {
    func run(_ a:Int) {
        let v = MyPodDView()//swfit库中引用oc库
        print("OSObject \(a) run")
    }
}
