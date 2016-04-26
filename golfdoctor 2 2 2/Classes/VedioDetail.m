//
//  VedioDetail.m
//  GolfDoctorProject
//
//  Created by APPLE apple on 11/15/11.
//  Copyright (c) 2011 openxcel. All rights reserved.
//

#import "VedioDetail.h"
#import "iPhoneStreamingPlayerViewController.h"

@implementation VedioDetail
@synthesize image_view,commentsTbl,commentsArray,TxtComment,rat1,rat2,rat3,rat4,rat5,valArray,byWhomLabel,thimbnil_imgView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    self.title = @"Video Detail";
	text_cmnt_Array = [[NSMutableArray alloc]init];
	[text_cmnt_Array addObject:@"text1"];
    [text_cmnt_Array addObject:@"text2"];
	
	audio_cmnt_Array = [[NSMutableArray alloc]init];
	[audio_cmnt_Array addObject:@"audio1"];
    [audio_cmnt_Array addObject:@"audio2"];
	video_cmnt_Array = [[NSMutableArray alloc]init];
	[video_cmnt_Array addObject:@"video1"];
    [video_cmnt_Array addObject:@"video2"];
	
	 appDelegateObj = (GolfDoctorProjectAppDelegate *)[[UIApplication sharedApplication]delegate];
    
	Upload_Picker = [[UIImagePickerController alloc]init];
	
	self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    [super viewDidLoad];
	
	userDefaultVal= [[[NSUserDefaults standardUserDefaults] valueForKey:@"Authentication"]retain];
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"Tips"] isEqualToString:@"Tips"]) {
        empl_view.hidden=TRUE;
        user_view.hidden=FALSE;
        userDefaultVal=nil;
        [[NSUserDefaults standardUserDefaults]setValue:@"" forKey:@"Tips"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    else{  
        if ([userDefaultVal isEqualToString:@"User"]) {
        empl_view.hidden=TRUE;
        user_view.hidden=FALSE;
        userDefaultVal=nil;
        }
        if ([userDefaultVal isEqualToString:@"Employee"]) {
        empl_view.hidden=FALSE;
        user_view.hidden=TRUE;
        userDefaultVal=nil;
        }
	}
	
	thimbnil_imgView.layer.cornerRadius = 10.0;
	thimbnil_imgView.layer.borderColor = [UIColor blackColor].CGColor;
	thimbnil_imgView.layer.borderWidth = 0.5;
	[thimbnil_imgView.layer setMasksToBounds:YES];
	
	NSMutableDictionary *dict = (NSMutableDictionary*)self.valArray;
	
	if ([dict objectForKey:@"IconImage"]) {
		[thimbnil_imgView setImage:[self.valArray valueForKey:@"IconImage"]];
	}else {
		EGOImageView *img = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"Placeholder.png"]];
		img.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[dict valueForKey:@"thumb_img"]]];
		img.frame = [thimbnil_imgView bounds];
		[thimbnil_imgView addSubview:img];
		[img release];
	}
	
	if ([dict objectForKey:@"thumb_vd_img"])
	{
		EGOImageView *vd_img = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"Placeholder.png"]];
		vd_img.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[dict valueForKey:@"thumb_vd_img"]]];
		vd_img.frame = [vd_cmnt_imgView bounds];
		[vd_cmnt_imgView addSubview:vd_img];
		[vd_img release];
	}
	
	
	
	
}



-(void)viewWillAppear:(BOOL)animated
{
    
	if (pickerFlag) {
		return;
	}
	
	addcoment_view.hidden = TRUE;
	Audio_view.hidden = TRUE;
	Video_view.hidden = TRUE;
	
	add_cmnt_btn.tag = 1;
	
    addtbl_view.frame = CGRectMake(0, 150, 320, 229);
	commentsTbl.frame = CGRectMake(0, 24, 320, 225);
	
	[rat1 setSelected:NO];
	[rat4 setSelected:NO];
	[rat3 setSelected:NO];
	[rat2 setSelected:NO];
	[rat5 setSelected:NO];
	
	id value = [self.valArray valueForKey:@"employee"];
	NSString *main_str = @"";
	if(value != [NSNull null])
		main_str = (NSString *)value;
	
	if (main_str) {
		byUploadEmplName.text= [NSString stringWithFormat:@"Comment added By %@",main_str];
	}else {
		byUploadEmplName.text = @"";
	}

    
 
    byWhomLabel.text = [NSString stringWithFormat:@"Uploaded By %@",[self.valArray valueForKey:@"vUsername"]];
	title_lbl.text = [self.valArray valueForKey:@"vTitle"];
	cmnt_lbl.text = [self.valArray valueForKey:@"no_comment"];
	
    NSString *vDescription = [NSString stringWithFormat:@"%@",[self.valArray valueForKey:@"vDescription"]];
    NSString *vVideo_desc = [NSString stringWithFormat:@"%@",[self.valArray valueForKey:@"vVideo_desc"]];
    NSString *vAudio_desc=[NSString stringWithFormat:@"%@",[self.valArray valueForKey:@"vAudio_desc"]];
    
	NSLog(@"g : %@",[self.valArray valueForKey:@"vDescription"]);
	
	
	
	
	
	SEGCntrlContacts.selectedSegmentIndex = 0;
	[self segmentedControlIndexChanged];
	
	
	if ([vVideo_desc isEqualToString:@""] &&  [vDescription isEqualToString:@""] && [vAudio_desc isEqualToString:@""]) {
		waiting_lbl.hidden = FALSE;
		videoDescriptionBtn.hidden=TRUE;
		playAudioButton.hidden=TRUE;
		vd_cmnt_imgView.hidden = TRUE;
		return;
	}
	else {
		waiting_lbl.hidden = TRUE;
	}

	
    if ([vDescription isEqualToString:nil] ||[vDescription isEqualToString:@""] ) {
        NSLog(@"T Nil");
        descriptionText.hidden= TRUE;
        videoDescriptionBtn.hidden=FALSE;
		vd_cmnt_imgView.hidden = FALSE;
        playAudioButton.hidden = FALSE;	
        
        
    }
	else{
        descriptionText.hidden= FALSE;
        descriptionText.text = vDescription;
        videoDescriptionBtn.hidden=TRUE;
		vd_cmnt_imgView.hidden = TRUE;
        playAudioButton.hidden = TRUE;
	}
	
	
	
    if ([vVideo_desc isEqualToString:nil]||[vVideo_desc isEqualToString:@""]) {
        //NSLog(@"V Nil");
		 playAudioButton.hidden = FALSE;
		vd_cmnt_imgView.hidden = TRUE;
		videoDescriptionBtn.hidden=TRUE;
		
    }else{
        videoDescriptionBtn.hidden=FALSE;
		vd_cmnt_imgView.hidden = FALSE;
	}
	
	
	
    if ([vAudio_desc isEqualToString:nil]||[vAudio_desc isEqualToString:@""]) {
        //NSLog(@"A Nil");
		 playAudioButton.hidden = TRUE;

    }else{
        videoDescriptionBtn.hidden=TRUE;
		vd_cmnt_imgView.hidden = TRUE;
	}

  
}

-(void)showLoder{
    [self showHUD];
}
-(IBAction)playAudio{
 
	iPhoneStreamingPlayerViewController *streemerObj = [[iPhoneStreamingPlayerViewController alloc]initWithNibName:@"iPhoneStreamingPlayerViewController" bundle:nil];
    streemerObj.urlStr = [NSString stringWithFormat:@"%@",[self.valArray valueForKey:@"vAudio_desc"]];
    [self.navigationController presentModalViewController:streemerObj animated:YES];
    
   
//    AVAudioPlayerSampleViewController *AVPl = [[AVAudioPlayerSampleViewController alloc]initWithNibName:@"AVAudioPlayerSampleViewController" bundle:nil];
//    AVPl.audioFile  = [NSString stringWithFormat:@"%@",[self.valArray valueForKey:@"vAudio_desc"]];
//    [self.navigationController presentModalViewController:AVPl animated:YES];
    
//    NSURL *url = [NSURL URLWithString:[self.valArray valueForKey:@"vAudio_desc"]];
//  	[self destroyStreamer];

 //   AudioStreamer *streamer = [[AudioStreamer alloc] initWithURL:url];	
   // [streamer start];
    
}

-(void)setValue:(NSMutableArray*)arr
{
	self.valArray = [arr copy];
	
	NSLog(@"%@",self.valArray);
}


-(IBAction)segmentedControlIndexChanged
{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.5];
	addtbl_view.frame = CGRectMake(0, 150, 320, 229);
	[UIView commitAnimations];
	
	addcoment_view.hidden = TRUE;
	Audio_view.hidden = TRUE;
	Video_view.hidden = TRUE;
	
	switch(SEGCntrlContacts.selectedSegmentIndex) 
	{
			
		case 0:
			self.commentsArray = [text_cmnt_Array copy];
			[commentsTbl reloadData];
			add_cmnt_btn.tag = 1;
			
			NSLog(@"0");
			
			break;
		case 1:
			
			self.commentsArray = [audio_cmnt_Array copy];
			[commentsTbl reloadData];
			add_cmnt_btn.tag = 2;
			
			NSLog(@"1");
			
			break;
		case 2:
				
			self.commentsArray = [video_cmnt_Array copy];
			[commentsTbl reloadData];
			add_cmnt_btn.tag = 3;
			
			NSLog(@"2");
			
			break;
	}
}




-(IBAction)rateBtnClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    if(btn.selected == YES)
    {
        [btn setSelected:NO];
		if (btn == rat4) {
			[rat5 setSelected:NO];
		}
		if (btn == rat3) {
			[rat5 setSelected:NO];
			[rat4 setSelected:NO];
		}
		if (btn == rat2) {
			[rat5 setSelected:NO];
			[rat4 setSelected:NO];
			[rat3 setSelected:NO];
		}
		if (btn == rat1) {
			[rat5 setSelected:NO];
			[rat4 setSelected:NO];
			[rat3 setSelected:NO];
			[rat2 setSelected:NO];
		}
		
    }
    else
    {
        [btn setSelected:YES];
		if (btn == rat5) {
			[rat1 setSelected:YES];
			[rat4 setSelected:YES];
			[rat3 setSelected:YES];
			[rat2 setSelected:YES];
		}
		if (btn == rat4) {
			[rat1 setSelected:YES];
			[rat3 setSelected:YES];
			[rat2 setSelected:YES];
		}
		
		if (btn == rat3) {
			[rat2 setSelected:YES];
			[rat1 setSelected:YES];
		}
		if (btn == rat2) {
			[rat1 setSelected:YES];
		}
				
    }
    
}

-(IBAction)playVedio:(id)sender
{
	
    UIButton *btn = (UIButton*)sender;
    
    NSURL *url= [[NSURL alloc]init];
    
    if (btn.tag==0) {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[self.valArray valueForKey:@"vName"]]];
    }
    if (btn.tag==1) {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[self.valArray valueForKey:@"vVideo_desc"]]];
    }
    
	
	mp = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
	[[mp moviePlayer] prepareToPlay];
	[[mp moviePlayer] setUseApplicationAudioSession:NO];
	[[mp moviePlayer] setShouldAutoplay:YES];
	[[mp moviePlayer] setControlStyle:2];
	[[mp moviePlayer] setRepeatMode:MPMovieRepeatModeOne];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoPlayBackDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
	[self presentMoviePlayerViewControllerAnimated:mp];
	
}

-(void)videoPlayBackDidFinish:(NSNotification*)notification  {
	
	[[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
	
	[mp.moviePlayer stop];
	mp = nil;
	[mp release];
	[self dismissMoviePlayerViewControllerAnimated];  
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.commentsArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	NSString *cell_str = [NSString stringWithFormat:@"%@",[commentsArray objectAtIndex:indexPath.row]];
	CGSize textSize = [cell_str sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(260, 5000)];

	return textSize.height>40?textSize.height:40;
	//return 160;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    
	NSString *cell_str = [NSString stringWithFormat:@"%@",[self.commentsArray objectAtIndex:indexPath.row]];
	CGSize textSize = [cell_str sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(260, 500000)];
	
	
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		
		
		
		UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, textSize.height>40?textSize.height:40) ];
		img.image = [UIImage imageNamed:@"cellborder.png"];
		//[cell.contentView addSubview:img];
		img=nil;
       
        
		[img release];
		
	}
    
	[cell setSelectionStyle:UITableViewCellStyleDefault];
	cell.textLabel.font = [UIFont fontWithName:@"helvetica" size:13];
	[cell.textLabel setTextColor:[UIColor whiteColor]];
	[cell.textLabel setNumberOfLines:0];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",cell_str];
    cell.backgroundColor = [UIColor redColor];
	cell.textLabel.backgroundColor = [UIColor redColor];

		//[cell addSubview:img];
		
    return cell;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


-(IBAction)addComment_clicked:(id)sender
{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.5];
	addtbl_view.frame = CGRectMake(0,196,320,229);
	commentsTbl.frame = CGRectMake(0, 24, 320, 200);
	[UIView commitAnimations];
	
	UIButton *btn = (UIButton*)sender;
	
	if (btn.tag == 1) {
		
		addcoment_view.hidden = FALSE;
	}
	
	if (btn.tag == 2) {
		
		Audio_view.hidden = FALSE;
	}
	
	if (btn.tag == 3) {
		
		Video_view.hidden = FALSE;
	}
}

-(IBAction)Add_Text_Comment:(id)sender
{
	//UIButton *btn = (UIButton*)sender;
	
	NSString *cmnt_str = [TxtComment.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
       
	if (![cmnt_str isEqualToString:@""]) 
	{
		[self showHUD];
		
		iUsId = [[NSUserDefaults standardUserDefaults] valueForKey:@"user_id"];
		vId = [self.valArray valueForKey:@"vID"];
		
		GdataParser *parser = [[[GdataParser alloc] init]autorelease];
		[parser downloadAndParse:[NSURL URLWithString:[NSString stringWithFormat:@"http://openxcelluk.info/golf/web_services/add_desc.php?iUserID=%@&vID=%@&vDescription=%@",iUsId,vId,cmnt_str]] 
					 withRootTag:@"Record"
						withTags:[NSDictionary dictionaryWithObjectsAndKeys:@"msg",@"msg",nil] 
							 sel:@selector(finishGetData:) 
					  andHandler:self];
		
		iUsId=nil;
		vId=nil;
		cmnt_str=nil;
		
    	
		
		//[commentsArray addObject:[NSString stringWithFormat:@"%@",cmnt_str]];
		//[commentsTbl reloadData];
	}
	TxtComment.text = @"";
	[TxtComment resignFirstResponder];
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.5];
	addtbl_view.frame = CGRectMake(0, 150, 320, 229);
	[UIView commitAnimations];
	commentsTbl.frame = CGRectMake(0, 24, 320, 225);
	addcoment_view.hidden = TRUE;
	
}


-(void)finishGetData:(NSDictionary *)dictinary{
	[self hideHUD];
    NSLog(@"%@",dictinary);
	[self.navigationController popViewControllerAnimated:YES];
}

-(void)showHUD{
	[self hideHUD];
	HUD = [[MBProgressHUD alloc] initWithView:self.view];
	[appDelegateObj.tabBarController.view addSubview:HUD];
    HUD.labelText = @"Processing..";
	[HUD show:YES];
	appDelegateObj.tabBarController.tabBar.userInteractionEnabled = FALSE;
}
-(void)hideHUD{
	if (HUD) {
		[HUD hide:YES];
		[HUD removeFromSuperview];
		[HUD release];
		HUD = nil;
		appDelegateObj.tabBarController.tabBar.userInteractionEnabled = YES;
	}
}

-(IBAction)Add_Audio_Comment:(id)sender
{
	UIViewController *controller = [[UIViewController alloc] initWithNibName:@"recordAudio" bundle:[NSBundle mainBundle]];
	recordAudio *record = (recordAudio *)controller.view;
	record._recoderDelegate=self;
	[record show];
	[controller release];
	
}

-(void)add_audio:(NSData*)data
{
	iUsId = [[NSUserDefaults standardUserDefaults] valueForKey:@"user_id"];
    vId = [self.valArray valueForKey:@"vID"];
    
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter11 = [[[NSDateFormatter alloc] init]autorelease];;
    dateFormatter11.dateFormat = @"yyyyddMMhhmmss";
	
    NSString *strdt11=[dateFormatter11 stringFromDate:now];
    
    NSString *stringFilenm = [NSString stringWithFormat:@"%@.caf",strdt11];
    NSString  *urlstring = [NSString stringWithFormat:@"http://www.openxcelluk.info/golf/web_services/add_audio_desc.php?iUserID=%@&vID=%@",iUsId,vId];
    
    
    NSMutableURLRequest *postRequest = [[[NSMutableURLRequest alloc] init] autorelease];
    [postRequest setURL:[NSURL URLWithString:urlstring]];
    [postRequest setHTTPMethod:@"POST"];
    
    NSString *boundary = [NSString stringWithString:@"---------------------------14737809831466499882746641449"];
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [postRequest addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData  *body = [[[NSMutableData alloc] init]autorelease];
    [postRequest addValue:contentType forHTTPHeaderField: @"Content-Type"];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:@"Content-Disposition: form-data; name=\"userfile\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"userfile\"; filename=\"%@\"\r\n",stringFilenm]] dataUsingEncoding:NSUTF8StringEncoding]]; //img name
    [body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:data]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postRequest setHTTPBody:body];
    
    
    
    NSURLResponse* response;
    NSError* error = nil;
    
    NSData* data1 = [NSURLConnection sendSynchronousRequest:postRequest returningResponse:&response error:&error];
    NSString *result=[[NSString alloc] initWithData:data1 encoding:NSUTF8StringEncoding];
	
	
	NSString * str =[[result JSONValue] valueForKey:@"msg"];
    NSLog(@"str : %@",str);
	
	
    
    NSLog(@"result = %@ ",result );
    
    vId=nil;
    iUsId=nil;
	[result release];
	
    [self hideHUD];
	
	
	if([str isEqualToString:@"Description added successfully"])
	{
		[self.navigationController popViewControllerAnimated:YES];
	}
	
}

-(void)upload_audio_cnmt_file:(NSData*)data
{
	
       
    NSLog(@"POSTING");
    
    [self showHUD];
    [self performSelector:@selector(add_audio:) withObject:data afterDelay:0.5];
    
	
	
}

-(void)upload_video
{
	NSLog(@"POSTING");
	
	iUsId = [[NSUserDefaults standardUserDefaults] valueForKey:@"user_id"];
	vId = [self.valArray valueForKey:@"vID"];
	
	NSDate *now = [NSDate date];
	NSDateFormatter *dateFormatter11 = [[[NSDateFormatter alloc] init]autorelease];
	dateFormatter11.dateFormat = @"yyyyddMMhhmmss";
	
	
	NSString *strdt11=[dateFormatter11 stringFromDate:now];
	
	NSString *stringFilenm = [NSString stringWithFormat:@"%@.mov",strdt11];
	NSString *stringIMGFilenm = [NSString stringWithFormat:@"%@.png",strdt11];
	
	NSString  *urlstring = [NSString stringWithFormat:@"http://www.openxcelluk.info/golf/web_services/add_video_desc.php?iUserID=%@&vID=%@",iUsId,vId];
	
	
	NSMutableURLRequest *postRequest = [[[NSMutableURLRequest alloc] init] autorelease];
	[postRequest setURL:[NSURL URLWithString:urlstring]];
	[postRequest setHTTPMethod:@"POST"];
	
	NSString *boundary = [NSString stringWithString:@"---------------------------14737809831466499882746641449"];
	NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
	[postRequest addValue:contentType forHTTPHeaderField: @"Content-Type"];
	
	NSMutableData  *body = [[[NSMutableData alloc] init]autorelease];
	[postRequest addValue:contentType forHTTPHeaderField: @"Content-Type"];
	
	[body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithString:@"Content-Disposition: form-data; name=\"userfile\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"userfile\"; filename=\"%@\"\r\n",stringFilenm]] dataUsingEncoding:NSUTF8StringEncoding]]; //img name
	[body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[NSData dataWithData:Data_video]]; //
	[body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	
	[body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithString:@"Content-Disposition: form-data; name=\"thumb_img\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"thumb_img\"; filename=\"%@\"\r\n",stringIMGFilenm]] dataUsingEncoding:NSUTF8StringEncoding]]; //img name
	[body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
	
	
	CGRect rect=CGRectMake(0,0,100,100);
	UIGraphicsBeginImageContext(rect.size);
	[image_view.image drawInRect:rect];
	UIImage *picture1 = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	NSData *imageData = UIImagePNGRepresentation(picture1);
	
	
	[body appendData:[NSData dataWithData:imageData]];
	[body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];		
	
	[postRequest setHTTPBody:body];
	
	
	NSURLResponse* response;
	NSError* error = nil;
	
	NSData* data1 = [NSURLConnection sendSynchronousRequest:postRequest returningResponse:&response error:&error];
	NSString *result=[[NSString alloc] initWithData:data1 encoding:NSUTF8StringEncoding];
	
	NSLog(@"result = %@ ",result );
	
	NSString * str =[[result JSONValue] valueForKey:@"msg"];
	NSLog(@"str : %@",str);
	
	
	vId=nil;
	iUsId=nil;
	[result release];
	
	[addVideoBtn setTitle:@"Add" forState:UIControlStateNormal];
	
	
	
	NSLog(@"uplaod success");
	
	image_view = nil;
	[image_view release];
	
	[self hideHUD];
	if([str isEqualToString:@"Description added successfully"])
	{	
		[self.navigationController popViewControllerAnimated:YES];
	}
}

-(IBAction)Add_Video_Comment:(id)sender
{
	GolfDoctorProjectAppDelegate *appDel = (GolfDoctorProjectAppDelegate *)[[UIApplication sharedApplication]delegate];
    
    if (appDel.flagChkVideo == 1) {
        [self showHUD];
		appDel.flagChkVideo=0;
        [self performSelector:@selector(upload_video) withObject:nil afterDelay:0.5];
		
    }
    else {
		
        pickerFlag = TRUE;
        Upload_Picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        Upload_Picker.editing=NO;
        Upload_Picker.delegate = self;
        Upload_Picker.mediaTypes = [NSArray arrayWithObject:(NSString *)kUTTypeMovie];
        Upload_Picker.delegate = self;
        [self presentModalViewController:Upload_Picker animated:YES];
    }
}



#pragma mark -
#pragma mark Image Picker


- (void)imagePickerController:(UIImagePickerController *)pickers didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    GolfDoctorProjectAppDelegate *appDel = (GolfDoctorProjectAppDelegate *)[[UIApplication sharedApplication]delegate];

    
    [Upload_Picker dismissModalViewControllerAnimated:YES];
    //NSString *img = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
	//    [vedioBtn setImage:img forState:UIControlStateNormal];
	
	NSLog(@"got not movie %@ ",info);
	
	NSString *mediaType = [info valueForKey:UIImagePickerControllerMediaType];
    if([mediaType isEqualToString:@"public.movie"])
	{
        NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
            Data_video = [[NSMutableData alloc]initWithContentsOfURL:videoURL];
		if (Data_video != nil) {
			[addVideoBtn setTitle:@"Upload" forState:UIControlStateNormal];
            appDel.flagChkVideo=1;
			
			
			MPMoviePlayerController *player = [[[MPMoviePlayerController alloc] initWithContentURL:videoURL]autorelease];
			UIImage * thumbnail = [player thumbnailImageAtTime:1.0 timeOption:MPMovieTimeOptionNearestKeyFrame];
		
			
			
			image_view = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
			image_view.image = thumbnail;
		}
		
	}
    
}

-(void)viewWillDisappear:(BOOL)animated{
   [audioPlyer stop];
    audioPlyer=nil;
   [audioPlyer release];

}
- (void)viewDidUnload
{
    [audioPlyer stop];
    audioPlyer=nil;
    userDefaultVal=nil;
    [empl_view release];
    empl_view = nil;
    [user_view release];
    user_view = nil;
    [label_description release];
    label_description = nil;
    [addCommentBtn release];
    addCommentBtn = nil;
    [addAudioBtn release];
    addAudioBtn = nil;
    [addVideoBtn release];
    addVideoBtn = nil;
    [byWhomLabel release];
    byWhomLabel = nil;
    [descriptionText release];
    descriptionText = nil;
    [videoDescriptionBtn release];
    videoDescriptionBtn = nil;
    [playAudioButton release];
    playAudioButton = nil;
    [byUploadEmplName release];
    byUploadEmplName = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    
    [empl_view release];
    [user_view release];
    [label_description release];
    [addCommentBtn release];
    [addAudioBtn release];
    [addVideoBtn release];
    [byWhomLabel release];
    [descriptionText release];
    [videoDescriptionBtn release];
    [playAudioButton release];
    [byUploadEmplName release];
    [super dealloc];
}
@end
