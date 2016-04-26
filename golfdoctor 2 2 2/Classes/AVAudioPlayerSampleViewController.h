//
//  AVAudioPlayerSampleViewController.h
//  AVAudioPlayerSample
//
//  Created by guvenergokce on 8/25/09.
//  Copyright RIA/Cocoa Developer 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AVFoundation/AVAudioPlayer.h>
#import <MediaPlayer/MediaPlayer.h>
#import <QuartzCore/CoreAnimation.h>
#import <CFNetwork/CFNetwork.h>

@interface AVAudioPlayerSampleViewController : UIViewController <AVAudioPlayerDelegate> {

    IBOutlet UIButton *doneButton;
	NSDictionary *musicObject;
    IBOutlet UIButton *button;
	AVAudioPlayer *audioPlayer;
	NSString *audioFile;
	BOOL isPlaying;
    NSData *data;
    NSTimer *progressUpdateTimer;

}

@property (nonatomic,retain) NSString *audioFile;

-(void)playMovie;
-(void) pauseMovie;
- (IBAction)buttonPressed:(id)sender;
- (void)spinButton;
- (void)setButtonImage:(UIImage *)image;
-(void)stopSpin;


@end

