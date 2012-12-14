//
//  ERTabBarController.m
//  ERoom3
//
//  Created by user on 12-10-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ERTabBarController.h"
#import <SDwebImage/UIImageView+WebCache.h>
#import <SDwebImage/UIButton+WebCache.h>
#import "FunctionViewController.h"

@implementation ERTabBarController

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
    
    [self hideExistingTabBar];
    UIImageView *bgIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    
    bgIV.image = [UIImage imageNamed:@"sbox_backgroud.jpg"];
    
    [self.view addSubview:bgIV];
    
    [self.view sendSubviewToBack:bgIV];
    
    [[ClientClass sharedService] createSession:self action:@selector(createSessionHandler:)];

    
	// Do any additional setup after loading the view.
    
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
}


- (void)hideExistingTabBar
{
	for(UIView *view in self.view.subviews)
	{
		if([view isKindOfClass:[UITabBar class]]||[view isKindOfClass:[UIToolbar class]])
		{
			view.hidden = YES;
			break;
		}
	}
}

-(void)tabWasSelected:(NSInteger)index {
    
    self.selectedIndex = index;
    NSLog(@"%d",index);
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

#pragma mark - soap api

-(void)createSessionHandler:(id)value{
    
    if ([value isKindOfClass:[NSError class]]) {
        NSLog(@"Error: %@", value);
        return;
    }
    if ([value isKindOfClass:[SoapFault class]]) {
        NSLog(@"Fault: %@", value);
        return;
    }
    [ERConfiger shareERConfiger].sessionID = (NSString*)value;
    
    NSLog(@"wtf %@",[ERConfiger shareERConfiger].sessionID);
    
    [[ClientClass sharedService] setRoom:self action:@selector(setRoomHandler:) sessionId: [ERConfiger shareERConfiger].sessionID macAddress:@"xxx1" roomNo:@"xxx1" ip:@"xxx2"];

}

-(void)setRoomHandler:(id)value{
    
    if ([value isKindOfClass:[NSError class]]) {
        NSLog(@"Error: %@", value);
        return;
    }
    if ([value isKindOfClass:[SoapFault class]]) {
        NSLog(@"Fault: %@", value);
        return;
    }
    SDZRoom *result = (SDZRoom*)value;
    
    NSLog(@"~~~~%@",result);
    request = [[ClientClass sharedService] getPlatformConfiguration:self action:@selector(getPlatformConfiguration:) sessionId: [ERConfiger shareERConfiger].sessionID];
    

}
-(void)getPlatformConfiguration:(id)value{
    
    if ([value isKindOfClass:[NSError class]]) {
        NSLog(@"Error: %@", value);
        return;
    }
    if ([value isKindOfClass:[SoapFault class]]) {
        NSLog(@"Fault: %@", value);
        return;
    }
    NSString *result = (NSString*)value;
    
    CXMLDocument *document = [[CXMLDocument alloc] initWithXMLString:result options:0 error:nil];
    
    SOAPXMlParse *sxp = [[SOAPXMlParse alloc] init];
    
    erTabBarView = [[ERTabBarView alloc] init];
    
    erTabBarView.delegate = self;
    
    
    viewArr = [[NSMutableArray alloc] init];
    
    [self.view addSubview:erTabBarView];
    NSArray *tempArr = [sxp parseDire:document nodeName:@"//menu"];
    NSArray *hotelCfgArr = [sxp parseDire2:document nodeName:@"//root"];
    
    NSDictionary *hotelCfgDic = [[hotelCfgArr objectAtIndex:0] objectForKey:@"root"];
    
    NSString *ip = [hotelCfgDic objectForKey:@"idcServer"];
    
    
    NSString *welcomeMsg = [hotelCfgDic objectForKey:@"welcomeMsg"];
    
    UIWebView *welcomeView = [[UIWebView alloc] initWithFrame:CGRectMake(50, 100, 800, 140)];
    welcomeView.backgroundColor =[UIColor clearColor];
    welcomeView.opaque = NO;
    welcomeView.scalesPageToFit = YES;
    welcomeView.scrollView.scrollEnabled = NO;
    [welcomeView loadHTMLString:welcomeMsg baseURL:[NSURL URLWithString:welcomeMsg]]; 
    
    
    [self.view addSubview:welcomeView];
    [ERConfiger shareERConfiger].configArr = tempArr;
    [ERConfiger shareERConfiger].ip = ip;
    
    
    
    int btnCount = [tempArr count];
    
    for (int i=0; i<btnCount; i++) {
        
        NSDictionary *tempDic = [[tempArr objectAtIndex:i] objectForKey:@"menu"];
        
        UIButton *menuBtns = [UIButton buttonWithType:UIButtonTypeCustom];
        
        menuBtns.frame = CGRectMake((1024-(100*btnCount))*0.5+i*100, 10, 85, 85);

        
        menuBtns.tag = 10+i;
        
        [menuBtns addTarget:erTabBarView action:@selector(touchButton:) forControlEvents:UIControlEventTouchUpInside];

        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@%@",ip,[tempDic objectForKey:@"img"]]];
        NSURL *lighturl = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@%@",ip,[tempDic objectForKey:@"lightImg"]]];
        UIImage *cached = [[SDImageCache sharedImageCache] imageFromKey:[NSString stringWithFormat:@"menu%d",menuBtns.tag]];
        if (cached) {
            [menuBtns setBackgroundImage:cached forState:UIControlStateNormal];
        }
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        [manager downloadWithURL:url 
                        delegate:self
                         options:0 
                         success:^(UIImage *image, BOOL cached)
                            {
                                [menuBtns setBackgroundImage:[UIImage imageWithData:UIImagePNGRepresentation(image)] forState:UIControlStateNormal];
                                [[SDImageCache sharedImageCache] storeImage:[UIImage imageWithData:UIImagePNGRepresentation(image)] forKey:[NSString stringWithFormat:@"menu%d",menuBtns.tag]];
                            }
                         failure:nil]; 
        
        [manager downloadWithURL:lighturl 
                        delegate:self
                         options:0
                         success:^(UIImage *lightimage, BOOL cached)
                            { 
                                [[SDImageCache sharedImageCache] storeImage:[UIImage imageWithData:UIImagePNGRepresentation(lightimage)] forKey:[NSString stringWithFormat:@"menulight%d",menuBtns.tag]]; }
                         failure:nil];
        
        [menuBtns setTitle:[tempDic objectForKey:@"desc"] forState:UIControlStateNormal];
        [menuBtns setTitleEdgeInsets:UIEdgeInsetsMake(90, 5, 5, 5)];
        
        menuBtns.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [menuBtns setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [erTabBarView addSubview:menuBtns];
        [erTabBarView bringSubviewToFront:menuBtns];
	    FunctionViewController *ctrl = [[FunctionViewController alloc] initWithSeq:[NSNumber numberWithInt:i]];
		[viewArr addObject:ctrl];
    }
    self.viewControllers = viewArr;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

@end
