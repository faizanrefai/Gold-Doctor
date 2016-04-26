//
//  VedioCustomCell.m
//  GolfDoctorProject
//
//  Created by APPLE apple on 11/15/11.
//  Copyright (c) 2011 openxcel. All rights reserved.
//

#import "VedioCustomCell.h"
#import "SearchView.h"

@implementation VedioCustomCell
@synthesize noti_btn,rat1,rat2,rat3,rat4,rat5,cmnt_lbl,title_lbl,byWhomLabel,byCommentAddedLabel,thumbnil_img,activity;

-(void)awakeFromNib{
	thumbnil_img.layer.cornerRadius = 10.0;
	thumbnil_img.layer.borderColor = [UIColor grayColor].CGColor;
	thumbnil_img.layer.borderWidth = 0.5;
	[thumbnil_img.layer setMasksToBounds:YES];
}
/*
-(void)layoutSubviews
{
	
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
 */



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [byWhomLabel release];
    [byCommentAddedLabel release];
    [super dealloc];
}
@end
