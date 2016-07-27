//
//  LoginViewContoller.h
//  Final
//
//  Created by DetroitLabs on 7/22/16.
//  Copyright © 2016 DetroitLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleSignIn/GoogleSignIn.h>

@interface LoginViewContoller : UIViewController <GIDSignInUIDelegate>

@property(weak, nonatomic) IBOutlet GIDSignInButton *signInButton;
@end
