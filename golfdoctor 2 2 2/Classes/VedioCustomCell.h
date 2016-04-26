//
//  VedioCustomCell.h
//  GolfDoctorProject
//
//  Created by APPLE apple on 11/15/11.
//  Copyright (c) 2011 openxcel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchView.h"




@interface VedioCustomCell : UITableViewCell
{
    IBOutlet UILabel *byCommentAddedLabel;
    IBOutlet UILabel *byWhomLabel;
    IBOutlet UIButton *rat1;
    IBOutlet UIButton *rat2;
    IBOutlet UIButton *rat3;
    IBOutlet UIButton *rat4;
    IBOutlet UIButton *rat5;
	
	IBOutlet UIImageView *thumbnil_img;
	
	IBOutlet UIActivityIndicatorView *activity;
	
	IBOutlet UILabel *title_lbl;
	IBOutlet UILabel *cmnt_lbl;
	
	IBOutlet UIButton *noti_btn;
	
	
    
}

@property (nonatomic, retain) UIImageView *thumbnil_img;
@property (nonatomic, retain) UIActivityIndicatorView *activity;

@property (nonatomic, retain) UIButton *noti_btn;
@property (nonatomic, retain) UIButton *rat1;
@property (nonatomic, retain) UIButton *rat2;
@property (nonatomic, retain) UIButton *rat3;
@property (nonatomic, retain) UIButton *rat4;
@property (nonatomic, retain) UIButton *rat5;

@property (nonatomic, retain) UILabel *title_lbl;
@property (nonatomic, retain) UILabel *cmnt_lbl;
@property (nonatomic, retain) UILabel *byWhomLabel;
@property(nonatomic,retain)UILabel *byCommentAddedLabel;

@end
