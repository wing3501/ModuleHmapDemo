//
//  File.swift
//  OCSwift
//
//  Created by styf on 2022/1/21.
//

import Foundation

public class OCSPerson:NSObject {
   @objc public func run(_ a: Int) {
        //混编库中 swift调用OC
        let v = OCSView()
        print("OCSPerson \(a)  run")
    }
}
