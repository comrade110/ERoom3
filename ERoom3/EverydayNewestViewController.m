//
//  EverydayNewestViewController.m
//  ERoom3
//
//  Created by user on 12-11-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "EverydayNewestViewController.h"
#import <SDwebImage/UIImageView+WebCache.h>

@interface EverydayNewestViewController ()

@end

@implementation EverydayNewestViewController

@synthesize movieController = _movieController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[ClientClass sharedService] findEverydayNewestByCondition:self action:@selector(findEverydayNewestByConditionHandler:) sessionId:[ERConfiger shareERConfiger].sessionID name:nil beginTime:@"20120705" endTime:@"20121101" type:@"4" pageNo:@"1" perPageNum:@"5"];
	
    
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(10, 50, 700, 600)];
    mainView.backgroundColor = [UIColor grayColor];
    
    
    tbView = [[UITableView alloc] initWithFrame:CGRectMake(mainView.frame.size.width+20, 50, 280, 600)];
    tbView.delegate = self;
    tbView.dataSource = self;
    
    
    [self.view addSubview:mainView];
    [self.view addSubview:tbView];
}

-(void)findEverydayNewestByConditionHandler:(id)value{
    if ([value isKindOfClass:[NSError class]]) {
        NSLog(@"Error: %@", value);
        return;
    }
    if ([value isKindOfClass:[SoapFault class]]) {
        NSLog(@"Fault: %@", value);
        return;
    }
    list =(SDZfindEverydayNewestList*)value;
    [tbView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [list count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = nil;
    identifier = @"Cell";
    UITableViewCell *cell;
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    } else{ 
        NSArray *subviews = [[NSArray alloc] initWithArray:cell.contentView.subviews]; 
        for (UIView *subview in subviews) { 
            [subview removeFromSuperview]; 
        } 
    } 
    if (list !=nil) {
        SDZEverydayNewest *newest = [list objectAtIndex:indexPath.row];
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@%@",[ERConfiger shareERConfiger].ip,newest.iconImageRef]];
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 100, 100)];
        [imgView setImageWithURL:url];
        UIImageView *playView = [[UIImageView alloc] initWithFrame:CGRectMake(19, 21, 69, 69)];
        [playView setImage:[UIImage imageNamed:@"recomendplay.png"]];
        
        CGSize size = CGSizeMake(130,45);
        CGSize descSize = [newest.name sizeWithFont:[UIFont systemFontOfSize:11] 
                                   constrainedToSize:size 
                                       lineBreakMode:UILineBreakModeWordWrap
                           ];  
        UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(5, 110, 130, descSize.height)];
        l.text = newest.name;
        l.font = [UIFont systemFontOfSize:11.0f];
        l.numberOfLines = 0;
        l.lineBreakMode = UILineBreakModeCharacterWrap;
        
        [cell.contentView addSubview:l];
        [cell.contentView addSubview:imgView];
        [cell.contentView addSubview:playView];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (list) {
        SDZEverydayNewest *newest =[list objectAtIndex:indexPath.row];
        
        NSString *urlStr = [NSString stringWithFormat:@"http://%@%@",[ERConfiger shareERConfiger].ip,newest.videoRef];
        NSLog(@"%@",urlStr);
        NSURL *url = [NSURL URLWithString:urlStr];
        
        self.movieController = [[MPMoviePlayerController alloc] initWithContentURL:url];
        
        [[NSNotificationCenter defaultCenter] addObserver:self 
                                                 selector:@selector(moviePlayBackDidFinish:) 
                                                     name:MPMoviePlayerPlaybackDidFinishNotification 
                                                   object:nil]; 
        
        [self.movieController setControlStyle:MPMovieControlStyleFullscreen];
        [self.movieController setMovieSourceType:MPMovieSourceTypeStreaming];
        [self.movieController setFullscreen:YES];
        [self.view addSubview:[self.movieController view]];
        
        [self.movieController prepareToPlay];
        [self.movieController play];
    }
    
}

- (void) moviePlayBackDidFinish:(NSNotification*)notification {
    NSError *error = [[notification userInfo] objectForKey:@"error"];
    if (error) {
        NSLog(@"Did finish with error: %@", error);
    }
}
-(void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBarHidden = NO;
    
}
-(void)viewWillDisappear:(BOOL)animated{
    
    self.navigationController.navigationBarHidden = YES;
    
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

@end
