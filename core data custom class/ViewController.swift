//
//  ViewController.swift
//  core data custom class
//
//  Created by Aria Cundick on 6/15/15.
//  Copyright (c) 2015 Code on the Cawb. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var txtUser: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    
    var userDatabase = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func btnSave_Clicked(sender: AnyObject) {
        //get instance of the app delegate
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext!
        
        //grabs the user entity from the xcDataModel
        let ent = NSEntityDescription.entityForName("Users", inManagedObjectContext: context)
        
        //create var for new user and set the info to be saved
        var newUser = Users(entity: ent!, insertIntoManagedObjectContext: context)
        
        do{
            newUser.username = txtUser.text
        }while(!uniqueUsername(newUser.username))
        
        newUser.password = txtPass.text
        
        //save to core data
        context.save(nil)
        
        //debugging purposes
        println(newUser)
        println("saved")
        
    }
    @IBAction func btnLoad_Clicked(sender: AnyObject) {
        //get instance of the app delegate
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext!
        
        //request information from database
        let request = NSFetchRequest(entityName: "Users")
        
        //Core data doesnt return an object, but instead returns
        // a list with same number of objects from the query.
        //By setting this to false, it returns us an instance of the object we want.
        request.returnsObjectsAsFaults = false;
        
        //Execute fetch request
        //%@ is the first element in cvargs, or in this case it is the text from txtUser
        request.predicate = NSPredicate(format: "username = %@", txtUser.text)
        
        var results: NSArray = context.executeFetchRequest(request, error: nil)!
        
        //debugging purposes
        if results.count > 0 {
            for user in results {
                var thisUser = user as! Users
                println("the users name is \(thisUser.username), pw is \(thisUser.password)")
            }
            println(" \(results.count) results found.")
        }
        else{
            println("No results found.")
        }
        
    }
    
    //MARK: - self made methods for extraneous purposes
    
    func uniqueUsername (name: String) -> Bool {
        for users in userDatabase {
            var thisUser = users as! Users
            
            if thisUser.username == name {
                return false
            }
        }
        
        return true
    }
    
    //Fetch an array of data.
    func fetchData()
    {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext!
            
        //fetch request into core data
        let fetchRequest = NSFetchRequest(entityName: "Users")
        fetchRequest.returnsObjectsAsFaults = false;
        
        //Create an array of the data
        var results: NSArray = context.executeFetchRequest(fetchRequest, error: nil)!
        
        //Set the found data to a global variable
        userDatabase = results as! [(NSManagedObject)]
        
        //debugging purposes
        for users in userDatabase {
            
            var thisUser = users as! Users
            
            if userDatabase.count > 0 {
               println("user: \(thisUser.username)")
            }
            
        }
        
        
        
        
    }

}

