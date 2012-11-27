//
//  TravelViewController.m
//  ERoom3
//
//  Created by user on 12-11-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TravelViewController.h"
#import "AFNetworking.h"
#import "KGTouchXMLRequestOperation.h"
#import <SDwebImage/UIButton+WebCache.h>

#define PER_LINE_COUNT 3
#define TABLE_HIGHT 150

static NSString *urlstr = @"http://market.tuniu.com/main.php";

@implementation TravelViewController

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
    UIView *menuView = [[UIView alloc] initWithFrame:CGRectMake(50, 60, 900, 39)];
//    CityListViewController *citylistv = [[CityListViewController alloc] init];
    menuView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cityw_daohangt.png"]];
    [self cityData];
    for (int i=0; i<[cityName count]; i++) {
        UIButton *cbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cbtn.frame = CGRectMake(10+i*60, 3, 50, 34);
        cbtn.tag = [[cityCode objectAtIndex:i] intValue];
        cbtn.titleLabel.font = [UIFont systemFontOfSize:11.0f];
        [cbtn setTitle:[cityName objectAtIndex:i] forState:UIControlStateNormal];
        [cbtn setBackgroundImage:[UIImage imageNamed:@"button_normal.png"] forState:UIControlStateNormal];
        [cbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cbtn addTarget:self action:@selector(selCityList:) forControlEvents:UIControlEventTouchUpInside];
        [menuView addSubview:cbtn];
    }
    
    tbView = [[UITableView alloc] initWithFrame:CGRectMake(50, 100, 900, 500) style:UITableViewStylePlain];
    
    tbView.delegate = self;
    tbView.dataSource = self;
    
    
//    citybtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    citybtn.frame = CGRectMake(10, 3, 106, 34);
//    [citybtn setTitle:@"南京" forState:UIControlStateNormal];
//    [citybtn setBackgroundImage:[UIImage imageNamed:@"button_normal.png"] forState:UIControlStateNormal];
//    [citybtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [citybtn addTarget:self action:@selector(showPop) forControlEvents:UIControlEventTouchUpInside];
//    [menuView addSubview:citybtn];
    [self.view addSubview:menuView];
    [self.view addSubview:tbView];
    
//    citylistv.delegate = self;
//    
//    cityPop = [[UIPopoverController alloc] initWithContentViewController:citylistv];
    
	// Do any additional setup after loading the view.
}


-(void)selCityList:(UIButton*)sender
{
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:urlstr]];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            @"70eac34cacd6a4aa5000d57af452052a", @"key",
                            @"kuxun", @"do",
                            @"1",@"page",
                            @"3",@"limit",
                            @"1",@"promo",
                            [NSString stringWithFormat:@"%d",sender.tag],@"city_code",nil];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"mysite/user/signup"parameters:params];
    KGTouchXMLRequestOperation *operation = [KGTouchXMLRequestOperation XMLRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, CXMLDocument *XML) {
        NSArray *arr = [NSArray array];
        tuniuData = [NSMutableArray array];
        arr = [XML nodesForXPath:@"//Dujia_Xianlu" error:nil];
        for (int i=0; i<[arr count]; i++) {
            CXMLElement *node = [arr objectAtIndex:i];
            NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] init];
            for (CXMLElement *element in [node children]) {
                [tempDic setValue:[element stringValue] forKey:[element name]];
            }
            [tuniuData addObject:tempDic];
        }
        
        [tbView reloadData];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, CXMLDocument *XML) {
        NSLog(@"%@",error);
    }];
    
    [operation start];
    NSLog(@"over");
}

-(void)reflashData{



}




//-(void)showPop{
//    
//    cityPop.popoverContentSize = CGSizeMake(320, 480);
//    [cityPop presentPopoverFromRect:CGRectMake(165, 77, 0, 0) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
//
//}
//- (void) citySelectionUpdate:(NSString*)selectedCity
//{
//    [citybtn setTitle:selectedCity forState:UIControlStateNormal];
//    [cityPop dismissPopoverAnimated:YES];
//}
//
//- (NSString*) getDefaultCity
//{
//    return citybtn.titleLabel.text;
//}

- (void)viewDidUnload
{
    [super viewDidUnload];

    // Release any retained subviews of the main view.
}

-(void)cityData{
    
    
    cityName = [NSArray arrayWithObjects:
                @"北京",
                @"上海",
                @"南京",
                @"杭州",
                @"苏州",
                @"天津",
                @"深圳",
                @"成都",
                @"武汉",
                @"常州", 
                @"西安",
                @"重庆",
                @"宁波",
                @"无锡",
                @"长沙",
                nil];
    
    cityCode = [NSArray arrayWithObjects:
                @"200", 
                @"2500", 
                @"1602", 
                @"3402", 
                @"1615", 
                @"3000", 
                @"619", 
                @"2802", 
                @"1402", 
                @"1604", 
                @"2702",
                @"300", 
                @"3415",
                @"1619", 
                @"1502",
                nil];
    
    cityDic = [NSDictionary dictionaryWithObjects:cityName forKeys:cityCode];


}

-(void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBarHidden = NO;
    
}
-(void)viewWillDisappear:(BOOL)animated{
    
    self.navigationController.navigationBarHidden = YES;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TABLE_HIGHT;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (tuniuData !=nil) {
        return ([tuniuData count]+PER_LINE_COUNT-1)/PER_LINE_COUNT;
    }else {
        return 1;
    }
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
    if (tuniuData != nil) {
        int rowcount =([tuniuData count]-indexPath.row*PER_LINE_COUNT)/3;
        if (rowcount>=1) {
            rowcount = PER_LINE_COUNT;
        }else {
            rowcount =[tuniuData count]-indexPath.row*PER_LINE_COUNT;
        }
        for (int i =0; i<rowcount; i++) {        
            NSDictionary *tempDic = [[NSDictionary alloc] init];
            int order =indexPath.row*PER_LINE_COUNT+i;
            tempDic = [tuniuData objectAtIndex:order];
            NSString *ss=[tempDic valueForKey:@"smallpic"];
            
            //  去除换行和空格等空白字符
            NSString *str = [ss stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            NSURL *url = [NSURL URLWithString:str];
            if ([str isEqualToString:@"http://images.tuniu.com/imageshttp://imagesm.jpg "]) {
                url = [NSURL URLWithString:@"http://manage.shagri.com/Images/180abb79-4a20-490c-9b52-b810d8356cad/%E6%9A%82%E6%97%A02.jpg"];
            }
            
            NSLog(@"%@",str);
            UIButton *btnView = [[UIButton alloc] initWithFrame:CGRectMake(300*i, 0, 200, 140)];
            [btnView setBackgroundImageWithURL:url placeholderImage:[UIImage imageNamed:@"winhoologo.png"]];
            [btnView addTarget:self action:@selector(openSVWebView:) forControlEvents:UIControlEventTouchUpInside];
            btnView.tag = 10000+order;
            [cell.contentView addSubview:btnView];
        }
    }
    return cell;
}

-(void)openSVWebView:(UIButton*)sender
{
    if (tuniuData) {
        SVWebViewController *svWebView = [[SVWebViewController alloc] initWithAddress:[[[tuniuData objectAtIndex:(sender.tag-10000)] objectForKey:@"Url"] description]];
        [self.navigationController pushViewController:svWebView animated:YES];
    }

}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

@end
