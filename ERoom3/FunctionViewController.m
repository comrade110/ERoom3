//
//  FunctionViewController.m
//  ERoom3
//
//  Created by user on 12-11-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FunctionViewController.h"
#import "ERTabBarController.h"
#import <SDwebImage/UIButton+WebCache.h>
#import "PageViewController.h"
#import "NewsViewController.h"
#import "SVModalWebViewController.h"
#import "NaviViewController.h"

#define FUNCIMG_WIDTH  150
#define FUNCIMG_HEIGHT 200


@implementation FunctionViewController

@synthesize funcArr;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithSeq:(NSNumber*)index
{
    self = [super init];
    if (self) {
        
        seqcount = [index intValue]; 
        
        funcArr = [ERConfiger shareERConfiger].configArr;
        ip = [ERConfiger shareERConfiger].ip;
        if (self.funcArr) {
            funcIcons = [[[funcArr objectAtIndex:[index intValue]] objectForKey:@"menu"] objectForKey:@"func"];
            if (funcIcons&&ip) {
                
                funcNum = [funcIcons count];
                
                sv = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 245, 1024, 400)];
                int svwidth =(funcNum+4)/5*1024;
                sv.contentSize = CGSizeMake(svwidth, FUNCIMG_HEIGHT);
                

                sv.delegate = self;
                sv.pagingEnabled = YES;
                sv.showsHorizontalScrollIndicator =0;
                //    sv.scrollEnabled = NO;
                [self.view addSubview:sv];
                
                views = [[NSMutableArray alloc] init];
                
                for (int i=0; i<funcNum; i++)
                {

                    UIView *view = [[UIView alloc] initWithFrame:CGRectMake((FUNCIMG_WIDTH+50)*i+30, 0, FUNCIMG_WIDTH, FUNCIMG_HEIGHT)];
                    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    btn.frame = CGRectMake(0, 0, FUNCIMG_WIDTH, FUNCIMG_HEIGHT);
                    btn.center = CGPointMake(FUNCIMG_WIDTH/2, FUNCIMG_HEIGHT/2);
                    btn.tag = i+1;
                    
                    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@%@",ip,[[funcIcons objectAtIndex:i] objectForKey:@"timg"]]];
                    
                    SDWebImageManager *manager = [SDWebImageManager sharedManager];
                    [manager downloadWithURL:url 
                                    delegate:self
                                     options:0 
                                     success:^(UIImage *image, BOOL cached)
                     {
                         
                         [btn setBackgroundImage:[UIImage imageWithData:UIImagePNGRepresentation(image)] forState:UIControlStateNormal];
                         [[SDImageCache sharedImageCache] storeImage:[UIImage imageWithData:UIImagePNGRepresentation(image)] forKey:[NSString stringWithFormat:@"timg%@_%d",index,btn.tag]];
                     }
                                     failure:nil]; 
                    
                    [btn setTitle:[NSString stringWithFormat:@"%@",[[funcIcons objectAtIndex:i] objectForKey:@"desc"]] forState:UIControlStateNormal];
                    [btn setTitleEdgeInsets:UIEdgeInsetsMake(FUNCIMG_HEIGHT-30, 20, 5, 20)];
                    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    btn.backgroundColor = [UIColor clearColor];
                    [btn addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
                    
                    [view addSubview:btn];

                    [sv addSubview:view];
                    [views addObject:btn];
                }
                suoyin = 0;
//                label=[[UILabel alloc]initWithFrame:CGRectMake(10, 200, 300, 100)];
//                label.backgroundColor=[UIColor redColor];
//                label.textAlignment=UITextAlignmentCenter;
//                [self.view addSubview:label];
//                [label setText:[NSString stringWithFormat:@"%d",suoyin+2]];  
            }

        }
    }
    return self;

}


- (void)viewDidLoad
{
    [super viewDidLoad];
    

    
   	// Do any additional setup after loading the view
}
-(void)viewWillAppear:(BOOL)animated{

//    for (UIButton * btn in views) {
//        CGContextRef context = UIGraphicsGetCurrentContext();
//        [UIView beginAnimations:nil context:context];
//        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//        [UIView setAnimationDuration:0.7f];
//        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:btn cache:YES];
//        
//        [self.view exchangeSubviewAtIndex:btn.tag withSubviewAtIndex:btn.tag+1];
//        [UIView setAnimationDelegate:self];
//        
//        [UIView commitAnimations];
//    }
    // 动画完毕后调用某个方法
    //[UIView setAnimationDidStopSelector:@selector(animationFinished:)];

}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch =[[event allTouches] anyObject];
    CGPoint currentPoint =[touch locationInView:self.view];
    if (CGRectContainsPoint(sv.frame, currentPoint))
    {
        isTouchSV = YES;
        startPoint = currentPoint;
    }
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch =[[event allTouches] anyObject];
    CGPoint endPoint =[touch locationInView:self.view];
    if (isTouchSV)
    {
        float dx = endPoint.x - startPoint.x;
        float dy = fabsf(endPoint.y - startPoint.y);
        float huangdongfanwei = FUNCIMG_WIDTH;
        if (dx < -50 && dy < 30) {
            suoyin += -dx / 50;
            if (suoyin>funcNum) suoyin = funcNum;
            
        }
        if (dx > 50 && dy < 30) {
            suoyin -= dx / 50;
            if (suoyin<0) suoyin = 0;
        }
        
        double offsetNum = suoyin*huangdongfanwei;
        if (offsetNum > FUNCIMG_WIDTH*(funcNum-1)) {
            offsetNum = FUNCIMG_WIDTH*(funcNum-1);
        }
        
        [sv setContentOffset:CGPointMake(offsetNum, 0) animated:YES];
        
        isTouchSV = !isTouchSV;
    }
}

-(void)selectBtn:(UIButton *)btn
{
    NSLog(@"ye,%d",btn.tag);
    
    NSInteger selType =[[[funcIcons objectAtIndex:(btn.tag-1)] objectForKey:@"type"] intValue];
    
    if (selType == 1) {
        NSLog(@"page\n");
        
        PageViewController *pvc = [[PageViewController alloc] initWithPageSeq:seqcount andBtnTag:btn.tag-1];
        
      //  UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:pvc];
        
        [self.navigationController pushViewController:pvc animated:YES];    
    }else if (selType == 2) {
         NSString *target = [[funcIcons objectAtIndex:(btn.tag-1)] objectForKey:@"target"];
        NSString *urlstring = [NSString stringWithFormat:@"http://%@%@",ip,target];
        SVModalWebViewController *svWebView = [[SVModalWebViewController alloc] initWithAddress:urlstring];
        
        [self.navigationController presentModalViewController:svWebView animated:YES];  
        
        
    }else if (selType == 3) {
        NSString *checkTarget = [[funcIcons objectAtIndex:(btn.tag-1)] objectForKey:@"target"];
        if ([checkTarget hasPrefix:@"news"]) {
            
            NewsViewController *nvc = [[NewsViewController alloc] initWithNewsSeq:seqcount andBtntag:btn.tag-1];
            [self.navigationController pushViewController:nvc animated:YES];  
        }else if([checkTarget hasPrefix:@"module"]){
            NaviViewController *navi = [[NaviViewController alloc] init];
            navi.targetID = [checkTarget substringFromIndex:10];
            [self.navigationController pushViewController:navi animated:YES];
        }
    }
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView  //滑动效果停止的时候
{
    CGPoint offset = scrollView.contentOffset;
    [sv setContentOffset:offset animated:YES];
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