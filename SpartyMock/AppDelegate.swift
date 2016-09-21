//
//  AppDelegate.swift
//  SpartyMock
//
//  Created by David Colvin on 8/1/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var window: UIWindow?
    var tabBarController: UITabBarController?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
//        DataStore.sharedInstance.loadMockData()
        
        setupGlobalAppearance()

        FIRApp.configure()
        
        setupGoogleServices()
        
        NSUserDefaults.registerSpartyDefaults()
        
        let _ = DataStore.sharedInstance
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        if let user = FIRAuth.auth()?.currentUser {
            
            print("Authenticated user with uid: \(user.uid)")
            
            //If authenticated, check if registered
            FirbaseManager.isRegistered(user.uid, completion: { (result) in

                NSUserDefaults.setIsRegistered(result)
                
                if result == false {
                    NSNotificationCenter.defaultCenter().postNotificationName(Notifications.ShowRegistration, object: nil)
                }
            })
        } else {
            //If not authenticated, show login screen
            NSNotificationCenter.defaultCenter().postNotificationName(Notifications.ShowLogin, object: nil)
        }
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    //MAKR: - Setup
    //--------------------------------------------------------------------------
    private func setupGoogleServices() {
        GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
    }
    
    private func setupGlobalAppearance() {
        
        //Navbar
        UINavigationBar.appearance().barTintColor = UIColor.primaryColor()
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        UINavigationBar.appearance().opaque = true
        
        //Tabbar
        UITabBar.appearance().translucent = false
        UITabBar.appearance().barTintColor = UIColor.whiteColor()
        UITabBar.appearance().tintColor = UIColor.primaryColor()
        
        //TableViewCell
        UITableViewCell.appearance().tintColor = UIColor.primaryColor()
        
        //Search Bar Text
        UITextField.appearanceWhenContainedInInstancesOfClasses([UISearchBar.self]).backgroundColor = UIColor(red:1, green:1, blue:1, alpha:0.9)
    }


    //MARK: - Google Services
    //--------------------------------------------------------------------------
    func application(application: UIApplication,
                     openURL url: NSURL, options: [String: AnyObject]) -> Bool {
        return GIDSignIn.sharedInstance().handleURL(url,
                                                    sourceApplication: options[UIApplicationOpenURLOptionsSourceApplicationKey] as? String,
                                                    annotation: options[UIApplicationOpenURLOptionsAnnotationKey])
    }
    
    func application(application: UIApplication,
                     openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        var options: [String: AnyObject] = [UIApplicationOpenURLOptionsSourceApplicationKey: sourceApplication!,
                                            UIApplicationOpenURLOptionsAnnotationKey: annotation!]
        return GIDSignIn.sharedInstance().handleURL(url,
                                                    sourceApplication: sourceApplication,
                                                    annotation: annotation)
    }
    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!,
                withError error: NSError!) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        // ...
    }
    
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user:GIDGoogleUser!,
                withError error: NSError!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
}

