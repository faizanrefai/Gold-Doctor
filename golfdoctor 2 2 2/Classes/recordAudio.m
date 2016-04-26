//
//  recordAudio.m
//  GolfDoctorProject
//
//  Created by apple on 2/3/12.
//  Copyright 2012 fgbfg. All rights reserved.
//

#import "recordAudio.h"


@implementation recordAudio

@synthesize _recoderDelegate;
@synthesize lblAlertTitle;
@synthesize start_btn;
@synthesize stop_btn;
@synthesize play_btn;
@synthesize upload_btn;
@synthesize cancel_btn;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.




-(IBAction)Start_record_audio:(id)sender
{	
	[[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
	[[AVAudioSession sharedInstance] setActive: YES error: nil];
	
	[self audioInitiation];
	play_btn.enabled = NO;
	upload_btn.enabled = NO;
	cancel_btn.enabled = NO;
	stop_btn.enabled = YES;
	start_btn.enabled = NO;
	[audioRecorder record];
	
	
}

-(IBAction)Stop_record_audio:(id)sender
{
	stop_btn.enabled = NO;
    play_btn.enabled = YES;
    start_btn.enabled = YES;
	upload_btn.enabled = YES;
	cancel_btn.enabled = YES;
	
    if (audioRecorder.recording)
    {
		[audioRecorder stop];
    } else if (audioPlayerRecord.playing) {
		[audioPlayerRecord stop];
    }
}


-(IBAction)Play_audio:(id)sender
{
	stop_btn.enabled = YES;
	start_btn.enabled = NO;
	play_btn.enabled = NO;
	upload_btn.enabled = NO;
	cancel_btn.enabled = NO;
	
	if (audioPlayerRecord)
		[audioPlayerRecord release];
	NSError *error;
	
	audioPlayerRecord = [[AVAudioPlayer alloc] 
						 initWithContentsOfURL:audioRecorder.url                                    
						 error:&error];
	
	audioPlayerRecord.delegate = self;
	
	if (error)
		NSLog(@"Error: %@",[error localizedDescription]);
	else
		[audioPlayerRecord play];
}

-(IBAction)Upload_audio:(id)sender
{
    if([_recoderDelegate respondsToSelector:@selector(upload_audio_cnmt_file:)])
		Data_video = [[NSMutableData alloc]initWithContentsOfURL:audioRecorder.url];
		[_recoderDelegate upload_audio_cnmt_file:Data_video];
		[Data_video release];
	[self dismiss:YES];
}


- (void)dialogWillAppear {
	
	play_btn.enabled = NO;
	upload_btn.enabled = NO;
	cancel_btn.enabled = YES;
	stop_btn.enabled = NO;
	start_btn.enabled = YES;
	
	[super dialogWillAppear];
}


- (void)dialogWillDisappear {
	[super dialogWillDisappear];
}


-(void)audioInitiation
{
	NSArray *dirPaths;
	NSString *docsDir;
	if (viewTag == 2) {
		NSFileManager *fileManager = [NSFileManager defaultManager];
		
		[fileManager removeItemAtPath: soundFilePath error:NULL];
		viewTag = 1;
	}
	dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	docsDir = [dirPaths objectAtIndex:0];
	
	soundFilePath = [[docsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"AudioTrack.caf"]] retain];
	NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
	
//	NSDictionary *recordSettings = [NSDictionary 
//									dictionaryWithObjectsAndKeys:
//									[NSNumber numberWithInt:AVAudioQualityMin],
//									AVEncoderAudioQualityKey,
//									[NSNumber numberWithInt:16], 
//									AVEncoderBitRateKey,
//									[NSNumber numberWithInt: 2], 
//									AVNumberOfChannelsKey,
//									[NSNumber numberWithFloat:44100.0], 
//									AVSampleRateKey,
//									nil];
    
    
    
    
    
    
    NSDictionary *recordSettings = [[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:kAudioFormatMPEG4AAC],AVFormatIDKey,
                     [NSNumber numberWithInt:44100.0],AVSampleRateKey,
                     [NSNumber numberWithInt: 2],AVNumberOfChannelsKey,
                     [NSNumber numberWithInt:16],AVLinearPCMBitDepthKey,
                     [NSNumber numberWithBool:NO],AVLinearPCMIsBigEndianKey,
                     [NSNumber numberWithBool:NO],AVLinearPCMIsFloatKey,
                     nil];
  	
	NSError *error = nil;
	
	audioRecorder = [[AVAudioRecorder alloc]
					 initWithURL:soundFileURL
					 settings:recordSettings
					 error:&error];
	
	if (error)
	{
		NSLog(@"error: %@", [error localizedDescription]);
		
	} else {
		[audioRecorder prepareToRecord];
	}
	viewTag = 2;
    
    [recordSettings release];
}


#pragma mark -
#pragma mark AVAudioRecorder & AVAudioPlayer delegate methods
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
	start_btn.enabled = YES;
	stop_btn.enabled = NO;
	play_btn.enabled = YES;
	upload_btn.enabled = YES;
	cancel_btn.enabled = YES;
}
-(void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error
{
	NSLog(@"Decode Error occurred");
}
-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
}
-(void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error
{
	NSLog(@"Encode Error occurred");
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/



- (void)dealloc {
    [super dealloc];
	[start_btn release];
	[stop_btn release];
	[play_btn release];
	[upload_btn release];
}


@end
