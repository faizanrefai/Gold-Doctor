//
//  VedioView.m
//  GolfDoctors
//
//  Created by APPLE apple on 11/15/11.
//  Copyright (c) 2011 openxcel. All rights reserved.
//

#import "VedioView.h"
#import "VedioCustomCell.h"
#import "VedioDetail.h"

@implementation VedioView
@synthesize videoArray,vedioTbl,imageDownloadsInProgress;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}





//
//-(IBAction)rateBtnClick:(id)sender
//{
//    UIButton *btn = (UIButton *)sender;
//    
//    if(btn.selected == YES)
//    {
//        [btn setSelected:NO];
//    }
//    else
//    {
//        [btn setSelected:YES];
//    }
//    
//}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	
	
	self.title = @"My Library";
    vediodetailObj = [[VedioDetail alloc] initWithNibName:@"VedioDetail" bundle:nil];
	//videoArray = [[NSMutableArray alloc] init];
	
    appDelegateObj = (GolfDoctorProjectAppDelegate *)[[UIApplication sharedApplication]delegate];
	
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithTitle:@"LogOut" style:UIBarButtonItemStyleBordered target:self action:@selector(Logout)];
    [self.navigationItem setRightBarButtonItem:homeButton];
    
    [homeButton release];
        
    

    
	//[vedioArray addObject:@"video1"];
//	[vedioArray addObject:@"video2"];
//	[vedioArray addObject:@"video3"];
//	[vedioArray addObject:@"video4"];
//	[vedioArray addObject:@"video5"];
    
    vedioTbl.rowHeight = 110.0;
    
	self.navigationController.navigationBar.tintColor = [UIColor blackColor];
	
	
    // Do any additional setup after loading the view from its nib.
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
    NSLog(@"%@",dictinary);
	
	if ([[[[dictinary valueForKey:@"array"] valueForKey:@"msg"] objectAtIndex:0] isEqualToString:@"divicetoken unset"]) {
		NSMutableArray *vcArray = [NSMutableArray arrayWithArray:[appDelegateObj.navigationController viewControllers]];
		[appDelegateObj.navigationController popToViewController:[vcArray objectAtIndex:0] animated:NO];
		//[appDelegateObj.tabBarController setSelectedIndex:0];
	}else {
		[customealert showAlert:@"Alert" message:@"Unable to logout." delegate:self];
	}
	
}


-(void)viewWillAppear:(BOOL)animated
{
	self.imageDownloadsInProgress = [NSMutableDictionary dictionary];
	[self fire_web_webservice];
	
}

-(void)fire_web_webservice
{
	
	if ([appDelegateObj checkInternet]==0) {
		[customealert showAlert:@"Alert" message:@"Please start internet on your device." delegate:self];
	}
	else 
	{
		
		self.videoArray = nil;
		[vedioTbl reloadData];
		
		NSString * usre_id = [[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"];
		[self showHUD];
		GdataParser *parser = [[GdataParser alloc] init];
		[parser downloadAndParse:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.openxcelluk.info/golf/web_services/my_library.php?iUserID=%@",usre_id]] 
					 withRootTag:@"Record"
						withTags:[NSDictionary dictionaryWithObjectsAndKeys:@"vID",@"vID",@"vUsername",@"vUsername",@"vTitle",@"vTitle",@"vName",@"vName",@"thumb_img",@"thumb_img",@"msg",@"msg",@"notification",@"notification",@"vDescription",@"vDescription",@"vAudio_desc",@"vAudio_desc",@"vVideo_desc",@"vVideo_desc",nil] 
							 sel:@selector(finishGetData:) 
					  andHandler:self];
        
        [parser release];
	}
}

-(void)finishGetData:(NSDictionary*)dictionary{
	[self hideHUD];
	NSLog(@"%@",[dictionary valueForKey:@"array"]);
	
	self.videoArray = [[dictionary valueForKey:@"array"] copy];
	

	if ([[[self.videoArray objectAtIndex:0] valueForKey:@"msg"] isEqualToString:@"no data found"]) {
		self.videoArray = nil;
		[vedioTbl reloadData];
		[customealert showAlert:@"Alert" message:@"No Record Found." delegate:self];
	}
	else {
		[vedioTbl reloadData];
	}
	
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.videoArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"VedioCustomCell";
    
    VedioCustomCell *cell = (VedioCustomCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {			
        NSArray *nib = nil;		
        
        nib = [[NSBundle mainBundle] loadNibNamed:@"VedioCustomCell" owner:nil options:nil];
        cell = [nib objectAtIndex:0];
        
    }	
    
	
	int ratCount = [[[self.videoArray objectAtIndex:indexPath.row] valueForKey:@"no_rating"] intValue];
	
	switch (ratCount) {
		case 5:
			cell.rat1.selected = YES;
			cell.rat2.selected = YES;
			cell.rat3.selected = YES;
			cell.rat4.selected = YES;
			cell.rat5.selected = YES;
			break;
		case 4:
			cell.rat1.selected = YES;
			cell.rat2.selected = YES;
			cell.rat3.selected = YES;
			cell.rat4.selected = YES;
			cell.rat5.selected = NO;
			break;
		case 3:
			cell.rat1.selected = YES;
			cell.rat2.selected = YES;
			cell.rat3.selected = YES;
			cell.rat4.selected = NO;
			cell.rat5.selected = NO;
			break;
		case 2:
			cell.rat1.selected = YES;
			cell.rat2.selected = YES;
			cell.rat3.selected = NO;
			cell.rat4.selected = NO;
			cell.rat5.selected = NO;
			break;
		case 1:
			cell.rat1.selected = YES;
			cell.rat2.selected = NO;
			cell.rat3.selected = NO;
			cell.rat4.selected = NO;
			cell.rat5.selected = NO;
			break;
		default:
			cell.rat1.selected = NO;
			cell.rat2.selected = NO;
			cell.rat3.selected = NO;
			cell.rat4.selected = NO;
			cell.rat5.selected = NO;
			break;
	}
    
    
	NSMutableDictionary *dict = [self.videoArray objectAtIndex:indexPath.row];
	
    cell.byWhomLabel.text = [NSString stringWithFormat:@"Uploaded By %@",[dict valueForKey:@"vUsername"]];
	cell.title_lbl.text = [dict valueForKey:@"vTitle"];
	cell.cmnt_lbl.text = [dict valueForKey:@"no_comment"];
	
	
	if ([[dict objectForKey:@"notification"] isEqualToString:@"1"]) {
		[cell.noti_btn setHidden:FALSE];
		
	}else {
		[cell.noti_btn setHidden:TRUE];
	}

	
	if (![dict objectForKey:@"IconImage"])
	{
		[cell.activity startAnimating];
		if (vedioTbl.dragging == NO && vedioTbl.decelerating == NO)
		{
			[self getImage:dict forIndexPath:indexPath];
		}
		
		cell.thumbnil_img.image = [dict objectForKey:@"IconImage"];                
	}
	else
	{
		[cell.activity stopAnimating];
		cell.thumbnil_img.image = [dict objectForKey:@"IconImage"];
	}
	
	
    cell.tag= indexPath.row;
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = FALSE;
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSMutableArray *temp_arr = [[self.videoArray objectAtIndex:indexPath.row] copy];
	
    if(vediodetailObj){
        vediodetailObj =nil;
        [vediodetailObj release];
    }
    vediodetailObj = [[VedioDetail alloc] initWithNibName:@"VedioDetail" bundle:nil];
    [vediodetailObj setValue:temp_arr];
	
	if ([appDelegateObj checkInternet]==0) {
		[customealert showAlert:@"Alert" message:@"Please start internet on your device." delegate:self];
	}
	else 
	{
		[self showHUD];
		GdataParser *parser = [[GdataParser alloc] init];
		[parser downloadAndParse:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.openxcelluk.info/golf/web_services/uncheck_notification.php?vID=%@",[temp_arr valueForKey:@"vID"]]] 
					 withRootTag:@"Record"
						withTags:[NSDictionary dictionaryWithObjectsAndKeys:@"msg",@"msg",nil] 
							 sel:@selector(finishGetDataPush:) 
					  andHandler:self];
        
        
	}
    [temp_arr release];
}

-(void)finishGetDataPush:(NSDictionary *)dictinary{
	[self hideHUD];
    NSLog(@"%@",dictinary);
	
	[self.navigationController pushViewController:vediodetailObj animated:YES];
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








#pragma mark Image Caching Methods



- (void) getImage:(NSMutableDictionary*)appRecord forIndexPath:(NSIndexPath *)indexPath
{
	NSString *ImageURLString = [appRecord objectForKey:@"thumb_img"];
	NSMutableString *tmpStr = [NSMutableString stringWithString:ImageURLString];
	[tmpStr replaceOccurrencesOfString:@"/" withString:@"-" options:1 range:NSMakeRange(0, [tmpStr length])];
	
	NSString *filename = [NSString stringWithFormat:@"%@",tmpStr];
	//NSString *uniquePath = [TMP stringByAppendingPathComponent: filename];
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *cacheDirectory = [paths objectAtIndex:0];
	NSString *uniquePath = [cacheDirectory stringByAppendingPathComponent:filename];
	
	UIImage *image;
	
	// Check for a cached version
	if([[NSFileManager defaultManager] fileExistsAtPath: uniquePath])
	{
		NSData *data = [[NSData alloc] initWithContentsOfFile:uniquePath];
		image = [[UIImage alloc] initWithData:data] ; // this is the cached image
		[appRecord setObject:image forKey:@"IconImage"];
		[image release];
		[data release];
		
		[vedioTbl reloadData];
		
	}
	else
	{
		// get a new one
		[self startIconDownload:appRecord forIndexPath:indexPath];
		
	}
}



#pragma mark -
#pragma mark Table cell image support

- (void)startIconDownload:(NSMutableDictionary *)appRecord forIndexPath:(NSIndexPath *)indexPath
{
    IconDownloader *iconDownloader = [imageDownloadsInProgress objectForKey:indexPath];
    if (iconDownloader == nil) 
    {
        iconDownloader = [[IconDownloader alloc] init];
        iconDownloader.appRecord = appRecord;
        iconDownloader.indexPathInTableView = indexPath;
        iconDownloader.delegate = self;
        [imageDownloadsInProgress setObject:iconDownloader forKey:indexPath];
        [iconDownloader startDownload];
        [iconDownloader release];   
    }
}

// this method is used in case the user scrolled into a set of cells that don't have their app icons yet
- (void)loadImagesForOnscreenRows
{
    if ([self.videoArray count] > 0)
    {
        NSArray *visiblePaths = [vedioTbl indexPathsForVisibleRows];
        for (NSIndexPath *indexPath in visiblePaths)
        {
            NSMutableDictionary *appRecord = [self.videoArray objectAtIndex:indexPath.row];
            
            if (![appRecord objectForKey:@"IconImage"]) // avoid the app icon download if the app already has an icon
            {
                [self startIconDownload:appRecord forIndexPath:indexPath];
            }
        }
    }
}

// called by our ImageDownloader when an icon is ready to be displayed
- (void)appImageDidLoad:(NSIndexPath *)indexPath
{
    IconDownloader *iconDownloader = [imageDownloadsInProgress objectForKey:indexPath];
    if (iconDownloader != nil)
    {
		
		
		VedioCustomCell *cell = (VedioCustomCell*)[vedioTbl cellForRowAtIndexPath:iconDownloader.indexPathInTableView];
		
		if ([iconDownloader.appRecord objectForKey:@"IconImage"])
		{
			[cell.activity stopAnimating];
			[cell.thumbnil_img setImage:[iconDownloader.appRecord objectForKey:@"IconImage"]];
		}
		else
		{
			cell.thumbnil_img.image = [UIImage imageNamed:@"Placeholder.png"];
		}
		
    }
}


#pragma mark -
#pragma mark Deferred image loading (UIScrollViewDelegate)

// Load images for all onscreen rows when scrolling is finished
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
	{
        [self loadImagesForOnscreenRows];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self loadImagesForOnscreenRows];
}






- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
	
	NSArray *allDownloads = [self.imageDownloadsInProgress allValues];
    [allDownloads makeObjectsPerformSelector:@selector(cancelDownload)];
	
	
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}



- (void)viewDidUnload
{
   
    [vediodetailObj release];
    
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
