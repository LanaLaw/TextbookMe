//
//  ViewController.swift
//  BC_Rental
//
//  Created by Ellana Lawrence on 12/2/19.
//  Copyright © 2019 Ellana Lawrence. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI
import GoogleSignIn

class ViewController: UIViewController {

    
    @IBOutlet var searchView: UIView!
    
    var textbooks: Textbooks!
    var authUI: FUIAuth!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authUI = FUIAuth.defaultAuthUI()
        authUI?.delegate = self
        textbooks = Textbooks()
        // Do any additional setup after loading the view.
        //saveTestTextbook()
        textbooks.loadData {
            print("Textbooks downloaded")
//            let downloadedTextbooks = Textbooks.textbookArray
            let downloadedTextbooks = Textbooks.self
            //This is just a test to make sure download is working
           // print(downloadedTextbooks[0].author)
            print(downloadedTextbooks.self)
        }
    }
    
    //look into textfield delegates
    //there will probably be a default function for "textDidBeginEditing" or "textDidChange"
    //Make that function call another function that you'll write, called like...
    //"updateSearchSuggestions" or "updateSearchResults"
    //You might want a local variable to hold "currentSuggestions" or "currentResults"
    //as a var dccnanad = [Textbook]()
    //That function should either update the UI, or call TableViewReloadData, or be in the Tableview
    //This will make it look like your app is querying in real time even though it isnt
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        signIn()
    }
    
    func signIn() {
    let providers: [FUIAuthProvider] = [
    FUIGoogleAuth(),
            ]
    if authUI.auth?.currentUser == nil {
    self.authUI?.providers = providers
    present(authUI.authViewController(), animated: true, completion: nil)
        } else {
            searchView.isHidden = false
        }
}
    
    @IBAction func signOutPressed(_ sender: Any) {
        do {
               try authUI!.signOut()
               print("^^^ Successfully signed out!")
               searchView.isHidden = true
               signIn()
           } catch {
               searchView.isHidden = true
               print("*** ERROR: Couldn't sign out")
           }
    }
    
    
}

extension ViewController: FUIAuthDelegate{
    func application(_ app: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        let sourceApplication = options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String?
      if FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication: sourceApplication) ?? false {
        return true
      }
      // other URL handling goes here.
      return false
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        if let user = user {
            searchView.isHidden = false
            print("*** we signed in with the user \(user.email) ?? unknown e-mail")

        }
        
        
    }
    
    //for the logo
    
    func authPickerViewController(forAuthUI authUI: FUIAuth) -> FUIAuthPickerViewController {
        let loginViewController = FUIAuthPickerViewController(authUI: authUI)
        loginViewController.view.backgroundColor = UIColor.white
      //  loginViewController.view.backgroundColor = UIColor(red:0.58, green:0.88, blue:0.85, alpha:1.0)

        let marginInsets: CGFloat = 16
        let imageHeight: CGFloat = 225
        let imageY = self.view.center.y - imageHeight
        let logoFrame = CGRect(x: self.view.frame.origin.x + marginInsets, y: imageY, width: self.view.frame.width - (marginInsets * 2), height: imageHeight)
        let logoImageView = UIImageView(frame: logoFrame)
        logoImageView.image = UIImage(named: "TextbookMeLogo1")
        logoImageView.contentMode = .scaleAspectFit
        loginViewController.view.addSubview(logoImageView)
        return loginViewController
    }
    
}

