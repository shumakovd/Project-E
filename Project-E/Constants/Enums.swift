//
//  Enums.swift
//  Project-E
//
//  Created by Shumakov Dmytro on 23.08.2022.
//

import UIKit
import Foundation

let kMainStoryboard = UIStoryboard(name: "Main", bundle: nil)
let kAuthStoryboard = UIStoryboard(name: "Auth", bundle: nil)
// let kAdminStoryboard = UIStoryboard(name: "Admin", bundle: nil)
let kHomeStoryboard = UIStoryboard(name: "Home", bundle: nil)
let kMenuStoryboard = UIStoryboard(name: "Menu", bundle: nil)
let kProfileStoryboard = UIStoryboard(name: "Profile", bundle: nil)
let kPopupStoryboard = UIStoryboard(name: "Popup", bundle: nil)

enum ViewControllerIDs {
    
    enum MainStoryboard {
        // static let kMainTabBarVC = "MainTabBarVCId"
        static let kMainTabBarController = "MainTabBarController"
    }
    
    enum AuthStoryboard {
        static let kAuthenticationVC = "AuthenticationVC"
        static let kLoginVC = "LoginVC"
    }
    
//    enum AdminStoryboard {
//        // static let kHomeVC = "HomeVCId"
//    }
    
    enum HomeStoryboard {
        // static let kHomeVC = "HomeVCId"
    }
    
    enum MenuStoryboard {
        //
    }
    
    enum ProfileStoryboard {
        // static let kProfileVC = "ProfileVCId"
    }
    
    enum PopupStoryboard {
        // static let kProfileVC = "ProfileVCId"
    }
}

enum ApplicationScheme {
    case user, teacher
}
