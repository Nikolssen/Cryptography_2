//
//  Elgamal.swift
//  Elgamal
//
//  Created by Admin on 11.04.2021.
//

import Foundation
class Elgamal
{
    static func isPrime(_ number: Int) -> Bool{
        switch number{
        case ...1:
            return false
        case 3: return true
        default:
            var i = 2
            while i*i <= number
            {
                if number % i == 0
                {return false}
                i+=1
            }
            return true
        }
    }
    
    static func fastExp(a: Int, z: Int, n: Int) -> Int{
        var a1 = a
        var z1 = z
        var x = 1
        while z1 != 0
        {
            while z1 % 2 == 0
            {
                z1 = z1 / 2
                a1 = (a1 * a1) % n
            }
            z1 = z1 - 1
            x = (x * a1) % n
        }
        return x
    }
    
    static func areRelativelyPrime(_ first: Int, _ second: Int) -> Bool{
        var a = 0
        var b = max(first, second)
        var r = min(first, second)
        while r != 0 {
            
            a = b
            b = r
            r = a % b
        }
        return b == 1
    }
    
    static func primaryRoot(p: Int) -> Int {
        var arr = Array<Int>()
        for i in 2..<p {
            if isPrimaryRoot(p: p, a: i)
            {
                arr.append(i)
            }
        }
        if arr.isEmpty { return 0 }
        else {return arr.randomElement()!}
    }
    
    static func isPrimaryRoot(p: Int, a: Int) -> Bool{
        var set = Set<Int>()
        var last = 1
        for _ in 0..<(p-1) {
            last = (last * a) % p
            if (set.contains(last)) {return false}
            set.insert(last)
        }
        return true
    }
    
    static func getX(p: Int) -> Int {
        return Int.random(in: 2..<(p-1))
    }
    
    static func getY(p: Int, g: Int, x: Int) -> Int{
        return fastExp(a: g, z: x, n: p)
    }
    static func getK(p: Int) -> Int {
        var arr = Array<Int>()
        for i in 2..<(p-1) {
            if areRelativelyPrime(i, p) {
                arr.append(i)
            }
        }
        let ind = Int.random(in: 0..<arr.count)
        return arr[ind]
    }

    
    static func encrypt(y: Int, k: Int, p: Int, g: Int, m: Int) -> (a: Int, b: Int){
        let a = fastExp(a: g, z: k, n: p)
        let b = (m*fastExp(a: y, z: k, n: p))%p
        return (a,b)
    }
    
    static func decrypt(a: Int, b: Int, x: Int, p: Int) -> Int {
        return (b * fastExp(a: a, z: x*(p-2), n: p)) % p
    }
}
