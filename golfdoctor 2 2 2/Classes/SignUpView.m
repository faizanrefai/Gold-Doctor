//
//  SignUpView.m
//  GolfDoctors
//
//  Created by APPLE apple on 11/15/11.
//  Copyright (c) 2011 openxcel. All rights reserved.
//

#import "SignUpView.h"


static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;


@implementation SignUpView
@synthesize loginbtn,SignUpbtn,TxtName,TxtBdate,TxtEmail,TxtPass,TxtConfPass,TxtPhnNo;
@synthesize btnCountry,btnTimeZone,arrayNo,pkrCountry,pkrTime;


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
    [super viewDidLoad];
	self.title = @"Sign Up";
	
	scroll_signup.contentSize = CGSizeMake(320, 500);	
	app_obj = (GolfDoctorProjectAppDelegate*)[[UIApplication sharedApplication]delegate];
	
	self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{	
	str_country = @"";
	str_timezone = @"";
	radio_btn1.selected=NO;
	radio_btn2.selected=YES;	
	//empId_img.hidden = YES;
	//TxtEmpId.hidden = YES;	
	TxtEmpId.enabled = FALSE;
	roll_str = @"User";
}


-(IBAction)countryClicked :(id)sender
{
	[TxtName resignFirstResponder];
	[TxtLastName resignFirstResponder];
	[TxtEmail resignFirstResponder];
	[TxtPass resignFirstResponder];
	[TxtConfPass resignFirstResponder];
	[TxtUserName resignFirstResponder];
	[TxtEmpId resignFirstResponder];
	
	arrayNo = [[NSMutableArray alloc]initWithObjects:@"India",@"USA",@"UK",nil];

	pkrCountry = [[UIPickerView alloc] init];
	pkrCountry.delegate=self;
	pkrCountry.dataSource=self;
	[pkrCountry setShowsSelectionIndicator:YES];
	[pkrCountry selectRow:0 inComponent:0 animated:NO];
	[pkrCountry setTag:1];
	
	UIActionSheet *status = [[[UIActionSheet alloc] initWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n\n" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Set" otherButtonTitles:nil]autorelease];
	status.actionSheetStyle = UIActionSheetStyleBlackOpaque;
	[status setBounds:CGRectMake(0, 0, 320, 250)];
	status.tag=1;
	[status addSubview:pkrCountry];
	[status showInView:self.view];
	[pkrCountry reloadAllComponents];
}
-(IBAction)timeZoneClicked :(id)sender
{
	
	[TxtName resignFirstResponder];
	[TxtLastName resignFirstResponder];
	[TxtEmail resignFirstResponder];
	[TxtPass resignFirstResponder];
	[TxtConfPass resignFirstResponder];
	[TxtUserName resignFirstResponder];
	[TxtEmpId resignFirstResponder];
	
	arrayNo = [[NSMutableArray alloc]initWithObjects:@"UST",@"IST",@"GMT",nil];
	
	pkrTime = [[UIPickerView alloc] init];
	pkrTime.delegate=self;
	pkrTime.dataSource=self;
	[pkrTime setShowsSelectionIndicator:YES];
	[pkrTime selectRow:1 inComponent:0 animated:NO];
	[pkrTime setTag:2];
	
	UIActionSheet *timeSheet = [[[UIActionSheet alloc] initWithTitle:@"Pickup Time\n\n\n\n\n\n\n\n\n\n\n\n" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Set" otherButtonTitles:nil]autorelease];
	timeSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
	[timeSheet setBounds:CGRectMake(0, 0, 320, 250)];
	timeSheet.tag=2;
	[timeSheet addSubview:pkrTime];
	[timeSheet showInView:self.view];
	[pkrTime reloadAllComponents];
}


-(IBAction)RollBtnValueChanged:(id)sender
{
	if ((UIButton*)sender == radio_btn1) 
	{
		radio_btn1.selected=YES;
		radio_btn2.selected=NO;
		roll_str = @"Employee";
		//empId_img.hidden = FALSE;
//		TxtEmpId.hidden = FALSE;
		TxtEmpId.enabled = TRUE;
		
	}else {
		radio_btn1.selected=NO;
		radio_btn2.selected=YES;
		roll_str = @"User";
		//empId_img.hidden = TRUE;
//		TxtEmpId.hidden = TRUE;
		TxtEmpId.enabled = FALSE;
	}
	


}
- (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"; 
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; 
    return [emailTest evaluateWithObject:email];
}

-(IBAction)SignUp
{
    
	
	NSString *fname_str = [TxtName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	NSString *lname_str = [TxtLastName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	NSString *Username_str = [TxtUserName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	NSString *password_str = [TxtPass.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	NSString *confpass_str = [TxtConfPass.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	NSString *email_str = TxtEmail.text;
	NSString *cemail_str = TxtConfEmail.text;
	
	
	
	BOOL mail = [self validateEmailWithString:[NSString stringWithFormat:@"%@",email_str]];
	
	if([fname_str isEqualToString:@""])
	{
		[customealert showAlert:@"Alert" message:@"Please enter your first name." delegate:self];
	}else 
	if ([lname_str isEqualToString:@""]) 
	{
		[customealert showAlert:@"Alert" message:@"Please enter your last name." delegate:self];
	}else
	if (mail==FALSE) 
	{
		[customealert showAlert:@"Alert" message:@"Please enter valid email address." delegate:self];
	}else
	if (![email_str isEqualToString:cemail_str]) {
		[customealert showAlert:@"Alert" message:@"Email address does not matched." delegate:self];
	}else
	if ([Username_str isEqualToString:@""]) 
	{
		[customealert showAlert:@"Alert" message:@"Please enter username." delegate:self];
	}else 
	if ([password_str isEqualToString:@""]) 
	{
		[customealert showAlert:@"Alert" message:@"Please enter password." delegate:self];
	}else 
	if (![password_str isEqualToString:confpass_str]) 
	{
		[customealert showAlert:@"Alert" message:@"Password does not matched." delegate:self];
	}else
	if ([str_country isEqualToString:@""]) 
	{
		[customealert showAlert:@"Alert" message:@"Please select your country." delegate:self];
	}else
	if ([str_timezone isEqualToString:@""]) 
	{
		[customealert showAlert:@"Alert" message:@"Please select timezone." delegate:self];
	}else if([roll_str isEqualToString:@"Employee"])
	{
			NSString *empid_str = [TxtEmpId.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
			if ([empid_str isEqualToString:@""]) 
			{
				[customealert showAlert:@"Alert" message:@"Please enter employee-id." delegate:self];
			}else {
				[self fire_web_webservice];
			}

	}else {
		[self fire_web_webservice];
	}
}


-(void)fire_web_webservice
{
	
	if ([app_obj checkInternet]==0) {
		[customealert showAlert:@"Alert" message:@"Please start internet on your device." delegate:self];
	}
	else 
	{
		[self showHUD];
		GdataParser *parser = [[GdataParser alloc] init];
		[parser downloadAndParse:[NSURL URLWithString:[NSString stringWithFormat:@"http://openxcelluk.info/golf/web_services/registration.php?vUsername=%@&vPassword=%@&vEmail=%@&vFirst=%@&vLast=%@&vCountry=%@&vTimezone=%@&empid=%@&vRole=%@",TxtUserName.text,TxtPass.text,TxtEmail.text,TxtName.text,TxtLastName.text,str_country,str_timezone,TxtEmpId.text,roll_str]] 
					 withRootTag:@"Record"
						withTags:[NSDictionary dictionaryWithObjectsAndKeys:@"msg",@"msg",nil] 
							 sel:@selector(finishGetData:) 
					  andHandler:self];
        
        //Faizan
        
	}
	
}

-(void)finishGetData:(NSDictionary*)dictionary{
	[self hideHUD];
	NSLog(@"%@",[[dictionary valueForKey:@"array"]valueForKey:@"msg"]);
	
	NSString *msg = [NSString stringWithFormat:@"%@",[[[dictionary valueForKey:@"array"]objectAtIndex:0]valueForKey:@"msg"]];
	
	[customealert showAlert:@"Alert" message:msg delegate:self];
	[self dismissModalViewControllerAnimated:YES];	
}

-(IBAction)Cancel:(id)sender
{
	[self dismissModalViewControllerAnimated:YES];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex==0)
	{
		if (actionSheet.tag==1)
		{
			str_country = [[NSString alloc] initWithFormat:@"%@",[arrayNo objectAtIndex:[pkrCountry selectedRowInComponent:0]]];
			
			[btnCountry setTitle:str_country forState:UIControlStateNormal];
			
		}
		else if (actionSheet.tag==2)
		{
			str_timezone = [[NSString alloc] initWithFormat:@"%@",[arrayNo objectAtIndex:[pkrTime selectedRowInComponent:0]]];
			[btnTimeZone setTitle:str_timezone forState:UIControlStateNormal];
		}

	}
}

#pragma mark -
#pragma mark Picker Methods


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
	NSLog(@"%d",[arrayNo count]);
    return [arrayNo count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
	return [arrayNo objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	if (pickerView.tag==1)
	{
		[btnCountry setTitle:[arrayNo objectAtIndex:row] forState:UIControlStateNormal];
		
	}
	else if (pickerView.tag==2)
	{
		[btnTimeZone setTitle:[arrayNo objectAtIndex:row] forState:UIControlStateNormal];
		
	}
}


-(void)showHUD{
	[self hideHUD];
	HUD = [[MBProgressHUD alloc] initWithView:self.view];
	[app_obj.tabBarController.view addSubview:HUD];
    HUD.labelText = @"Processing..";
	[HUD show:YES];
	app_obj.tabBarController.tabBar.userInteractionEnabled = FALSE;
}
-(void)hideHUD{
	if (HUD) {
		[HUD hide:YES];
		[HUD removeFromSuperview];
		[HUD release];
		HUD = nil;
		app_obj.tabBarController.tabBar.userInteractionEnabled = YES;
	}
}


- (void)textFieldDidBeginEditing:(UITextField*)textField
{
    CGRect textFieldRect =[self.view.window convertRect:textField.bounds fromView:textField];
    CGRect viewRect =[self.view.window convertRect:self.view.bounds fromView:self.view];
    CGFloat midline = textFieldRect.origin.y + 1.0 * textFieldRect.size.height;
    CGFloat numerator =midline - viewRect.origin.y- MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator =(MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION)* viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    animatedDistance = floor(162.0 * heightFraction) + 7;
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= animatedDistance;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    [self.view setFrame:viewFrame];
    [UIView commitAnimations];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    [self.view setFrame:viewFrame];
    [UIView commitAnimations];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	//[state resignFirstResponder];
	
	return YES;
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
