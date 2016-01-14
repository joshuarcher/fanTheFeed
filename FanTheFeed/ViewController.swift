//
//  ViewController.swift
//  FanTheFeed
//
//  Created by Joshua Archer on 1/13/16.
//  Copyright © 2016 Joshua Archer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageOutlet: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellForRowAtIndexPath()
        // goGetImage()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func goGetImage(callback: (image: UIImage) -> Void) {
        // https://s3.amazonaws.com/fanfeed/thumbnail/poster_563fb449f048ca0433cf6f0a.jpg
        
        if let url = NSURL(string: "https://s3.amazonaws.com/fanfeed/thumbnail/poster_563fb449f048ca0433cf6f0a.jpg") {
            let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)
            dispatch_async(queue, { () -> Void in
                if let data = NSData(contentsOfURL: url) {
                    if let image = UIImage(data: data) {
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            callback(image: image)
                        })
                    }
                } else {
                    print("data error")
                }
            })
        } else {
            print("url error")
        }
        
        
    }
    
    func cellForRowAtIndexPath() {
        goGetImage { (image) -> Void in
            self.imageOutlet.image = image
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

/*
let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)
dispatch_async(queue, { () -> Void in
let image = FileManager.getProfileImage(fromPath: imagePath)

dispatch_async(dispatch_get_main_queue(), { () -> Void in
if (image != nil) {
cell.imageView.image = image
} else {
NSLog("No image at file path for index")
}
})
})
*/
