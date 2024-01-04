//
//  Image.swift
//  mojitalk
//
//  Created by 이은서 on 1/4/24.
//

import UIKit

enum Image {
    
    static var camera: UIImage {
        UIImage(named: "Camera")!
    }
    
    static var newMessageButton: UIImage {
        UIImage(named: "NewMessageButton")!
    }
    
    static var onboarding: UIImage {
        UIImage(named: "Onboarding")!
    }
    
    enum Chevron {
        static var up: UIImage {
            UIImage(named: "ChervronUp")!
        }
        
        static var down: UIImage {
            UIImage(named: "ChervronDown")!
        }
        
        static var left: UIImage {
            UIImage(named: "ChervronLeft")!
        }
        
        static var right: UIImage {
            UIImage(named: "ChervronRight")!
        }
    }
    
    enum Hashtag {
        static var thick: UIImage {
            UIImage(named: "HashtagThick")!
        }
    
        static var thin: UIImage {
            UIImage(named: "HashtagThin")!
        }
    }
    
    enum Icon {
        static var close: UIImage {
            UIImage(named: "CloseIcon")!
        }
        
        static var email: UIImage {
            UIImage(named: "EmailIcon")!
        }
        
        static var help: UIImage {
            UIImage(named: "HelpIcon")!
        }
        
        static var plus: UIImage {
            UIImage(named: "PlusIcon")!
        }
        
        static var threeDots: UIImage {
            UIImage(named: "ThreeDotsIcon")!
        }
    }
    
    enum Profile {
        static var dummy: UIImage {
            UIImage(named: "DummyProfile")!
        }
        
        static var noPhotoA: UIImage {
            UIImage(named: "NoPhotoAProfile")!
        }
        
        static var noPhotoB: UIImage {
            UIImage(named: "NoPhotoBProfile")!
        }
        
        static var noPhotoC: UIImage {
            UIImage(named: "NoPhotoCProfile")!
        }
        
        static var sesacBot: UIImage {
            UIImage(named: "SesacBotProfile")!
        }
    }
    
    enum TabItem {
        static var homeActive: UIImage {
            UIImage(named: "HomeActiveTabItem")!
        }
        
        static var home: UIImage {
            UIImage(named: "HomeTabItem")!
        }
        
        static var messageActive: UIImage {
            UIImage(named: "MessageActiveTabItem")!
        }
        
        static var message: UIImage {
            UIImage(named: "MessageTabItem")!
        }
        
        static var profileActive: UIImage {
            UIImage(named: "ProfileActiveTabItem")!
        }
        
        static var profile: UIImage {
            UIImage(named: "ProfileTabItem")!
        }
        
        static var settingActive: UIImage {
            UIImage(named: "SettingActiveTabItem")!
        }
        
        static var setting: UIImage {
            UIImage(named: "SettingTabItem")!
        }
    }
    
    enum Workspace {
        static var list: UIImage {
            UIImage(named: "List")!
        }
        
        static var workspace: UIImage {
            UIImage(named: "Workspace")!
        }
    }
    
}
