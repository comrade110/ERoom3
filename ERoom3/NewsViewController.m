//
//  NewsViewController.m
//  ERoom3
//
//  Created by user on 12-11-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NewsViewController.h"

#define PER_PAGE_NUM 10
#define TABLE_HEIGHT 70


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
        curCount = 10;
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
        NSRange range = NSMakeRange(0, curCount);
        perPageArr = [newsArr subarrayWithRange:range];
    }
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
    
}
-(void)viewWillDisappear:(BOOL)animated{
    
    self.navigationController.navigationBarHidden = YES;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TABLE_HEIGHT;
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
    NSString *desc = [tempDic objectForKey:@"description"];
    NSString *link = [tempDic objectForKey:@"link"];
    NSString *source = [tempDic objectForKey:@"source"];
    
    if ([desc hasPrefix:@"<a"]) {
        
       NSArray* tarr = [desc componentsSeparatedByString:@"<br>"];
        if (tarr) {
            desc = [tarr objectAtIndex:1];
        }
    }
    
    
    [linkArr addObject:link];
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 950, 20)];
    UILabel *descL = [[UILabel alloc] init];
    titleL.font = [UIFont boldSystemFontOfSize:16];
    titleL.text = title;
    titleL.tag = indexPath.row+10;
    descL.text = [NSString stringWithFormat:@"%@ 【%@】",desc,source];
    descL.font = [UIFont systemFontOfSize:11] ;
    descL.numberOfLines = 0;
    descL.lineBreakMode = UILineBreakModeCharacterWrap;
    CGSize size = CGSizeMake(900,40);
    CGSize descSize = [desc sizeWithFont:[UIFont systemFontOfSize:11] 
                       constrainedToSize:size 
                           lineBreakMode:UILineBreakModeWordWrap
                       ];  
    descL.frame = CGRectMake(20, 30, 950, descSize.height);
    [cell.contentView addSubview:titleL];
    [cell.contentView addSubview:descL];
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
    
    perPageArr = nil;
    
    if (curCount>50) {
        curCount = 49;
        _reloading = NO;
        [_refreshHeaderView removeFromSuperview];
        return;
    }else {
        curCount+=PER_PAGE_NUM;
    }
    
    perPageArr = nil;
    
    perPageArr = [newsArr subarrayWithRange:NSMakeRange(0, curCount)];
    
    int count=[perPageArr count];
    
	
    NSLog(@"当前数组元素个数为：%d",[perPageArr count]);
    
	if(TABLE_HEIGHT*count>700)
	{
		tableView.contentSize=CGSizeMake(1024, TABLE_HEIGHT*count);
		_refreshHeaderView.frame=CGRectMake(0, tableView.contentSize.height, 1024, 700);
		
	}
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0];
    [tableView reloadData];

	//打开线程，读取网络图片
    //        [NSThread detachNewThreadSelector:@selector(requestImage) toTarget:self withObject:nil];
    
    
}



//此方法是结束读取数据
- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:tableView];
	NSLog(@"end");
	
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (linkArr) {
        SVWebViewController *svWebView = [[SVWebViewController alloc] initWithAddress:[linkArr objectAtIndex:indexPath.row]];
        [self.navigationController pushViewController:svWebView animated:YES];
    }
    
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
	
	[_refreshHeaderView egoRefreshScrollViewDidScroll:tableView];
	
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	if (curCount<=49) {
        [_refreshHeaderView egoRefreshScrollViewDidEndDragging:tableView];
    }else {
        [_refreshHeaderView removeFromSuperview];
    }
	
}

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
    
	if (curCount<=49) {
        [self reloadTableViewDataSource];
    }else {
        [_refreshHeaderView removeFromSuperview];
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
