//
//  UploadView.h
//  GolfDoctors
//
//  Created by APPLE apple on 11/15/11.
//  Copyright (c) 2011 openxcel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginView.h"
#import "GolfDoctorProjectAppDelegate.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import <QuartzCore/QuartzCore.h>
#import "JSON.h"
#import "NSDataAdditions.h"
#import "MBProgressHUD.h"
#import "ASIHTTPRequest.h"
#import <MediaPlayer/MPMoviePlayerController.h>

#import "CustomStoreObserver.h"
#import <StoreKit/StoreKit.h>


@class LoginView,GolfDoctorProjectAppDelegate;
@interface UploadView : UIViewController<CustomStoreObserverDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    GolfDoctorProjectAppDelegate *appDelegateObj;
    LoginView *LoginObj;
    UIImagePickerController *picker;
	//UIVideoEditorController
	
	MBProgressHUD *HUD;
    
    CustomStoreObserver *paymentObserver;
	
    IBOutlet UIButton *vedioBtn;
	IBOutlet UIButton *btnUpload;
	IBOutlet UIButton *btnUVideo;
	
	NSString *webData_video;
	
	NSMutableData *Data_video;
	
	
	NSURLConnection *conn;
	NSMutableData *webData;
	
	IBOutlet UIImageView *image_view;
    
}
@property (nonatomic, retain) UIButton *btnUVideo;
@property (nonatomic, retain) UIButton *btnUpload;
@property (nonatomic, retain) UIButton *vedioBtn;
@property (nonatomic, retain)UIImagePickerController *picker;
-(IBAction)getVedio:(id)sender;
-(IBAction)UploadVideo:(id)sender;
-(IBAction)buyClicked :(id)sender;
-(void)Logout;
-(void)upload_video:(NSMutableData *)fileData;
-(void)showHUD;
-(void)hideHUD;
-(void)startUploadingVideo;



@end
