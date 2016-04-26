//
//  SearchView.h
//  GolfDoctors
//
//  Created by APPLE apple on 11/15/11.
//  Copyright (c) 2011 openxcel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "VedioDetail.h"
#import "LoginView.h"
#import "GolfDoctorProjectAppDelegate.h"
#import "MBProgressHUD.h"
#import "IconDownloader.h"


@class VedioDetail,GolfDoctorProjectAppDelegate,LoginView;
@interface SearchView : UIViewController <IconDownloaderDelegate , UISearchBarDelegate,UITableViewDelegate,UISearchBarDelegate>
{
   MBProgressHUD *HUD;
    GolfDoctorProjectAppDelegate *appDelegateObj;
    LoginView *LoginObj;
	IBOutlet UISearchBar *mysearchBar;
	IBOutlet UITableView *listTbl;
    VedioDetail *vediodetailObj;
	NSMutableArray *vedioArray;
	UIButton *but1;
    UIButton *but2;
    UIButton *but3;
	UIButton *but4;
    UIButton *but5;
	MPMoviePlayerViewController *mp;
	
	
	NSMutableDictionary *imageDownloadsInProgress;
	
}

@property (nonatomic, retain) NSMutableDictionary *imageDownloadsInProgress;
@property (nonatomic, retain)  UISearchBar *searchBar;
@property (nonatomic, retain) UIButton *but1;
@property (nonatomic, retain) UIButton *but2;
@property (nonatomic, retain) UIButton *but3;
@property (nonatomic, retain) UIButton *but4;
@property (nonatomic, retain) UIButton *but5;

@property (nonatomic, retain) NSMutableArray *vedioArray;

@property (nonatomic, retain) UITableView *listTbl;
-(IBAction)rateBtnClick:(id)sender;
-(void)Logout;
-(void)showHUD;
-(void)hideHUD;
-(void)fire_web_webservice;

- (void) getImage:(NSMutableDictionary*)appRecord forIndexPath:(NSIndexPath *)indexPath;
- (void)startIconDownload:(NSMutableDictionary *)appRecord forIndexPath:(NSIndexPath *)indexPath;


@end
