//
//  VedioView.h
//  GolfDoctors
//
//  Created by APPLE apple on 11/15/11.
//  Copyright (c) 2011 openxcel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VedioDetail.h"
#import "GolfDoctorProjectAppDelegate.h"
#import "LoginView.h"
#import "GdataParser.h"
#import "MBProgressHUD.h"

#import "IconDownloader.h"

@class VedioDetail,GolfDoctorProjectAppDelegate,LoginView;
@interface VedioView : UIViewController<UITableViewDelegate , IconDownloaderDelegate>
{
    GolfDoctorProjectAppDelegate *appDelegateObj;
    LoginView *LoginObj;
	NSMutableArray *videoArray;
	IBOutlet UITableView *vedioTbl;
    VedioDetail *vediodetailObj;
	MBProgressHUD *HUD;
    NSString *msg1;
	
	NSMutableDictionary *imageDownloadsInProgress;
}



- (void) getImage:(NSMutableDictionary*)appRecord forIndexPath:(NSIndexPath *)indexPath;
- (void)startIconDownload:(NSMutableDictionary *)appRecord forIndexPath:(NSIndexPath *)indexPath;


@property (nonatomic, retain) NSMutableArray *videoArray;
@property (nonatomic, retain) UITableView *vedioTbl;
@property (nonatomic, retain) NSMutableDictionary *imageDownloadsInProgress;


-(void)Logout;
-(void)fire_web_webservice;

-(void)showHUD;
-(void)hideHUD;
@end
