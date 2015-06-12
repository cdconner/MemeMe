//
//  MemeDetailController.swift
//  MemeMe
//
//  Created by Kelly Egan on 6/9/15.
//  Copyright (c) 2015 Kelly Egan. All rights reserved.
//

import UIKit

class MemeDetailController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var meme: Meme!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        imageView.image = meme.memedImage
    }

    @IBAction func shareMeme(sender: AnyObject) {
        let activityController = UIActivityViewController(activityItems: [meme.memedImage!], applicationActivities: nil)
        self.presentViewController(activityController, animated: true, completion: nil )
    }
}
