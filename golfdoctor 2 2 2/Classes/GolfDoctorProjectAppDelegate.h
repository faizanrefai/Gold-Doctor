//
//  GolfDoctorProjectAppDelegate.h
//  GolfDoctorProject
//
//  Created by APPLE  on 11/15/11.
//  Copyright 2011 openxcel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"




@interface GolfDoctorProjectAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
	
	UITabBarController *tabBarController;
	UIImageView *splash;
    int flagChkVideo;
	
	NSString *strToken;
	
}

@property (nonatomic, retain) NSString *strToken;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic)    int flagChkVideo;

-(BOOL)checkInternet;



@end

