//
//  LoginView.h
//  GolfDoctorProject
//
//  Created by APPLE  on 11/15/11.
//  Copyright 2011 openxcel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignUpView.h"
#import "GolfDoctorProjectAppDelegate.h"
#import "MBProgressHUD.h"
#import "GdataParser.h"

@class SignUpView,GolfDoctorProjectAppDelegate;
@interface LoginView : UIViewController <UITextFieldDelegate>{
    
    SignUpView *signUpObj;
    GolfDoctorProjectAppDelegate *appDelegateObj;
    IBOutlet UITextField *userName;
    IBOutlet UITextField *password;
    IBOutlet UIButton *loginbtn;
    IBOutlet UIButton *SignUpbtn;
    
	MBProgressHUD *HUD;
	
	NSArray * controllers;
}

@property (nonatomic, retain) UITextField *userName;
@property (nonatomic, retain) UITextField *password;


-(IBAction)Login;
-(IBAction)userSignUp;

-(void)showHUD;
-(void)hideHUD;

@end
