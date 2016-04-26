//
//  GolfDoctorProjectAppDelegate.m
//  GolfDoctorProject
//
//  Created by APPLE  on 11/15/11.
//  Copyright 2011 openxcel. All rights reserved.
//

#import "GolfDoctorProjectAppDelegate.h"
#import "RootViewController.h"




@implementation GolfDoctorProjectAppDelegate

@synthesize window;
@synthesize navigationController,tabBarController,flagChkVideo;
@synthesize strToken;

#pragma mark -
#pragma mark Application lifecycle

-(BOOL)checkInternet{
	//Test for Internet Connection
	NSLog(@"——–");
	NSLog(@"Testing Internet Connectivity");
	Reachability *r = [Reachability reachabilityWithHostName:@"finance.yahoo.com"];
	NetworkStatus internetStatus = [r currentReachabilityStatus];
	BOOL internet;
	if ((internetStatus != ReachableViaWiFi) && (internetStatus != ReachableViaWWAN)) {
		internet = NO;
	} else {
		internet = YES;
	}
	return internet;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
	
	[[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeBadge)];
     
    // Add the navigation controller's view to the window and display.
    flagChkVideo=0;
	
	//UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Default.png"]];
//	imgView.frame = CGRectMake(0, 0, 320, 44);
//	
//	[self.navigationController.navigationBar addSubview:imgView];
       
    [self.window addSubview:navigationController.view];
	splash =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default.png"]] ;
	splash.frame =CGRectMake(0, 20, 320, 460);
	[self.window addSubview:splash];
	[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(removeSplash) userInfo:nil repeats:NO];
    [self.window makeKeyAndVisible];

    return YES;
}


-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
	
	NSLog(@"deviceToken: %@", deviceToken);
	
	self.strToken = [[[[deviceToken description]
					   stringByReplacingOccurrencesOfString: @"<" withString: @""] 
					  stringByReplacingOccurrencesOfString: @">" withString: @""] 
					 stringByReplacingOccurrencesOfString: @" " withString: @""];
	
	NSLog(@"strToken: %@", self.strToken);
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
	
	NSLog(@"userInfo %@",userInfo);
	
	
	

}

	
-(void)removeSplash{
	[splash removeFromSuperview];
}
			 
			 

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}


@end

