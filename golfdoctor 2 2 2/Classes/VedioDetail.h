//
//  VedioDetail.h
//  GolfDoctorProject
//
//  Created by APPLE apple on 11/15/11.
//  Copyright (c) 2011 openxcel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <QuartzCore/QuartzCore.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import "recordAudio.h"
#import "GdataParser.h"
#import "JSON.h"
#import "GolfDoctorProjectAppDelegate.h"
#import "MBProgressHUD.h"
#import <AVFoundation/AVFoundation.h>
#import "AVAudioPlayerSampleViewController.h"
#import "EGOImageView.h"
#import "customealert.h"


@interface VedioDetail : UIViewController<RecoderDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,AVAudioPlayerDelegate>
{
    
    NSTimer *progressUpdateTimer;
	MBProgressHUD *HUD;
	
	GolfDoctorProjectAppDelegate *appDelegateObj;
    
    MPMoviePlayerViewController *mp;
	NSString *userDefaultVal;
    

    AVAudioPlayer *audioPlyer;
	NSMutableArray *commentsArray;
	
	MPMoviePlayerViewController *playerViewController;
	
    IBOutlet UIButton *videoDescriptionBtn;
    NSString *iUsId;
    NSString *vId ;
	
    IBOutlet UITableView *commentsTbl;
	IBOutlet UIButton *add_cmnt_btn;
    
    IBOutlet UILabel *descriptionText;
	
    IBOutlet UIView *user_view;
	
    IBOutlet UIButton *playAudioButton;
    IBOutlet UIButton *rat1;
    IBOutlet UIButton *rat2;
    IBOutlet UIButton *rat3;
    IBOutlet UIButton *rat4;
    IBOutlet UIButton *rat5;
	
    IBOutlet UIButton *addCommentBtn;
    IBOutlet UIView *empl_view;
    IBOutlet UIButton *addAudioBtn;
    IBOutlet UIButton *addVideoBtn;
	
    IBOutlet UILabel *label_description;
	
	IBOutlet UIView *addtbl_view;
	
	NSMutableArray *valArray;
	
	IBOutlet UILabel *title_lbl;
	IBOutlet UILabel *cmnt_lbl;
	
    IBOutlet UILabel *byUploadEmplName;
	IBOutlet UISegmentedControl *SEGCntrlContacts;
	
    IBOutlet UILabel *byWhomLabel;
	UIImagePickerController *Upload_Picker;
	BOOL pickerFlag;
	
	IBOutlet UIView *addcoment_view;
	IBOutlet UITextField *TxtComment;
	IBOutlet UIButton *Txt_cmnt_btn;
	
	IBOutlet UIView *Audio_view;
	IBOutlet UIButton *upload_audio_btn;
	
	IBOutlet UIView *Video_view;
	IBOutlet UIButton *upload_video_btn;
	
	NSMutableData *Data_video;
	NSMutableArray *text_cmnt_Array;
	NSMutableArray *audio_cmnt_Array;
	NSMutableArray *video_cmnt_Array;
	
	IBOutlet UIImageView *thimbnil_imgView;
	
	UIImageView *image_view;
	
	IBOutlet UIImageView *vd_cmnt_imgView;
	
	IBOutlet UILabel *waiting_lbl;

}


@property (nonatomic, retain)UIImageView *image_view;

@property (nonatomic, retain)UIImageView *thimbnil_imgView;

@property (nonatomic, retain) UIButton *rat1;
@property (nonatomic, retain) UIButton *rat2;
@property (nonatomic, retain) UIButton *rat3;
@property (nonatomic, retain) UIButton *rat4;
@property (nonatomic, retain) UIButton *rat5;
@property (nonatomic,retain)IBOutlet UILabel *byWhomLabel;

@property (nonatomic, retain)NSMutableArray *valArray;
@property (nonatomic, retain)NSMutableArray *commentsArray;
@property (nonatomic, retain) UITableView *commentsTbl;
@property (nonatomic, retain) UITextField *TxtComment;
-(IBAction)rateBtnClick:(id)sender;
-(IBAction)Add_Text_Comment:(id)sender;
-(IBAction)playVedio:(id)sender;

-(IBAction)addComment_clicked:(id)sender;

-(void)setValue:(NSMutableArray*)arr;

-(IBAction)segmentedControlIndexChanged;

-(IBAction)Add_Audio_Comment:(id)sender;
-(IBAction)Add_Video_Comment:(id)sender;

-(void)upload_audio_cnmt_file:(NSData*)data;
-(void)showHUD;
-(void)hideHUD;
-(IBAction)playAudio;

@end
