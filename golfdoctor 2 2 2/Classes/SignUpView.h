//
//  SignUpView.h
//  GolfDoctors
//
//  Created by APPLE apple on 11/15/11.
//  Copyright (c) 2011 openxcel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginView.h"
#import "customealert.h"
#import "GolfDoctorProjectAppDelegate.h"
#import "GdataParser.h"
#import "MBProgressHUD.h"


@class LoginView;
@interface SignUpView : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate,UIActionSheetDelegate,UITextFieldDelegate>
{
	LoginView *loginObj;
	
	MBProgressHUD *HUD;

	GolfDoctorProjectAppDelegate *app_obj;
	
	
	
	IBOutlet UIButton *SignUpbtn;
	IBOutlet UITextField *TxtName;
	IBOutlet UITextField *TxtLastName;
	IBOutlet UITextField *TxtCountry;
	IBOutlet UITextField *TxtUserName;
	IBOutlet UITextField *TxtEmail;
	IBOutlet UITextField *TxtPass;
	IBOutlet UITextField *TxtConfPass;
	IBOutlet UITextField *TxtTimeZone;
	IBOutlet UITextField *TxtEmpId;
	IBOutlet UITextField *TxtConfEmail;
	
	IBOutlet UIButton *radio_btn1;
	IBOutlet UIButton *radio_btn2;
	
	IBOutlet UIImageView *empId_img;
	
	NSString *roll_str;
	
	IBOutlet UIButton *btnCountry; 
	IBOutlet UIButton *btnTimeZone;
	
	NSString *str_country;
	NSString *str_timezone;
	
	CGFloat animatedDistance;
	
	NSMutableArray *arrayNo;
	UIPickerView *pkrCountry;
	UIPickerView *pkrTime;
	IBOutlet UIScrollView *scroll_signup;
	IBOutlet UIView *myView;
}
@property (nonatomic ,retain) UIPickerView *pkrTime;
@property (nonatomic ,retain) UIPickerView *pkrCountry;
@property (nonatomic, retain) NSMutableArray *arrayNo;
@property (nonatomic, retain) UIButton *btnCountry; 
@property (nonatomic, retain) UIButton *btnTimeZone;

@property (nonatomic, retain) UITextField *TxtName;
@property (nonatomic, retain) UITextField *TxtBdate;
@property (nonatomic, retain) UITextField *TxtEmail;
@property (nonatomic, retain) UITextField *TxtPass;
@property (nonatomic, retain) UITextField *TxtConfPass;
@property (nonatomic, retain) UITextField *TxtPhnNo;

@property (nonatomic, retain) UIButton *loginbtn;
@property (nonatomic, retain) UIButton *SignUpbtn;
//-(IBAction)userlogin;



-(void)fire_web_webservice;
-(IBAction)RollBtnValueChanged:(id)sender;
-(IBAction)SignUp;
-(IBAction)Cancel:(id)sender;
-(IBAction)countryClicked :(id)sender;
-(IBAction)timeZoneClicked :(id)sender;
- (BOOL)validateEmailWithString:(NSString*)email;

-(void)showHUD;
-(void)hideHUD;


@end
