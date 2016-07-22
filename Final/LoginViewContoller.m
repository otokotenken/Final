//
//  LoginViewContoller.m
//  Final
//
//  Created by DetroitLabs on 7/22/16.
//  Copyright © 2016 DetroitLabs. All rights reserved.
//

#import "LoginViewContoller.h"
@import Firebase;

@implementation LoginViewContoller

FIRDatabaseReference *ref;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // TODO(developer) Configure the sign-in button look/feel
    
    [GIDSignIn sharedInstance].uiDelegate = self;
        ref = [[FIRDatabase database] reference];
    // Uncomment to automatically sign in the user.
    //[[GIDSignIn sharedInstance] signInSilently];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}




@end
