//
//  PhotoViewController.swift
//  CollectionViewDemo
//
//  Created by Michael Henry on 12/19/15.
//  Copyright © 2015 Digital Javelina, LLC. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    @IBOutlet var photoImageView: UIImageView!
    
    var imageName: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        photoImageView.image = UIImage(named: imageName)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
