//
//  SearchView.m
//  GolfDoctors
//
//  Created by APPLE apple on 11/15/11.
//  Copyright (c) 2011 openxcel. All rights reserved.
//

#import "SearchView.h"
#import "VedioCustomCell.h"
#import "VedioDetail.h"

@implementation SearchView
@synthesize listTbl,vedioArray,but1,but2,but3,but4,but5,searchBar,imageDownloadsInProgress;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if ([msg isEqualToString:@"no data found"]) {
//        return 0;
//        self.vedioArray=nil;
//        [customealert showAlert:@"Alert" message:msg delegate:self];  
//        
//        //[self dismissModalViewControllerAnimated:YES]; 
//    }	

         return [vedioArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
	static NSString *CellIdentifier = @"VedioCustomCell";
     
	VedioCustomCell *cell = (VedioCustomCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (cell == nil) {			
     NSArray *nib = nil;		
     
        nib = [[NSBundle mainBundle] loadNibNamed:@"VedioCustomCell" owner:nil options:nil];
        cell = [nib objectAtIndex:0];	
     
        
     }
	
		NSMutableDictionary *dict = [self.vedioArray objectAtIndex:indexPath.row];
		
		cell.byCommentAddedLabel.text = [NSString stringWithFormat:@"Commented By %@",[dict valueForKey:@"employee"]];
		cell.byWhomLabel.text= [NSString stringWithFormat:@"Uploaded By %@",[dict valueForKey:@"vUsername"]];
		cell.title_lbl.text = [dict valueForKey:@"vTitle"];
		cell.cmnt_lbl.text = [dict valueForKey:@"no_comment"];
		[cell.noti_btn setHidden:TRUE];
		
	
		if (![dict objectForKey:@"IconImage"])
		{
			[cell.activity startAnimating];
			if (listTbl.dragging == NO && listTbl.decelerating == NO)
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
    [[NSUserDefaults standardUserDefaults]setValue:@"Tips" forKey:@"Tips"];
    [[NSUserDefaults standardUserDefaults] synchronize];
	
	if([[[NSUserDefaults standardUserDefaults]valueForKey:@"role"]isEqualToString:@"User"]){
				
		NSURL *url= [[NSURL alloc]init];
		url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[[self.vedioArray objectAtIndex:indexPath.row]valueForKey:@"vName"]]];
		
		
		mp = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
		[[mp moviePlayer] prepareToPlay];
		[[mp moviePlayer] setUseApplicationAudioSession:NO];
		[[mp moviePlayer] setShouldAutoplay:YES];
		[[mp moviePlayer] setControlStyle:2];
		[[mp moviePlayer] setRepeatMode:MPMovieRepeatModeOne];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoPlayBackDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
		[self presentMoviePlayerViewControllerAnimated:mp];
		

	
	
	
	}
	else {
		NSMutableArray *temp_arr = [[self.vedioArray objectAtIndex:indexPath.row] copy];
		vediodetailObj=[[VedioDetail alloc]initWithNibName:@"VedioDetail" bundle:nil];
		[vediodetailObj setValue:temp_arr];
		[self.navigationController pushViewController:vediodetailObj animated:YES];
		
	}

    
        
    //Faizan
}


-(void)videoPlayBackDidFinish:(NSNotification*)notification  {
	
	[[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
	
	[mp.moviePlayer stop];
	mp = nil;
	[mp release];
	[self dismissMoviePlayerViewControllerAnimated];  
}



-(IBAction)rateBtnClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
	
    if(btn.selected == YES)
    {
        [btn setSelected:NO];
		if (btn.tag == 4) {
			[but5 setSelected:NO];
			NSLog(@"rat5");
		}
		if (btn.tag == 3) {
			NSLog(@"rat5");
			[but5 setSelected:NO];
			[but4 setSelected:NO];
		}
		if (btn.tag == 2) {
			NSLog(@"rat5");
			[but5 setSelected:NO];
			[but4 setSelected:NO];
			[but3 setSelected:NO];
		}
		if (btn.tag == 1) {
			NSLog(@"rat5");
			[but5 setSelected:NO];
			[but4 setSelected:NO];
			[but3 setSelected:NO];
			[but2 setSelected:NO];
		}
		
    }
    else
    {
        [btn setSelected:YES];
    }
    
}

-(void)searchwithKeyWord:(UISearchBar*)SearchB{
  
		
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
	[mysearchBar setShowsCancelButton:YES animated:YES];
	mysearchBar.showsCancelButton=YES;
	return YES;
}
-(BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
	
    [self performSelector:@selector(searchwithKeyWord:) withObject:mysearchBar afterDelay:0.2];
	
	return YES;
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
	[mysearchBar setShowsCancelButton:NO animated:YES];
	[mysearchBar resignFirstResponder];
	
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
	[mysearchBar resignFirstResponder];
	[mysearchBar setShowsCancelButton:NO animated:YES];
}
-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
	
	[self searchwithKeyWord:mysearchBar];
	return YES;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
	
    [super viewDidLoad];
	
	self.title = @"Tips";
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];

    vediodetailObj = [[VedioDetail alloc] initWithNibName:@"VedioDetail" bundle:nil];
	vedioArray = [[NSMutableArray alloc] init];
	
    appDelegateObj = (GolfDoctorProjectAppDelegate *)[[UIApplication sharedApplication]delegate];
	
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithTitle:@"LogOut" style:UIBarButtonItemStyleBordered target:self action:@selector(Logout)];
    [self.navigationItem setRightBarButtonItem:homeButton];
    
    [homeButton release];
    listTbl.rowHeight = 110.0;
    
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
		
		//[self dismissModalViewControllerAnimated:YES];
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
		self.vedioArray = nil;
		[listTbl reloadData];
		
		NSString * usre_id = [[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"];
		[self showHUD];
		GdataParser *parser = [[GdataParser alloc] init];
		[parser downloadAndParse:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.openxcelluk.info/golf/web_services/my_tips.php?iUserID=%@",usre_id]] 
					 withRootTag:@"Record"
						withTags:[NSDictionary dictionaryWithObjectsAndKeys:@"vID",@"vID",@"vUsername",@"vUsername",@"vTitle",@"vTitle",@"vName",@"vName",@"thumb_img",@"thumb_img",@"employee",@"employee",@"vDescription",@"vDescription",@"vVideo_desc",@"vVideo_desc",@"vAudio_desc",@"vAudio_desc",@"msg",@"msg",@"thumb_vd_img",@"thumb_vd_img",nil] 
							 sel:@selector(finishGetData:) 
					  andHandler:self];
	}
}

-(void)finishGetData:(NSDictionary*)dictionary{
	[self hideHUD];
 
    

   	self.vedioArray = [[dictionary valueForKey:@"array"] copy];
	
	if ([[[self.vedioArray objectAtIndex:0] valueForKey:@"msg"] isEqualToString:@"no data found"]) {
		self.vedioArray = nil;
		[listTbl reloadData];
		[customealert showAlert:@"Alert" message:@"No Record Found." delegate:self];
	}
	else {
		[listTbl reloadData];
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
		if(image)
		[appRecord setObject:image forKey:@"IconImage"];
		[image release];
		[data release];
		
		[listTbl reloadData];
		
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
    if ([self.vedioArray count] > 0)
    {
        NSArray *visiblePaths = [listTbl indexPathsForVisibleRows];
        for (NSIndexPath *indexPath in visiblePaths)
        {
            NSMutableDictionary *appRecord = [self.vedioArray objectAtIndex:indexPath.row];
            
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
		VedioCustomCell *cell = (VedioCustomCell*)[listTbl cellForRowAtIndexPath:iconDownloader.indexPathInTableView];
		
		if ([iconDownloader.appRecord objectForKey:@"IconImage"])
		{
			[cell.activity stopAnimating];
			[cell.thumbnil_img setImage:[iconDownloader.appRecord objectForKey:@"IconImage"]];
			
		}
		else
		{
			cell.thumbnil_img.image = [UIImage imageNamed:@"playbutton.png"];
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
    [super viewDidUnload];
	[vediodetailObj release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
