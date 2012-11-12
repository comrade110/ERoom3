//
//  NewsViewController.m
//  ERoom3
//
//  Created by user on 12-11-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NewsViewController.h"

#define PER_PAGE_NUM 10

@interface NewsViewController ()

@end

@implementation NewsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithNewsSeq:(int)seq andBtntag:(int)index
{
    self =[super init];
    if (self) {
        NSArray *tempArr = [ERConfiger shareERConfiger].configArr;
        
        linkArr = [[NSMutableArray alloc] init];
        curCount = 0;
        if (tempArr) {
            newsArr = [[[tempArr objectAtIndex:seq] objectForKey:@"menu"] objectForKey:@"func"];
            
            if (newsArr) {
                NSDictionary *newsDic = [newsArr objectAtIndex:index];
                NSString *target = [newsDic objectForKey:@"target"];
                if (target) {
                    
                    NSString *urlStr = [target substringFromIndex:5];
                    
                    NSURL *url = [NSURL URLWithString:urlStr];
                    NSLog(@"url:%@",urlStr);
                    
                    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] 
                                              initWithURL:url 
                                              cachePolicy:NSURLRequestReloadIgnoringLocalCacheData 
                                              timeoutInterval:30.0];
                    receivedData=[NSMutableData data];
                    [request setHTTPMethod: @"POST"];
                    [NSURLConnection connectionWithRequest:request delegate:self];
                }
            }
        }
        tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.view addSubview:tableView];
        
    }
    return self;
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [self->receivedData setLength:0]; //通常在这里先清空接受数据的缓存
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self->receivedData appendData:data]; //可能多次收到数据，把新的数据添加在现有数据最后
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSString *results = [[NSString alloc] initWithBytes:[receivedData bytes] length:[receivedData length] encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
    
    NSString *utf8str = [results stringByReplacingOccurrencesOfString:@"gb2312" withString:@"UTF-8"];

    CXMLDocument *document = [[CXMLDocument alloc] initWithXMLString:utf8str options:0 error:nil];
    
    SOAPXMlParse *sxp = [[SOAPXMlParse alloc] init];    
    newsArr= [sxp parseRoot:document nodeName:@"//item"];
    if (newsArr) {        
        NSRange range = NSMakeRange(curCount, PER_PAGE_NUM);
        perPageArr = [newsArr subarrayWithRange:range];
    }
    int count=[perPageArr count];
    
	
	if(52*count>364)
	{
		tableView.contentSize=CGSizeMake(1024, 52*count);
		_refreshHeaderView.frame=CGRectMake(0, tableView.contentSize.height, 1024, 480);
		
	}
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0];
    [tableView reloadData];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    tableView.contentSize =CGSizeMake(1024, 700);
    
    
	_refreshHeaderView=[[EGORefreshTableHeaderView alloc] initWithFrame:
						CGRectMake(0, tableView.contentSize.height, 1024, 700)];
	_refreshHeaderView.delegate=self;
	[tableView addSubview:_refreshHeaderView];
    
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.alpha = 0.5;
    
}
-(void)viewWillDisappear:(BOOL)animated{
    
    self.navigationController.navigationBarHidden = YES;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 52.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [perPageArr count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = nil;
    identifier = @"Cell";
    UITableViewCell *cell;
    NSDictionary *tempDic = [perPageArr objectAtIndex:indexPath.row];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    } else{ 
        NSArray *subviews = [[NSArray alloc] initWithArray:cell.contentView.subviews]; 
        for (UIView *subview in subviews) { 
            [subview removeFromSuperview]; 
        } 
    } 
    NSString *title = [tempDic objectForKey:@"title"];
    NSString *link = [tempDic objectForKey:@"link"];
    [linkArr addObject:link];
    URLUILabel *titleL = [[URLUILabel alloc] initWithFrame:CGRectMake(10, 10, 900, 30)];
    titleL.delegate = self;
    titleL.text = title;
    titleL.tag = indexPath.row+10;
    [cell.contentView addSubview:titleL];
    return cell;
}

- (void)urlLabel:(URLUILabel *)myLabel touchesWtihTag:(NSInteger)tag {
    if (linkArr) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[linkArr objectAtIndex:tag-10]]];
    }
}

#pragma mark 上拉刷新
- (void)reloadTableViewDataSource{
	
	//should be calling your tableviews data source model to reload
	//put here just for demo
	_reloading = YES;
    
    curCount+=10;
    
    perPageArr = [newsArr subarrayWithRange:NSMakeRange(curCount, PER_PAGE_NUM)];
    
    [tableView reloadData];
    NSLog(@"当前数组元素个数为：%d",[perPageArr count]);
	//打开线程，读取网络图片
    //        [NSThread detachNewThreadSelector:@selector(requestImage) toTarget:self withObject:nil];
    
    
}

//-(void)dosomething
//{
//	
//}


//此方法是结束读取数据
- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:tableView];
	NSLog(@"end");
	
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
	
	[_refreshHeaderView egoRefreshScrollViewDidScroll:tableView];
	
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:tableView];
	
}

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	[self reloadTableViewDataSource];
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
