//
//  PageViewController.m
//  ERoom3
//
//  Created by user on 12-11-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PageViewController.h"
#import <SDwebImage/UIImageView+WebCache.h>

@implementation PageViewController


- (void)openFlowView:(AFOpenFlowView *)openFlowView requestImageForIndex:(int)index{
	NSLog(@"request image for index called");
}
- (void)openFlowView:(AFOpenFlowView *)openFlowView selectionDidChange:(int)index{
	NSLog(@"selection did change called");
}
- (UIImage *)defaultImage{
	NSLog(@"default call");
	return [UIImage imageNamed:@"winhoologo.jpg"];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithPageSeq:(int)seq andBtnTag:(int)index
{
    self = [super init];
    if (self) {
        
        AFOpenFlowView *bigview = [[AFOpenFlowView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
        [self.view addSubview:bigview];
        NSArray *tempArr = [ERConfiger shareERConfiger].configArr;
        NSString *ip = [ERConfiger shareERConfiger].ip;
        
        if (tempArr) {
            NSArray *tempArr2 = [[[tempArr objectAtIndex:seq] objectForKey:@"menu"] objectForKey:@"func"];
            
            if (tempArr2) {
                coverImage = [[tempArr2 objectAtIndex:index] objectForKey:@"page"];
            }

        }
        
        if (coverImage) {
            int imgCount = [coverImage count];
            
            
            [bigview setNumberOfImages:imgCount]; 
            
            for (int i=0; i< imgCount; i++) {
                NSDictionary *imgDic = [coverImage objectAtIndex:i];
                NSString *urlstr = [NSString stringWithFormat:@"http://%@%@",ip,[imgDic objectForKey:@"img"]];
                NSURL *url = [NSURL URLWithString:urlstr];
                
                SDWebImageManager *manager = [SDWebImageManager sharedManager];
                [manager downloadWithURL:url 
                                delegate:self
                                 options:0 
                                 success:^(UIImage *image, BOOL cached)
                 {
                     
                     [bigview setImage:image forIndex:i];
                     [[SDImageCache sharedImageCache] storeImage:[UIImage imageWithData:UIImagePNGRepresentation(image)] forKey:[NSString stringWithFormat:@"pages%d_%d",index,i]];
                 }
                                 failure:nil]; 
            }
        }
        
    }
    return self;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.alpha = 0.5;
    
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
