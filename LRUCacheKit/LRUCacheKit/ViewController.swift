//
//  ViewController.swift
//  LRUCacheKit
//
//  Created by Arthur on 15/1/10.
//  Copyright (c) 2015年 Arthur. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var array = [1,2,3,1,2,3,4,5,4,5]
        
        //Setup cache number
        LRUCacheKit.setCacheNumber(5)

        for  a:Int in array {
            LRUCacheKit.setCacheObject(a, byKey: String(a))
            LRUCacheKit.showDescription()
        }
        
        //Change cache number
        LRUCacheKit.setCacheNumber(3)
        LRUCacheKit.showDescription()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

