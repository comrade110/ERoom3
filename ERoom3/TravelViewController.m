//
//  TravelViewController.m
//  ERoom3
//
//  Created by user on 12-11-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TravelViewController.h"
#import <SDwebImage/UIButton+WebCache.h>

#define PER_LINE_COUNT 2
#define TABLE_HIGHT 150
#define ALL_LIMIT 30
#define TBVIEW_HEIGHT 600

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
    
    curPage = [NSNumber numberWithInt:1];
    perPage = [NSNumber numberWithInt:8];
    selTag = 0;
    tuniuData = [NSMutableArray array];
    
    UIView *menuView = [[UIView alloc] initWithFrame:CGRectMake(12, 60, 1000, 39)];
//    CityListViewController *citylistv = [[CityListViewController alloc] init];
    menuView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cityw_daohangt.png"]];
    UIView *btnBox = [[UIView alloc] initWithFrame:CGRectMake(90, 0, 910, 39)];
    curLable = [[UIButton alloc] initWithFrame:CGRectMake(10, 4, 80, 34)];
    [curLable setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [curLable setTitle:@"全国" forState:UIControlStateNormal];
    curLable.titleLabel.font = [UIFont systemFontOfSize:16];
    
    [self cityData];
    for (int i=0; i<[cityName count]; i++) {
        UIButton *cbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cbtn.frame = CGRectMake(i*55, 5, 45, 30);
        cbtn.tag = [[cityCode objectAtIndex:i] intValue];
        cbtn.titleLabel.font = [UIFont systemFontOfSize:11.0f];
        [cbtn setTitle:[cityName objectAtIndex:i] forState:UIControlStateNormal];
        [cbtn setBackgroundImage:[UIImage imageNamed:@"button_normal.png"] forState:UIControlStateNormal];
        [cbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cbtn addTarget:self action:@selector(selCityList:) forControlEvents:UIControlEventTouchUpInside];
        [btnBox addSubview:cbtn];
    }
    
    tbView = [[UITableView alloc] initWithFrame:CGRectMake(12, 100, 1000, TBVIEW_HEIGHT) style:UITableViewStylePlain];
    tbView.backgroundColor = [UIColor blackColor];
    tbView.separatorColor = [UIColor clearColor];
    
    tbView.delegate = self;
    tbView.dataSource = self;
    
    [self selCityList:nil];
//    citybtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    citybtn.frame = CGRectMake(10, 3, 106, 34);
//    [citybtn setTitle:@"南京" forState:UIControlStateNormal];
//    [citybtn setBackgroundImage:[UIImage imageNamed:@"button_normal.png"] forState:UIControlStateNormal];
//    [citybtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [citybtn addTarget:self action:@selector(showPop) forControlEvents:UIControlEventTouchUpInside];
//    [menuView addSubview:citybtn];
    [menuView addSubview:curLable];
    [menuView addSubview:btnBox];
    [self.view addSubview:menuView];
    [self.view addSubview:tbView];
    
    tbView.contentSize = CGSizeMake(1024, TBVIEW_HEIGHT);
    _refreshHeaderView=[[EGORefreshTableHeaderView alloc] initWithFrame:
                        CGRectMake(0, tbView.contentSize.height, 1024, TBVIEW_HEIGHT)];
    _refreshHeaderView.backgroundColor = [UIColor clearColor];
    _refreshHeaderView.delegate=self;
    [tbView addSubview:_refreshHeaderView];
//    citylistv.delegate = self;
//    
//    cityPop = [[UIPopoverController alloc] initWithContentViewController:citylistv];
    
	// Do any additional setup after loading the view.
}


-(void)selCityList:(UIButton*)sender
{
    if ([operation isExecuting]) {
        [operation cancel];
    }
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:urlstr]];
    NSDictionary *params;
    if (sender !=nil) {
        [curLable setTitle:[cityDic objectForKey:[NSString stringWithFormat:@"%d",sender.tag]] forState:UIControlStateNormal];
        
       params = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"70eac34cacd6a4aa5000d57af452052a", @"key",
                                @"kuxun", @"do",
                                [curPage stringValue],@"page",
                                [perPage stringValue],@"limit",
                                [NSString stringWithFormat:@"%d",sender.tag],@"city_code",nil];
        if (selTag != sender.tag) {
            
            tbView.contentSize = CGSizeMake(1024, TBVIEW_HEIGHT);
            _refreshHeaderView.frame=CGRectMake(0, tbView.contentSize.height, 1024, TBVIEW_HEIGHT);
            selTag = sender.tag;
            tuniuData = [NSMutableArray array];
        }
    }else {
    
       params = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"70eac34cacd6a4aa5000d57af452052a", @"key",
                                @"kuxun", @"do",
                                [curPage stringValue],@"page",
                                [perPage stringValue],@"limit",nil];
    }
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"mysite/user/signup"parameters:params];
    operation = [KGTouchXMLRequestOperation XMLRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, CXMLDocument *XML) {
        NSArray *arr = [NSArray array];
        arr = [XML nodesForXPath:@"//Dujia_Xianlu" error:nil];
        for (int i=0; i<[arr count]; i++) {
            CXMLElement *node = [arr objectAtIndex:i];
            NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] init];
            for (CXMLElement *element in [node children]) {
                [tempDic setValue:[element stringValue] forKey:[element name]];
            }
            [tuniuData addObject:tempDic];
        }
        int count = [tuniuData count];
        int line = (count+PER_LINE_COUNT-1)/PER_LINE_COUNT;
        NSLog(@"line:%d",line);
        if(TABLE_HIGHT*line>TBVIEW_HEIGHT)
        {
            tbView.contentSize=CGSizeMake(1024, TABLE_HIGHT*line);
            _refreshHeaderView.frame=CGRectMake(0, tbView.contentSize.height, 1024, TBVIEW_HEIGHT);
            
        }
        [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0];
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
        int rowcount =([tuniuData count]-indexPath.row*PER_LINE_COUNT)/PER_LINE_COUNT;
        if (rowcount>=1) {
            rowcount = PER_LINE_COUNT;
        }else {
            rowcount =[tuniuData count]-indexPath.row*PER_LINE_COUNT;
        }
        for (int i =0; i<rowcount; i++) {        
            NSDictionary *tempDic = [[NSDictionary alloc] init];
            int order =indexPath.row*PER_LINE_COUNT+i;
            if ([tuniuData count]>order) {
                
                tempDic = [tuniuData objectAtIndex:order];            NSString *ss=[tempDic valueForKey:@"smallpic"];
                
                
                NSString *str = [self tuniuCharacterSet:ss];
                NSURL *url = [NSURL URLWithString:str];
                UIView *box = [[UIView alloc] initWithFrame:CGRectMake(500*i, 0, 500, 150)];
                UIButton *btnView = [[UIButton alloc] initWithFrame:CGRectMake(0, 12, 150, 120)];
                [btnView setBackgroundImageWithURL:url placeholderImage:[UIImage imageNamed:@"winhoologo.png"]];
                [btnView addTarget:self action:@selector(openSVWebView:) forControlEvents:UIControlEventTouchUpInside];
                btnView.tag = 10000+order;
                
                UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(btnView.frame.size.width+20, 8, 320, 24)];
                titleL.text = [self tuniuCharacterSet:[[tuniuData objectAtIndex:order] objectForKey:@"Title"]];
                
                //  出发城市
                UILabel *startfrom = [[UILabel alloc] initWithFrame:CGRectMake(titleL.frame.origin.x, titleL.frame.origin.y+titleL.frame.size.height+10, 320, 16)];
                NSString *startfromStr = [self tuniuCharacterSet:[[tuniuData objectAtIndex:order] objectForKey:@"City"]];
                startfrom.text = [NSString stringWithFormat:@"出发城市：%@",startfromStr];
                
                //  出游天数
                UILabel *days = [[UILabel alloc] initWithFrame:CGRectMake(titleL.frame.origin.x, startfrom.frame.origin.y+startfrom.frame.size.height+10, 320, 16)];
                NSString *daysStr = [self tuniuCharacterSet:[[tuniuData objectAtIndex:order] objectForKey:@"Days"]];
                days.text = [NSString stringWithFormat:@"出游天数：%@",daysStr];
                
                //  出发日期
                UILabel *startDate = [[UILabel alloc] initWithFrame:CGRectMake(titleL.frame.origin.x, days.frame.origin.y+days.frame.size.height+10, 320, 16)];
                NSString *startDateStr = [self tuniuCharacterSet:[[tuniuData objectAtIndex:order] objectForKey:@"StartDate"]];
                startDate.text = [NSString stringWithFormat:@"出发日期：%@",startDateStr];
                
                //  出游天数
                UILabel *price1 = [[UILabel alloc] initWithFrame:CGRectMake(titleL.frame.origin.x, startDate.frame.origin.y+startDate.frame.size.height+10, 50, 16)];
                price1.text = @"价     格：";
                UILabel *price2 = [[UILabel alloc] initWithFrame:CGRectMake(price1.frame.origin.x+price1.frame.size.width, startDate.frame.origin.y+startDate.frame.size.height+5, 270, 20)];
                NSString *price2Str = [self tuniuCharacterSet:[[tuniuData objectAtIndex:order] objectForKey:@"Price"]];
                price2.text = [NSString stringWithFormat:@"￥%@",price2Str];
                
                
                [box addSubview:btnView];
                [box addSubview:titleL];
                [box addSubview:startfrom];
                [box addSubview:days];
                [box addSubview:startDate];
                [box addSubview:price1];
                [box addSubview:price2];
                [cell.contentView addSubview:box];
                
                for (UIView *l in [box subviews]) {
                    if ([l isMemberOfClass:[UILabel class]]) {
                        UILabel *ll =(UILabel*)l;
                        ll.backgroundColor = [UIColor clearColor];
                        ll.textAlignment = UITextAlignmentLeft;
                        ll.font = [UIFont systemFontOfSize:11.0f];
                        ll.textColor = [UIColor whiteColor];
                    }
                }
                
                titleL.font = [UIFont systemFontOfSize:13.0f];
                titleL.textColor = [UIColor colorWithRed:0.7f green:0.93f blue:0.23f alpha:1];
                price2.textColor = [UIColor orangeColor];
                price2.font = [UIFont systemFontOfSize:15.0f];
            }

        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//  去除途牛返回数据所带的换行、制表符等空白字符
-(NSString*)tuniuCharacterSet:(NSString*)str
{
    return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

}

-(void)openSVWebView:(UIButton*)sender
{
    if (tuniuData) {
        NSString *ss = [[tuniuData objectAtIndex:(sender.tag-10000)] objectForKey:@"Url"];
        NSString *str = [self tuniuCharacterSet:ss];
        str = [str stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
        NSLog(@"%@",str);
        SVWebViewController *svWebView = [[SVWebViewController alloc] initWithAddress:str];
        [self.navigationController pushViewController:svWebView animated:YES];
    }

}


#pragma mark 上拉刷新
- (void)reloadTableViewDataSource{
	
	//should be calling your tableviews data source model to reload
	//put here just for demo
	_reloading = YES;
    
    if ([curPage intValue]>ALL_LIMIT) {
        _reloading = NO;
        [_refreshHeaderView setHidden:YES];
        _refreshHeaderView.userInteractionEnabled = NO;
        return;
    }else {
        int i=[curPage intValue];
        i++;
        curPage = [NSNumber numberWithInt:i];
    }
    if (selTag ==0) {
        
        [self selCityList:nil];
    }else {
        
        [self selCityList:(UIButton*)[self.view viewWithTag:selTag]];
    }

	//打开线程，读取网络图片
    //        [NSThread detachNewThreadSelector:@selector(requestImage) toTarget:self withObject:nil];
    
    
}



//此方法是结束读取数据
- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:tbView];
	NSLog(@"end");
	
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
	
	[_refreshHeaderView egoRefreshScrollViewDidScroll:tbView];
	
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	if ([curPage intValue]<ALL_LIMIT) {
        [_refreshHeaderView egoRefreshScrollViewDidEndDragging:tbView];
    }else {
        [_refreshHeaderView setHidden:YES];
        _refreshHeaderView.userInteractionEnabled = NO;
    }
	
}

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
    
	if ([curPage intValue]<ALL_LIMIT) {
        
        [self reloadTableViewDataSource];
    }else {
        [_refreshHeaderView setHidden:YES];
        _refreshHeaderView.userInteractionEnabled = NO;
    }
	//[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0.5];
	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

@end
