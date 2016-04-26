//
//  LoginView.m
//  GolfDoctorProject
//
//  Created by APPLE  on 11/15/11.
//  Copyright 2011 openxcel. All rights reserved.
//

#import "LoginView.h"


@implementation LoginView
@synthesize userName,password;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
	
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
    [super viewDidLoad];
    self.navigationItem.title = @"Login";
    appDelegateObj = (GolfDoctorProjectAppDelegate *)[[UIApplication sharedApplication]delegate];
    NSLog(@"Welcome to login page");
	self.navigationController.navigationBar.tintColor = [UIColor blackColor];
	
	self.navigationController.navigationBar.hidden = TRUE;
    
	
}

-(void)viewWillAppear:(BOOL)animated
{
     
}



-(void)invokeTabbar
{
	
	NSMutableArray *vcArray = [NSMutableArray arrayWithArray:[appDelegateObj.navigationController viewControllers]];
	NSLog(@"%@",vcArray);
	
	appDelegateObj = (GolfDoctorProjectAppDelegate *)[[UIApplication sharedApplication]delegate];
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:1.0];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
	[self.navigationController pushViewController:[appDelegateObj.tabBarController retain] animated:YES];
	[appDelegateObj.tabBarController setSelectedIndex:0];
	[UIView commitAnimations];
	
	
	//UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Logged In Successfully" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//	[alert show];
//	[alert release];
}

-(IBAction)Login
{
	 self.navigationController.navigationBar.hidden = YES;
	
	NSString *username_str = [userName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	NSString *password_str = [password.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	
	if ([username_str isEqualToString:@""]) 
	{
		[customealert showAlert:@"Alert" message:@"Please enter username." delegate:self];
	}else
	if ([password_str isEqualToString:@""]) 
	{
		[customealert showAlert:@"Alert" message:@"Please enter password." delegate:self];
	}else
	{
		if ([appDelegateObj checkInternet]==0) {
			[customealert showAlert:@"Alert" message:@"Please start internet on your device." delegate:self];
		}
		else 
		{
			[self showHUD];
			GdataParser *parser = [[[GdataParser alloc] init]autorelease];
			[parser downloadAndParse:[NSURL URLWithString:[NSString stringWithFormat:@"http://openxcelluk.info/golf/web_services/login.php?vUsername=%@&vPassword=%@&devicetoken=%@",username_str,password_str,appDelegateObj.strToken]] 
						 withRootTag:@"Record"
							withTags:[NSDictionary dictionaryWithObjectsAndKeys:@"iVideoStatus",@"iVideoStatus",@"iUserID",@"iUserID",@"msg",@"msg",@"vRole",@"vRole",nil] 
								 sel:@selector(finishGetData:) 
						  andHandler:self];
            
		}
	}
}
-(void)finishGetData:(NSDictionary*)dictionary{
	[self hideHUD];
	
 //  NSLog(@"Response   %@",dictionary);
    
    NSLog(@"%@",dictionary);
	
	NSString *msg = [NSString stringWithFormat:@"%@",[[[dictionary valueForKey:@"array"]objectAtIndex:0]valueForKey:@"msg"]];
	
	if ([msg isEqualToString:@"Login successful"]) 
	{
		NSString* Purchase = [NSString stringWithFormat:@"%@",[[[dictionary valueForKey:@"array"]objectAtIndex:0]valueForKey:@"iVideoStatus"]];
		[[NSUserDefaults standardUserDefaults]setValue:Purchase forKey:@"isFirst"];
		
		NSString *user_id = [NSString stringWithFormat:@"%@",[[[dictionary valueForKey:@"array"]objectAtIndex:0]valueForKey:@"iUserID"]];
		
		[[NSUserDefaults standardUserDefaults]setValue:user_id forKey:@"user_id"];
		[[NSUserDefaults standardUserDefaults] synchronize];
		
		[[NSUserDefaults standardUserDefaults]setValue:[[[dictionary valueForKey:@"array"]objectAtIndex:0]valueForKey:@"vRole"] forKey:@"role"];
		[[NSUserDefaults standardUserDefaults] synchronize];
               
        [[NSUserDefaults standardUserDefaults]setValue:[NSString stringWithFormat:@"%@",[[[dictionary valueForKey:@"array"]objectAtIndex:0]valueForKey:@"vRole"]] forKey:@"Authentication"];
		[[NSUserDefaults standardUserDefaults] synchronize];
		[self invokeTabbar];
		
	}else 
	{
		[customealert showAlert:@"Alert" message:msg delegate:self];
	}
	
}

-(void)showHUD{
	[self hideHUD];
	HUD = [[MBProgressHUD alloc] initWithView:self.view];
	[self.view addSubview:HUD];
    HUD.labelText = @"Processing..";
	[HUD show:YES];
	self.view.userInteractionEnabled = FALSE;
}
-(void)hideHUD{
	if (HUD) {
		[HUD hide:YES];
		[HUD removeFromSuperview];
		[HUD release];
		HUD = nil;
		self.view.userInteractionEnabled = YES;
	}
}


-(IBAction)userSignUp
{
	signUpObj = [[SignUpView alloc] initWithNibName:@"SignUpView" bundle:nil];
	[self presentModalViewController:signUpObj animated:YES];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[userName resignFirstResponder];
	[password resignFirstResponder];
    
	
}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
