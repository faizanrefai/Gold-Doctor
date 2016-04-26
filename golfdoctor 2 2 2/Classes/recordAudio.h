//
//  recordAudio.h
//  GolfDoctorProject
//
//  Created by apple on 2/3/12.
//  Copyright 2012 fgbfg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OverlayView.h"
#import <AVFoundation/AVFoundation.h>


@protocol RecoderDelegate <NSObject>
@optional

-(void)upload_audio_cnmt_file:(NSData*)data;

@end

@interface recordAudio : OverlayView <AVAudioPlayerDelegate,AVAudioRecorderDelegate>{
	
	UILabel *lblAlertTitle;
	id<RecoderDelegate>_recoderDelegate;
	
	UIButton *start_btn;
	UIButton *stop_btn;
	UIButton *play_btn;
	UIButton *upload_btn;
	UIButton *cancel_btn;
	
	NSInteger viewTag;
	NSString *soundFilePath;
	AVAudioRecorder *audioRecorder;
	AVAudioPlayer *audioPlayerRecord;
	
	NSMutableData *Data_video;

}



-(IBAction)Start_record_audio:(id)sender;
-(IBAction)Stop_record_audio:(id)sender;
-(IBAction)Play_audio:(id)sender;
-(IBAction)Upload_audio:(id)sender;

-(void)audioInitiation;


@property(nonatomic, assign)id<RecoderDelegate>_recoderDelegate;
@property(nonatomic, retain) IBOutlet UILabel *lblAlertTitle;
@property(nonatomic, retain) IBOutlet UIButton *start_btn;
@property(nonatomic, retain) IBOutlet UIButton *stop_btn;
@property(nonatomic, retain) IBOutlet UIButton *play_btn;
@property(nonatomic, retain) IBOutlet UIButton *upload_btn;
@property(nonatomic, retain) IBOutlet UIButton *cancel_btn;

@end
