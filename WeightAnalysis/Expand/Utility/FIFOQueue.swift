//
//  FIFOQueue.swift
//  WeightAnalysis
//
//  Created by 赛峰 施 on 2016/11/21.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

import Foundation
/**
 ## Overview
 This struct queue is customized,and it represnets a queue which first in and first out,it adopt collection protocol,so it owns map,reduce,filter methods and so on.It adopts ExpressibleByArrayLiteral protocol,so it owns expressibleByArrayLiteral initional methods.It adopts RangeReplaceableCollection,so it owns append,remove methods and so on.
 
 ## Initializers
 You can creat the class or struct by the flowing ways.
 
     var q = ["1", "2", "foo", "3"]
 ## Usage
        q.append("hh")
        q.append(contentsOf: ["kk","jj"])
        q.remove(at: 2)
 
        q.index(after: 0)
        // 你可以用for...in 循环访问队列
        for s in q { print(s) }
        let a = Array(q)
 
        // 调用 SequenceType 的扩展方法
        q.map { $0.uppercased() }
        q.flatMap { Int ( $0) }
        q.filter {
            $0.characters.count > 1
        }
        // 调用 CollectionType 的扩展方法
        q.isEmpty
        // false
        q.count
        // 4
        q.first // "1"
 ---
  */
struct Queue<Element>: QueueType {
    var left: [Element]
    var right: [Element]
    
    init() {
        left = []
        right = []
    }
    
    mutating func enqueue(newElement: Element) {
        right.append(newElement)
    }
    
    mutating func dequeue() -> Element? {
        guard !(left.isEmpty && right.isEmpty) else {
            return nil
        }
        if left.isEmpty {
            left = right.reversed()
            right.removeAll(keepingCapacity: true)
        }
        return left.removeLast()
    }
}

protocol QueueType {
    associatedtype Element
    mutating func enqueue(newElement: Element)
    mutating func dequeue() -> Element?
}

extension Queue: Collection {
    var startIndex: Int { return 0 }
    var endIndex: Int { return left.count + right.count }
    
    func index(after i: Int) -> Int {
        return i + 1
    }
    
    subscript(idx: Int ) -> Element {
        precondition((0..<endIndex).contains(idx), "Index out of bounds")
        if idx < left.endIndex {
            return left [ left.count - idx]
        } else {
            return right[idx - left.count] }
    }
}

extension Queue: ExpressibleByArrayLiteral {
    init(arrayLiteral: Element...) {
        self.init()
        self.left = arrayLiteral.reversed()
        self.right = []
    }
}

extension Queue: RangeReplaceableCollection {
    mutating func reserveCapacity(_ n: Int) {
        return
    }
    
    mutating func replaceSubrange<C>(_ subrange: Range<Int>, with newElements: C) where C : Collection, C.Iterator.Element == Element {
        right = left.reversed() + right
        left.removeAll(keepingCapacity: true)
        right.replaceSubrange(subrange, with: newElements)
    }
}
