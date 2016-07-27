//
//  LoginViewContoller.m
//  Final
//
//  Created by DetroitLabs on 7/22/16.
//  Copyright © 2016 DetroitLabs. All rights reserved.
//

#import "LoginViewContoller.h"
@import FirebaseDatabase;

@interface LoginViewContoller ()
@property FIRDatabaseReference *ref;
@end
//FIRDatabaseReference *ref;

@implementation LoginViewContoller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ref = [[FIRDatabase database] reference];
    // TODO(developer) Configure the sign-in button look/feel
    
    [GIDSignIn sharedInstance].uiDelegate = self;
    // Uncomment to automatically sign in the user.
    //[[GIDSignIn sharedInstance] signInSilently];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}




@end
