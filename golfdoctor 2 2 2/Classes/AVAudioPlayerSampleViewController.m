//
//  AVAudioPlayerSampleViewController.m
//  AVAudioPlayerSample
//
//  Created by guvenergokce on 8/25/09.
//  Copyright RIA/Cocoa Developer 2009. All rights reserved.
//

#import "AVAudioPlayerSampleViewController.h"

#import <AVFoundation/AVAudioSession.h>



@implementation AVAudioPlayerSampleViewController
@synthesize audioFile;




// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	// If you want to let your user change volume in App, uncomment these lines
	
	 MPVolumeView *volumeView = [[MPVolumeView alloc] initWithFrame:CGRectMake(25, 340, 270, 30)];
	 [self.view addSubview:volumeView];
	 [volumeView release];
	
	isPlaying = NO;

}

-(void)playMovie
{
	if(!isPlaying)
	{
		
		if(audioPlayer == nil )		
		{
			data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.audioFile]]];
           
            audioPlayer =  [[AVAudioPlayer alloc] initWithData:data error:NULL];
			[audioPlayer setDelegate:self];
			
			[[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
			[[AVAudioSession sharedInstance] setActive: YES error: nil];

			
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopSpin)	name:nil object:audioPlayer];
                       
		}
		
        [self setButtonImage:[UIImage imageNamed:@"stopbutton.png"]];
        
		BOOL plays = [audioPlayer play];
		if(plays)
		{
            NSLog(@"OK!");
            NSLog(@"OK! %0.f",audioPlayer.duration);
            NSLog(@"OK! %u",[data length]/2^20);

        }
		isPlaying = YES;
	}
	else
	{
		[self pauseMovie];
	}
}

- (void)audioPlayerDidFinishPlaying: (AVAudioPlayer*)player successfully: (BOOL)flag
{
	[self pauseMovie];
    [self setButtonImage:[UIImage imageNamed:@"playbutton.png"]];
}

-(void) pauseMovie
{
	isPlaying = NO;
	[audioPlayer pause];
}


/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
 }
 */




-(IBAction)doneButtonPressed{
    [audioPlayer stop];
    [audioPlayer release];
    audioPlayer=nil;
    
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)buttonPressed:(id)sender
{
       
    if ([button.currentImage isEqual:[UIImage imageNamed:@"playbutton.png"]])
    	{
    		[self setButtonImage:[UIImage imageNamed:@"loadingbutton.png"]];
            [self playMovie];
              
    	}
        else{
            [audioPlayer stop];
            [self setButtonImage:[UIImage imageNamed:@"playbutton.png"]];
        }
    
    
}


- (void)setButtonImage:(UIImage *)image
{
	[button.layer removeAllAnimations];
	if (!image)
	{
		[button setImage:[UIImage imageNamed:@"playbutton.png"] forState:0];
	}
	else
	{
		[button setImage:image forState:0];
		
		if ([button.currentImage isEqual:[UIImage imageNamed:@"loadingbutton.png"]])
		{
			[self spinButton];

		}
	}
}
- (void)spinButton
{
	[CATransaction begin];
	[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
	CGRect frame = [button frame];
	button.layer.anchorPoint = CGPointMake(0.5, 0.5);
	button.layer.position = CGPointMake(frame.origin.x + 0.5 * frame.size.width, frame.origin.y + 0.5 * frame.size.height);
	[CATransaction commit];
    
	[CATransaction begin];
	[CATransaction setValue:(id)kCFBooleanFalse forKey:kCATransactionDisableActions];
	[CATransaction setValue:[NSNumber numberWithFloat:20] forKey:kCATransactionAnimationDuration];
    
	CABasicAnimation *animation;
	animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
	animation.fromValue = [NSNumber numberWithFloat:1];
	animation.toValue = [NSNumber numberWithFloat:10];
	animation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear];
	animation.delegate = self;
    	animation.duration = 5;
	[button.layer addAnimation:animation forKey:@"rotationAnimation"];
    [CATransaction commit];
}


/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];		
	// Start playin as soon as view appeared
//	[self playMovie:nil];
	
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
//	[self pauseMovie];
}


- (void)dealloc {
	
    [audioFile release];
	[audioPlayer release];
	[audioFile release];
  //  [volumeView release];
    [button release];
    [doneButton release];
    [super dealloc];
}
- (void)viewDidUnload {
  //  [volumeView release];
  //  volumeView = nil;
    [button release];
    button = nil;
    [doneButton release];
    doneButton = nil;
    [super viewDidUnload];
}
@end
