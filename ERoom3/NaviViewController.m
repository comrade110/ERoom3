//
//  NaviViewController.m
//  ERoom3
//
//  Created by user on 12-11-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NaviViewController.h"
#import <SDwebImage/UIButton+WebCache.h>

#define UNLIMIT_TAG 500
#define INFO_ROW_NUM 3 
#define NAVI_TABLE_HEIGHT 150
#define PER_PAGE_NUM 12  
#define TABLE_HEIGHT 600
#define TOPBTN_TAG 200


@implementation NaviViewController

@synthesize targetID,depthView,singleViewControlle;

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
    NSLog(@"%@",self.targetID);
    
    self.view.backgroundColor = [UIColor blackColor];
    curPage = 1;
    perpage = [NSString stringWithFormat:@"%d",PER_PAGE_NUM];
    UITapGestureRecognizer* tapRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    self.depthView = [[JFDepthView alloc] initWithGestureRecognizer:tapRec];
    self.depthView.delegate = self;
//   获取从哪个点击过来
    [[ClientClass shareNavService] getMoudleIdByModuleEntry:self action:@selector(getMoudleIdByModuleEntryHandler:) sessionId:[ERConfiger shareERConfiger].sessionID moduleEntry:self.targetID];
	// Do any additional setup after loading the view.
}

-(void)findAllModulesHandler:(id)value{
    
    if ([value isKindOfClass:[NSError class]]) {
        NSLog(@"Error: %@", value);
        return;
    }
    if ([value isKindOfClass:[SoapFault class]]) {
        NSLog(@"Fault: %@", value);
        return;
    }
    SDZModuleList *result = (SDZModuleList*)value;
    
    int mcount = 1; 
    
    for (SDZModule *module in result) {
        UIButton *topbtn = [[UIButton alloc] initWithFrame:CGRectMake((mcount-1)*120, 30, 90, 30)];
        [topbtn setTitle:module.name forState:UIControlStateNormal];
        [topbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [topbtn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        topbtn.tag = TOPBTN_TAG + mcount;
        if (topbtn.tag == TOPBTN_TAG +[selBtn intValue]) {
            topbtn.selected = YES;
            topSelTag = topbtn.tag;
        }
        mcount++;
        [topbtn addTarget:self action:@selector(topBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:topbtn];
    }

}

-(void)topBtnClick:(UIButton*)sender{
 //   NSLog(@"seltag:%d seltag2:%d",seltag,seltag2);
    for (int i =0; i<typecount; i++) {
        for (UIButton *btns in [[self.view viewWithTag:1000+i] subviews]) {
            [btns removeFromSuperview];
        }
    }
    if (!sender.selected) {
         sender.selected = YES;
        UIButton *cancelBtn = (UIButton*)[self.view viewWithTag:topSelTag];
        cancelBtn.selected = NO;
        topSelTag = sender.tag;
        selBtn = [NSNumber numberWithInt:topSelTag - TOPBTN_TAG];
        if (![findInfoRequest cancel]) {
            [findInfoRequest cancel];
        }
        
       findInfoRequest= [[ClientClass shareNavService] findContTypeAndCatalogGroupAndCatalog:self action:@selector(findHandler:) sessionId:[ERConfiger shareERConfiger].sessionID moduleId:[selBtn stringValue]];
        
    }else {
        return;
    }


}


-(void)getMoudleIdByModuleEntryHandler:(id)value{
    
    if ([value isKindOfClass:[NSError class]]) {
        NSLog(@"Error: %@", value);
        return;
    }
    if ([value isKindOfClass:[SoapFault class]]) {
        NSLog(@"Fault: %@", value);
        return;
    }
    selBtn = (NSNumber*)value;
    
    [[ClientClass shareNavService] findAllModules:self action:@selector(findAllModulesHandler:) sessionId:[ERConfiger shareERConfiger].sessionID];
    
    findInfoRequest=[[ClientClass shareNavService] findContTypeAndCatalogGroupAndCatalog:self action:@selector(findHandler:) sessionId:[ERConfiger shareERConfiger].sessionID moduleId:[selBtn stringValue]];
    
    
}
-(void)findHandler:(id)value{
    
    if ([value isKindOfClass:[NSError class]]) {
        NSLog(@"Error: %@", value);
        return;
    }
    if ([value isKindOfClass:[SoapFault class]]) {
        NSLog(@"Fault: %@", value);
        return;
    }
    SDZContType *result = (SDZContType*)value;
    
    conTypeID = [NSString stringWithFormat:@"%d",result._id];
    
    typecount = [result.valueArr count];
    
    for (NSDictionary *dic in result.valueArr) {
        
        [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            svbox = [[UIView alloc] initWithFrame:CGRectMake(0, 80+40*[result.valueArr indexOfObject:dic], 1024, 39)];
            sv = [[UIScrollView alloc] initWithFrame:CGRectMake(70, 0, 954, 39)];
            sv.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cityw_daohangt.png"]];
            sv.tag = 1000+[result.valueArr indexOfObject:dic];
            sv.contentSize = CGSizeMake(100*[result.valueArr count], 39);
            sv.alwaysBounceHorizontal = YES;
            sv.pagingEnabled = NO;
            sv.showsHorizontalScrollIndicator = NO;
            
            svbox.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cityw_daohangt.png"]];
            [self.view addSubview:svbox];
            [svbox addSubview:sv];
            UILabel *type = [[UILabel alloc] initWithFrame:CGRectMake(10, 80+40*[result.valueArr indexOfObject:dic], 50, 39)];
            type.text = [NSString stringWithFormat:@"%@:",[key substringFromIndex:2]];
            type.textColor = [UIColor whiteColor];
            type.font = [UIFont boldSystemFontOfSize:13.0f];
            type.backgroundColor = [UIColor clearColor];
            [self.view addSubview:type];
            
            int btntag =UNLIMIT_TAG+[result.valueArr indexOfObject:dic];
            
            UIButton *unlimitbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 39)];
            
            unlimitbtn.tag = btntag;
            unlimitbtn.titleLabel.font = [UIFont systemFontOfSize:11.0f];
            [unlimitbtn setTitle:@"不限" forState:UIControlStateNormal];
            [unlimitbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [unlimitbtn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
            unlimitbtn.selected = YES;
            if ([result.valueArr indexOfObject:dic]==0) {
                
                seltag = unlimitbtn.tag;
                [unlimitbtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
            }else if( [result.valueArr indexOfObject:dic]==1){
                seltag2 = unlimitbtn.tag;
                
            //    NSLog(@"unlimitbtn:%d",unlimitbtn.tag);
                [unlimitbtn addTarget:self action:@selector(clickBtn2:) forControlEvents:UIControlEventTouchUpInside];
            }
            [sv addSubview:unlimitbtn];
            
            
            NSArray *objArr = obj;
            
            for (int i=0; i<[objArr count]; i++) {
                
                NSDictionary *objdic = [objArr objectAtIndex:i];
                [objdic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                    
                    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((i+1)*85, 0, 80, 39)];
                    btn.tag = [(NSNumber*)key intValue];
                    btn.titleLabel.font = [UIFont systemFontOfSize:11.0f];
                    [btn setTitle:(NSString*)obj forState:UIControlStateNormal];
                    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
                    btn.selected = NO;
                    if ([result.valueArr indexOfObject:dic]==0) {
                        
                        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
                    }else {
                        [btn addTarget:self action:@selector(clickBtn2:) forControlEvents:UIControlEventTouchUpInside];
                    }
                    [sv addSubview:btn];
                }];
                
            }
            
            sv.contentSize = CGSizeMake([objArr count]*90+180, 39);
            if (sv.contentSize.width<954) {
                sv.scrollEnabled = NO;
            }else {
                
                sv.scrollEnabled = YES;
            }
        }];
        
        infoArr = nil;
        
        tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, svbox.frame.origin.y+40, 1024, TABLE_HEIGHT) style:UITableViewStylePlain];
        
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorColor = [UIColor clearColor];
        tableView.backgroundColor = [UIColor blackColor];
        [self.view addSubview:tableView];
        tableView.contentSize = CGSizeMake(1024, TABLE_HEIGHT);
        _refreshHeaderView=[[EGORefreshTableHeaderView alloc] initWithFrame:
                            CGRectMake(0, tableView.contentSize.height, 1024, TABLE_HEIGHT)];
        _refreshHeaderView.backgroundColor = [UIColor clearColor];
        _refreshHeaderView.delegate=self;
        [tableView addSubview:_refreshHeaderView];
        
        [self queryData];
    }

}

-(void)clickBtn:(UIButton*)btn
{
    if (seltag !=0) {
        UIButton *bb = (UIButton*)[self.view viewWithTag:seltag];
        bb.selected = !bb.selected;
        
    }
    btn.selected = !btn.selected;
    seltag = btn.tag;
    
    [self queryData];
}

-(void)clickBtn2:(UIButton*)btn
{
    if (seltag2 !=0) {
        UIButton *bb = (UIButton*)[self.view viewWithTag:seltag2];
        bb.selected = !bb.selected;
    }
    btn.selected = !btn.selected;
    seltag2 = btn.tag;
    
    [self queryData];
    
}



//  查询列表数据

-(void)queryData{
    if (seltag<UNLIMIT_TAG && seltag2<UNLIMIT_TAG) {
        catalogIDs = [NSString stringWithFormat:@"%d,%d",seltag,seltag2];
    }else if (seltag>=UNLIMIT_TAG && seltag2>=UNLIMIT_TAG){
        catalogIDs = nil;
    }else if(seltag<UNLIMIT_TAG && seltag2>=UNLIMIT_TAG){
        catalogIDs = [NSString stringWithFormat:@"%d",seltag];
    }else if (seltag>=UNLIMIT_TAG && seltag2<UNLIMIT_TAG){
        catalogIDs = [NSString stringWithFormat:@"%d",seltag2];
    }
//    NSLog(@"seltag:%d seltag2:%d",seltag,seltag2);
//    NSLog(@"catalog:%@",catalogIDs);
    if (![infoRequest cancel]) {
        [infoRequest cancel];
    }
    [[ClientClass shareNavService] countContentInfo:self 
                                             action:@selector(countContentInfoHandler:) 
                                          sessionId:[ERConfiger shareERConfiger].sessionID 
                                         contTypeId:conTypeID 
                                         catalogIds:catalogIDs
     ];

}

-(void)countContentInfoHandler:(id)value{
    
    if ([value isKindOfClass:[NSError class]]) {
        NSLog(@"Error: %@", value);
        return;
    }
    if ([value isKindOfClass:[SoapFault class]]) {
        NSLog(@"Fault: %@", value);
        return;
    }
    NSNumber *result =(NSNumber*)value;
    
    allPage = [result intValue];
    tableView.frame = CGRectMake(0, svbox.frame.origin.y+40, 1024, TABLE_HEIGHT);
    tableView.contentSize = CGSizeMake(1024, TABLE_HEIGHT);
    
    NSLog(@"_refreshHeaderView.contentSize.height:%f",tableView.contentSize.height);
    _refreshHeaderView.frame=CGRectMake(0, tableView.contentSize.height, 1024, TABLE_HEIGHT);
    if (allPage<=12) {
        _refreshHeaderView.userInteractionEnabled = NO;
        _refreshHeaderView.hidden = YES;
    }else {
        
        _refreshHeaderView.userInteractionEnabled = YES;
        _refreshHeaderView.hidden = NO;
        
    }
//    NSLog(@"allpage:%d",allPage);
    curPage = 1;  // 重置页面
    
    infoRequest = [[ClientClass shareNavService] findContentInfo:self 
                                                          action:@selector(findConttentInfoHandler:) 
                                                       sessionId:[ERConfiger shareERConfiger].sessionID 
                                                      contTypeId:conTypeID 
                                                      catalogIds:catalogIDs 
                                                          pageNo:[NSString stringWithFormat:@"%d",curPage]
                                                      perPageNum:perpage
                   ];   
    

}


-(void)findConttentInfoHandler:(id)value{
    
    if ([value isKindOfClass:[NSError class]]) {
        NSLog(@"Error: %@", value);
        return;
    }
    if ([value isKindOfClass:[SoapFault class]]) {
        NSLog(@"Fault: %@", value);
        return;
    }
    
    infoArr = [[NSMutableArray alloc] init];
    SDZContentList *result = (SDZContentList*)value;
    for (SDZContent *obj in result) {
        [infoArr addObject:obj];
        
 //       NSLog(@"objname:%@",obj.name);
    }
    [tableView reloadData];
}

#pragma mark tableview controller


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NAVI_TABLE_HEIGHT;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    int row =([infoArr count]+INFO_ROW_NUM-1)/INFO_ROW_NUM;
    return row;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    } else{ 
        NSArray *subviews = [[NSArray alloc] initWithArray:cell.contentView.subviews]; 
        for (UIView *subview in subviews) { 
            [subview removeFromSuperview]; 
        } 
    } 
    if (infoArr==nil) {
        return cell;
    }
    int rowcount =([infoArr count]-indexPath.row*INFO_ROW_NUM)/3;
    if (rowcount>=1) {
        rowcount = INFO_ROW_NUM;
    }else {
        rowcount =[infoArr count]-indexPath.row*INFO_ROW_NUM;
    }
    for (int i=0; i<rowcount; i++) {
        SDZContent *content = [infoArr objectAtIndex:indexPath.row*3+i];
        UIView *singleView = [[UIView alloc] initWithFrame:CGRectMake(i*320+30, 10, 320, 120)];
        UIButton *pic = [UIButton buttonWithType:UIButtonTypeCustom];   //  每个内容的大图
        [pic.layer setMasksToBounds:YES];
        [pic.layer setCornerRadius:5.0];
        [pic.layer setBorderWidth:2.0];
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0, 0, 0, 0.3 }); 
        [pic.layer setBorderColor:colorref];
        pic.frame = CGRectMake(10, 10, 120, 90);
        pic.tag = content._id;
        NSString *urlstr;
        if ([content.images rangeOfString:@","].location != NSNotFound) {
            urlstr = [[content.images componentsSeparatedByString:@","] objectAtIndex:0];
        }else {
            urlstr = content.images;
        }
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@%@",[ERConfiger shareERConfiger].ip,urlstr]];

        [pic setImageWithURL:url placeholderImage:[UIImage imageNamed:@"winhoologo.png"]];
        // 图片点击事件
        [pic addTarget:self action:@selector(singleViewShow:) forControlEvents:UIControlEventTouchUpInside];
        pic.titleLabel.text =[NSString stringWithFormat:@"%@|%@",content.name,content.desc];
        pic.titleLabel.hidden = YES;
        CGSize size = CGSizeMake(160,85);
        CGSize descSize = [content.name sizeWithFont:[UIFont systemFontOfSize:16] 
                                   constrainedToSize:size 
                                       lineBreakMode:UILineBreakModeWordWrap
                           ];  
        
        UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(140, 10, 160, descSize.height)];                                          // 每个内容的标题
        titleL.text = content.name;
        titleL.font = [UIFont systemFontOfSize:16];
        titleL.backgroundColor = [UIColor clearColor];
        titleL.numberOfLines = 0;
        titleL.lineBreakMode = UILineBreakModeCharacterWrap;
        titleL.textColor = [UIColor colorWithRed:0.14f green:0.57f blue:0.94f alpha:1];
        
        UILabel *descL = [[UILabel alloc] init];                     //  每个内容的描述
        
        if ([content.desc length]>30) {
            
            NSString *des = [content.desc substringToIndex:30];
            descL.text = [NSString stringWithFormat:@"%@...",des];
        }else {
            
            descL.text = content.desc;
        }
        
        CGSize descSize2 = [descL.text sizeWithFont:[UIFont systemFontOfSize:11] 
                                    constrainedToSize:size 
                                        lineBreakMode:UILineBreakModeWordWrap
                            ];  
        descL.font = [UIFont systemFontOfSize:11];        
        descL.backgroundColor = [UIColor clearColor];
        descL.textColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
        descL.numberOfLines = 0;
        descL.lineBreakMode = UILineBreakModeCharacterWrap;
        descL.frame = CGRectMake(140, 15+descSize.height, 160, descSize2.height);
        [singleView addSubview:titleL];
        [singleView addSubview:descL];
        [singleView addSubview:pic];
        [cell.contentView addSubview:singleView];

    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


//  点击单个图片

-(void)singleViewShow:(id)sender{
    
    UIButton *selpic = (UIButton*)sender;
    
    singleViewControlle = [[CItySingleViewController alloc] init];
    
    singleViewControlle.img = selpic.imageView.image;
    
    NSArray *d = [selpic.titleLabel.text componentsSeparatedByString:@"|"];
    
    singleViewControlle.title = [d objectAtIndex:0];
    
    singleViewControlle.conID = [NSString stringWithFormat:@"%d",selpic.tag];
    
    singleViewControlle.conTypeID = conTypeID;
    
    singleViewControlle.descText = [d objectAtIndex:1];
    
//    NSLog(@"singleViewControlle.descText:%@",singleViewControlle.descText);
    
    [self.depthView presentViewController:self.singleViewControlle inView:self.view];
    self.navigationController.navigationBarHidden = YES;
    


}


- (void)dismiss {
    [self.depthView dismissPresentedViewInView:self.view];
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark 上拉刷新
- (void)reloadTableViewDataSource{
	
	//should be calling your tableviews data source model to reload
	//put here just for demo
	_reloading = YES;
    
    if (curPage*PER_PAGE_NUM>allPage) {
        _reloading = NO;
        [_refreshHeaderView setHidden:YES];
        _refreshHeaderView.userInteractionEnabled = NO;
        return;
    }else {
        curPage++;
    }
    
    infoRequest = [[ClientClass shareNavService] findContentInfo:self 
                                                          action:@selector(conttentInfoFlipOverHandler:) 
                                                       sessionId:[ERConfiger shareERConfiger].sessionID 
                                                      contTypeId:conTypeID 
                                                      catalogIds:catalogIDs 
                                                          pageNo:[NSString stringWithFormat:@"%d",curPage]
                                                      perPageNum:perpage
                   ];   
    
	//打开线程，读取网络图片
    //        [NSThread detachNewThreadSelector:@selector(requestImage) toTarget:self withObject:nil];
    
    
}

-(void)conttentInfoFlipOverHandler:(id)value{
    
    if ([value isKindOfClass:[NSError class]]) {
        NSLog(@"Error: %@", value);
        return;
    }
    if ([value isKindOfClass:[SoapFault class]]) {
        NSLog(@"Fault: %@", value);
        return;
    }
    SDZContentList *result = (SDZContentList*)value;
    for (SDZContent *obj in result) {
        [infoArr addObject:obj];
    }
    int infcount = [infoArr count];
    int line = (infcount+PER_PAGE_NUM-1)/PER_PAGE_NUM;
    if(TABLE_HEIGHT*line>TABLE_HEIGHT)
	{
		tableView.contentSize=CGSizeMake(1024, TABLE_HEIGHT*line);
		_refreshHeaderView.frame=CGRectMake(0, tableView.contentSize.height, 1024, TABLE_HEIGHT);
		
	}
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0];
    [tableView reloadData];


}


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
	
	if (curPage*PER_PAGE_NUM<allPage) {
        [_refreshHeaderView egoRefreshScrollViewDidEndDragging:tableView];
    }else {
        [_refreshHeaderView setHidden:YES];
        _refreshHeaderView.userInteractionEnabled = NO;
    }
	
}

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
    
	if (curPage*PER_PAGE_NUM<allPage) {
        
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



-(void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBarHidden = NO;
    
}
-(void)viewWillDisappear:(BOOL)animated{
    
    self.navigationController.navigationBarHidden = YES;
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

@end
