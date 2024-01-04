//
//  NetworkPrinter.swift
//  CollectionsDemo
//
//  Created by 陳鈺翎 on 2024/1/3.
//

import Foundation
import Moya
import SwiftyJSON

struct NetworkPrinter {
    static func printRequestInfo(
        T1: Date,
        target: MultiTarget
    ) {
        print("""
        ---------------- MoyaNetworking Request ----------------
        StartTime : \(T1)
        Method :\(target.method.rawValue)
        Par : \(target.task)
        component : \(target.path)
        ---------------- MoyaNetworking Request ----------------
        """)
    }

    static func printResponseInfo(
        T1: Date,
        T4: Date,
        target: MultiTarget,
        response: Response
    ) {
        let executionTime = T4.timeIntervalSince(T1)
        print("""
        ---------------- MoyaNetworking Response----------------
        Method :\(target.method.rawValue)
        component : \(target.path)
        EndTime: \(T4)
        Delay : \(executionTime) Sec
        """)

        let data = response.data
        do {
            let json = try JSON(data: data)
            print("NetWork Response =  \(json)")
        } catch {
            print("NetWork Response = Data can not be parsed \(error.localizedDescription)")
        }

        print("---------------- MoyaNetworking Response----------------")
    }
}


