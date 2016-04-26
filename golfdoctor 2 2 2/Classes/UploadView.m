//
//  UploadView.m
//  GolfDoctors
//
//  Created by APPLE apple on 11/15/11.
//  Copyright (c) 2011 openxcel. All rights reserved.
//

#import "UploadView.h"



@implementation UploadView
@synthesize picker,btnUpload,btnUVideo,vedioBtn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
	;
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
    [super viewDidLoad];
	self.title = @"Upload";
    
	picker = [[UIImagePickerController alloc]init];
    appDelegateObj = (GolfDoctorProjectAppDelegate *)[[UIApplication sharedApplication]delegate];
	//NSMutableArray *vcArray = [NSMutableArray arrayWithArray:[appDelegateObj.navigationController viewControllers]];

    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithTitle:@"LogOut" style:UIBarButtonItemStyleBordered target:self action:@selector(Logout)];
    [self.navigationItem setRightBarButtonItem:homeButton];
    
    [homeButton release];
    
	self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    // Do any additional setup after loading the view from its nib.
	[btnUVideo setHidden:YES];
	
	NSString *tempPath = [NSString stringWithFormat:@"%@/sample1.mov", NSTemporaryDirectory()];
	UISaveVideoAtPathToSavedPhotosAlbum (tempPath, self, nil, nil);
    
 
	
}

-(void)viewWillAppear:(BOOL)animated
{
    NSString*   userDefaultVal= [[[[NSUserDefaults standardUserDefaults] valueForKey:@"Authentication"]retain] autorelease];
    if ([userDefaultVal isEqualToString:@"User"]) 
	{
		NSString* Purchase = [[NSUserDefaults standardUserDefaults]valueForKey:@"isFirst"];
		if (![Purchase isEqualToString:@"0"]) 
		{
			btnUpload.hidden=FALSE;
			btnUVideo.hidden=TRUE;
			userDefaultVal=nil;
		}
		else 
		{
			btnUpload.hidden=TRUE;
			btnUVideo.hidden=FALSE;
			userDefaultVal=nil;
		}
    }
    if ([userDefaultVal isEqualToString:@"Employee"]) {
        btnUpload.hidden=TRUE;
        btnUVideo.hidden=FALSE;
        userDefaultVal=nil;
        //[userDefaultVal release];

    }
	
}

-(void)Logout
{
	if ([appDelegateObj checkInternet]==0) {
		[customealert showAlert:@"Alert" message:@"Please start internet on your device." delegate:self];
	}
	else 
	{
		
		NSString *userId = [[NSUserDefaults standardUserDefaults] valueForKey:@"user_id"];
		
		[self showHUD];
		GdataParser *parser = [[GdataParser alloc] init];
		[parser downloadAndParse:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.openxcelluk.info/golf/web_services/unset_devicetoken.php?iUserID=%@",userId]] 
					 withRootTag:@"Root"
						withTags:[NSDictionary dictionaryWithObjectsAndKeys:@"msg",@"msg",nil] 
							 sel:@selector(finishGetDataNoti:) 
					  andHandler:self];
        
        [parser release];
	}
	
	
}


-(void)finishGetDataNoti:(NSDictionary *)dictinary{
	[self hideHUD];
    NSLog(@"%@",[[[dictinary valueForKey:@"array"] valueForKey:@"msg"] objectAtIndex:0]);
	
	if ([[[[dictinary valueForKey:@"array"] valueForKey:@"msg"] objectAtIndex:0]isEqualToString:@"divicetoken unset"]) {
		NSMutableArray *vcArray = [NSMutableArray arrayWithArray:[appDelegateObj.navigationController viewControllers]];
		[appDelegateObj.navigationController popToViewController:[vcArray objectAtIndex:0] animated:NO];
		//[appDelegateObj.tabBarController setSelectedIndex:0];
		//[self dismissModalViewControllerAnimated:YES];
	}else {
		[customealert showAlert:@"Alert" message:@"Unable to logout." delegate:self];
	}

}


-(IBAction)getVedio:(id)sender
{
//    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"Select Image" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera",@"Library",nil];
//    [actionSheet showInView:self.tabBarController.view];
//    [actionSheet release];

}

-(IBAction)buyClicked :(id)sender
{
	NSLog(@"start");
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:TRUE];
	
    if(paymentObserver)
		return;
	
	paymentObserver = [[CustomStoreObserver alloc] init];
	paymentObserver.paymentDelegate = self;
	
	[paymentObserver buyProduct:@"com.Golfdoctors.golfdoctors.golfinapp1"];
}

#pragma mark -
#pragma mark Custom Store delegate

- (void)completePaymentTransaction{
	[paymentObserver release];
	paymentObserver = nil;
    
	NSLog(@"success");
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:FALSE];
	
	[self showHUD];
	NSString *userId = [[NSUserDefaults standardUserDefaults] valueForKey:@"user_id"];
	GdataParser *parser = [[GdataParser alloc] init];
	[parser downloadAndParse:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.openxcelluk.info/golf/web_services/update_vdo_upload_status.php?iUserID=%@",userId]] 
				 withRootTag:@"Root"
					withTags:[NSDictionary dictionaryWithObjectsAndKeys:@"msg",@"msg",nil] 
						 sel:@selector(finishBuy:) 
				  andHandler:self];
	
	[parser release];
}

-(void)finishBuy:(NSDictionary *)dictinary
{
	[self hideHUD];
	[customealert showAlert:@"Alert" message:@"You have credit for video upload.!!" delegate:self];
	[btnUpload setHidden:YES];
	[btnUVideo setHidden:NO];
	[[NSUserDefaults standardUserDefaults]setValue:@"0" forKey:@"isFirst"];
	
}


- (void)paymentTransactionFail{
	[paymentObserver release];
	paymentObserver = nil;
	
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:FALSE];
	[customealert showAlert:@"Alert" message:@"Fail to buy credit for video upload.!!" delegate:self];
	
	NSLog(@"fail");
}







-(IBAction)UploadVideo:(id)sender
{
//    [btnUpload setHidden:NO];
//	[btnUVideo setHidden:YES];
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"Select Image" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera",@"Library",nil];
    [actionSheet showInView:self.tabBarController.view];
    [actionSheet release];

 	
	//[self showHUD];
	//[self performSelector:@selector(startUploadingVideo) withObject:nil afterDelay:0.01];
	
}


-(void)startUploadingVideo
{
    [self showHUD];
    [self performSelector:@selector(upload_video:) withObject:Data_video afterDelay:0.5];
	//[self upload_video:[Data_video copy]];
	Data_video = nil;
	[Data_video release];
}


-(void)upload_video:(NSMutableData *)fileData
{
	
	if (fileData == nil) {
	//	[customealert showAlert:@"Alert" message:@"Please select video." delegate:self];
	}
	else {
		
	NSLog(@"POSTING");
	
	NSDate *now = [NSDate date];
	NSDateFormatter* dateFormatter11 = [[NSDateFormatter alloc] init];
	dateFormatter11.dateFormat = @"yyyyddMMhhmmss";
	
    
	NSString *strdt11=[dateFormatter11 stringFromDate:now];
    NSString *stringFilenm = [NSString stringWithFormat:@"%@.MOV",strdt11];
	NSString *stringIMGFilenm = [NSString stringWithFormat:@"%@.png",strdt11];
	NSLog(@"user id = %@",[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"]);
	
	
	NSString *url1 = [ NSString stringWithFormat:@"http://www.openxcelluk.info/golf/web_services/vdo_upload.php?iUserID=%@&file_title=%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"],stringFilenm];
    NSMutableURLRequest *postRequest = [[[NSMutableURLRequest alloc] init] autorelease];
    [postRequest setURL:[NSURL URLWithString:url1]];
    [postRequest setHTTPMethod:@"POST"];
        
    NSString *boundary = [NSString stringWithString:@"---------------------------14737809831466499882746641449"];
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [postRequest addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
	NSMutableData * body = [[[NSMutableData alloc] init]autorelease];
    [postRequest addValue:contentType forHTTPHeaderField: @"Content-Type"];
	
		//for Video 
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:@"Content-Disposition: form-data; name=\"userfile\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"userfile\"; filename=\"%@\"\r\n",stringFilenm]] dataUsingEncoding:NSUTF8StringEncoding]]; //img name
    [body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:fileData]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
		//for image
	[body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithString:@"Content-Disposition: form-data; name=\"thumb_img\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"thumb_img\"; filename=\"%@\"\r\n",stringIMGFilenm]] dataUsingEncoding:NSUTF8StringEncoding]]; //img name
	[body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
	
	
	CGRect rect=CGRectMake(0,0,70,80);
	UIGraphicsBeginImageContext( rect.size );
	[image_view.image drawInRect:rect];
	UIImage *picture1 = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	NSData *imageData = UIImagePNGRepresentation(picture1);
		
	
	[body appendData:[NSData dataWithData:imageData]];
	[body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    	
	[postRequest setHTTPBody:body];
    
    
    NSURLResponse* response;
    NSError* error = nil;
    
    NSData* data = [NSURLConnection sendSynchronousRequest:postRequest returningResponse:&response error:&error];
    NSString *result=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog(@"result = %@ ",[[result JSONValue] valueForKey:@"msg"]);
    
		if ([[[result JSONValue] valueForKey:@"msg"] isEqualToString:@"Success"]) 
		{
			[customealert showAlert:@"Alert" message:@"Thank you for submitting your video." delegate:self];
			[[NSUserDefaults standardUserDefaults]setValue:@"1" forKey:@"isFirst"];
			[self viewWillAppear:NO];
		}
		else {
			[customealert showAlert:@"Alert" message:@"System failure in submitting your video." delegate:self];
		}

		
   
        
    [result release];
	}
    
	image_view.image = nil;
    
	[self hideHUD];
}


-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	[webData setLength: 0];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[webData appendData:data];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	
	[self hideHUD];
	[customealert showAlert:@"Error" message:@"Error while setting connection." delegate:self];
	NSLog(@"ERROR with theConenction");
	[connection release];
	[webData release];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
	NSString *theXML = [[NSString alloc] initWithBytes: [webData mutableBytes] length:[webData length] encoding:NSUTF8StringEncoding];
	NSLog(@"xml : %@",theXML);
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Video uploaded successfully" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
	[alert show];
	[alert release];
	
	[self hideHUD];
	[connection release];
	[webData release];
    [theXML release];
}	




-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 0) {
      //  UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        //picker = [[UIImagePickerController alloc]init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.delegate = self;
        picker.mediaTypes = [NSArray arrayWithObject:(NSString *)kUTTypeMovie];
        picker.editing=NO;
        [self presentModalViewController:picker animated:YES];				
        
    }		
    if(buttonIndex ==1) {
      //  UIImagePickerController *picker;
        //picker = [[UIImagePickerController alloc]init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.editing=NO;
        picker.delegate = self;
		picker.mediaTypes = [NSArray arrayWithObject:(NSString *)kUTTypeMovie];
		picker.delegate = self;
        [self presentModalViewController:picker animated:YES];
		
	}        
        

}

#pragma mark -
#pragma mark Image Picker
    
	
- (void)imagePickerController:(UIImagePickerController *)pickers didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissModalViewControllerAnimated:YES];
    //NSString *img = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
//    [vedioBtn setImage:img forState:UIControlStateNormal];
	
//	NSLog(@"got not movie");
    

	
	NSString *mediaType = [info valueForKey:UIImagePickerControllerMediaType];
    if([mediaType isEqualToString:@"public.movie"])
	{
		
		NSLog(@"got a movie");
		if (Data_video) {
			Data_video = nil;
            [Data_video release];
        }
		
        NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
		Data_video = [[NSMutableData alloc]initWithContentsOfURL:videoURL];
		//Data_video = [NSData dataWithContentsOfURL:videoURL];

        [vedioBtn setImage:nil forState:UIControlStateNormal];
        
        MPMoviePlayerController *player = [[[MPMoviePlayerController alloc] initWithContentURL:videoURL]autorelease];
        UIImage * thumbnail = [player thumbnailImageAtTime:1.0 timeOption:MPMovieTimeOptionNearestKeyFrame];
        
		
		CGRect rect=CGRectMake(0,0,173,156);
		UIGraphicsBeginImageContext( rect.size );
		[thumbnail drawInRect:rect];
		UIImage *picture1 = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
		
		
		image_view.image = picture1;
		
		
	
		//[vedioBtn setImage:thumbnail forState:UIControlStateNormal];
        player = nil;
             
		
		[self performSelector:@selector(startUploadingVideo) withObject:nil afterDelay:0.1];
	}
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

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
