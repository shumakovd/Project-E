//
//  AppSettings.swift
//  Project-E
//
//  Created by Shumakov Dmytro on 23.08.2022.
//

import Foundation

class AppSettings {
    
    static var shared: AppSettings = {
        return AppSettings()
    }()
    
    private init() {}
    
    // MARK: - Properties
    
    // User Settings
    var username: String?
    var useremail: String?
    var userphone: String?
    var userbirthday: String?
    
    // Terms Of Use
    var termsOfUseURL: String?
    var privacyPolicyURL: String?
    
    // Social Media
    var phoneNumber: String?
    var facebookURL: String?
    var instagramURL: String?
                            
    // Restaurant Information
    var restaurantCities: [String]?
    var restaurantStreets: [String]?
    
    // Main App Settings
    var applicationScheme: ApplicationScheme = .user
    
    
    // MARK: - Methods
    
    func loadApplicationData() {
        applicationURL()
    }
    
    private func applicationURL() {
        privacyPolicyURL = "https://.../privacy-policy"
        termsOfUseURL = "https://.../terms-of-use"
    }

    
}
