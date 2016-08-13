//
//  RecipeCollectionViewController.swift
//  CollectionViewDemo
//
//  Created by Michael Henry on 12/19/15.
//  Copyright © 2015 Digital Javelina, LLC. All rights reserved.
//

import UIKit
import Social

private let reuseIdentifier = "Cell"

class RecipeCollectionViewController: UICollectionViewController {
    
    @IBOutlet var shareButton: UIBarButtonItem!
    
    var recipeImages = ["angry_birds_cake", "creme_brelee", "egg_benedict", "full_breakfast", "green_tea", "ham_and_cheese_panini", "ham_and_egg_sandwich", "hamburger", "instant_noodle_with_egg.jpg", "japanese_noodle_with_pork", "mushroom_risotto", "noodle_with_bbq_pork", "starbucks_coffee", "thai_shrimp_cake", "vegetable_curry", "white_chocolate_donut"]
    var shareEnabled = false
    var selectedRecipes: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return recipeImages.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! RecipeCollectionViewCell
    
        // Configure the cell
        
        cell.recipeImageView.image = UIImage(named: recipeImages[indexPath.row])
        cell.backgroundView = UIImageView(image: UIImage(named: "photo-frame"))
        cell.selectedBackgroundView = UIImageView(image: UIImage(named: "photo-frame-selected"))
    
        return cell
    }
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showRecipePhoto" {
            if let indexPaths = collectionView?.indexPathsForSelectedItems() {
                let destinationViewController = segue.destinationViewController as! UINavigationController
                let photoViewController = destinationViewController.viewControllers[0] as! PhotoViewController
                photoViewController.imageName = recipeImages[indexPaths[0].row]
                collectionView?.deselectItemAtIndexPath(indexPaths[0], animated: false)
            }
        }
    }
    
    @IBAction func shareButtonTapped(sender: AnyObject) {
        guard shareEnabled else {
            
            // change shareEnabled to "yes" and change the button to "upload"
            
            shareEnabled = true
            collectionView?.allowsMultipleSelection = true
            shareButton.title = "Upload"
            shareButton.style = .Done
            
            return
        }

            // post selected photos to facebook
            
            guard selectedRecipes.count > 0 else {
                
                return
        }
                if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook) {
                    let facebookComposer = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                    facebookComposer.setInitialText("Check out my recipes!")
                    
                    for recipePhoto in selectedRecipes {
                        facebookComposer.addImage(UIImage(named: recipePhoto))
                    }
                    
                    presentViewController(facebookComposer, animated: true, completion: nil)
            }
            
            // deselect all selected items
            
            if let indexPaths = collectionView?.indexPathsForSelectedItems() {
                for indexPath in indexPaths {
                    collectionView?.deselectItemAtIndexPath(indexPath, animated: false)
                }
                
            }
            
            // remove all items from selectedRecipes array
            
            selectedRecipes.removeAll(keepCapacity: true)
            
            // change the sharing mode to "no"
            
            shareEnabled = false
            collectionView?.allowsMultipleSelection = false
            shareButton.title = "Share"
            shareButton.style = .Plain
        }

    // MARK: UICollectionViewDelegate

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // check if sharing is enabled, otherwise, just leave this method
        
        guard shareEnabled else {
            return
        }
        
        // determine the selected items by using the indexPath
        
        let selectedRecipe = recipeImages[indexPath.row]
        
        // add the selected items to the array
        
        selectedRecipes.append(selectedRecipe)
    }
    
    override func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        // check if sharing is enabled, otherwise, just leave this method
        
        guard shareEnabled else {
            return
        }
        
        let deselectedRecipe = recipeImages[indexPath.row]
        if let index = recipeImages.indexOf(deselectedRecipe) {
            recipeImages.removeAtIndex(index)
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if identifier == "showRecipePhoto" {
            if shareEnabled {
                return false
            }
        }
        
        return true
    }

}
