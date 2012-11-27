//
//  CItySingleViewController.m
//  ERoom3
//
//  Created by user on 12-11-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CItySingleViewController.h"
#import <SDwebImage/UIButton+WebCache.h>
#import <QuartzCore/QuartzCore.h>


#define RELATION_ROW_NUM 3

@implementation CItySingleViewController


@synthesize conID,conTypeID,title,img,descText;

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
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self startLoadData];
    
    
}
-(void)startLoadData{

    [[ClientClass shareNavService] findSingleContentDetails:self 
                                                     action:@selector(findSingleContentDetailsHander:) 
                                                  sessionId:[ERConfiger shareERConfiger].sessionID 
                                                 contTypeId:conTypeID 
                                                     contId:conID
     ];
    
    [[ClientClass shareNavService] findSingleContentRelations:self 
                                                       action:@selector(findSingleContentRelationsHandler:) 
                                                    sessionId:[ERConfiger shareERConfiger].sessionID 
                                                   contTypeId:conTypeID 
                                                       contId:conID
     ];

}


-(void)findSingleContentDetailsHander:(id)value{
    
    if ([value isKindOfClass:[NSError class]]) {
        NSLog(@"Error: %@", value);
        return;
    }
    if ([value isKindOfClass:[SoapFault class]]) {
        NSLog(@"Fault: %@", value);
        return;
    }
    
    ctArr = (SDZContTypeField2stringMap *)value;
    
} 

-(void)findSingleContentRelationsHandler:(id)value{
    
    if ([value isKindOfClass:[NSError class]]) {
        NSLog(@"Error: %@", value);
        return;
    }
    if ([value isKindOfClass:[SoapFault class]]) {
        NSLog(@"Fault: %@", value);
        return;
    }
    
    relationList =  (SDZRelationList*)value;
    scrollView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 900, 600)];
    [self.view addSubview:scrollView];
    [scrollView addSubview:[self createIntroView]];
    nowView = [[UIView alloc] initWithFrame:CGRectMake(0, 300, 900, 600)];
    dic = [[NSMutableDictionary alloc] init];
    [scrollView addSubview:nowView];
    tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, 900, 250) style:UITableViewStylePlain];
    
    tbView.delegate =self;
    tbView.dataSource = self;
    [nowView addSubview:tbView];
    for (SDZRelation *relation in relationList) {
        NSLog(@"selfidn:%ld rightContTypeId:%@\n selfname:%@\n",relation.selfid,relation.rightContTypeId,relation.selfname);
        NSString *reID =[NSString stringWithFormat:@"%ld",relation.selfid];

        UIButton *rbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        rbtn.frame = CGRectMake([relationList indexOfObject:relation]*100, 0, 90, 30);
        
        [rbtn setTitle:relation.selfname forState:UIControlStateNormal];
        [rbtn setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_media_library_topbar.png"]]];
        [rbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        rbtn.titleLabel.font = [UIFont systemFontOfSize:11.0f];
        
        
        [rbtn addTarget:self action:@selector(showTB:) forControlEvents:UIControlEventTouchUpInside];
        
        rbtn.tag = [reID intValue];
        
        
        [dic setValue:relation.rightContTypeId forKey:reID];
        
        NSLog(@"nowtag:::::%d",nowTag);
        

        if ([relationList indexOfObject:relation]==0) {
            req =[[ClientClass shareNavService] findSingleContentRelationContentInfo:self 
                                                                              action:@selector(findRelationInfoHandler:) 
                                                                           sessionId:[ERConfiger shareERConfiger].sessionID 
                                                                          contTypeId:conTypeID 
                                                                          relationId:reID
                                                                              contId:conID 
                                                                              pageNo:@"1" 
                                                                          perPageNum:@"12"];
            
        }
        
        [nowView addSubview:rbtn];
        

    }

    
}

-(void)showTB:(UIButton*)sender{
    
    nowTag = [[dic valueForKey:[NSString stringWithFormat:@"%d",sender.tag]] intValue];
    
    req =[[ClientClass shareNavService] findSingleContentRelationContentInfo:self 
                                                                      action:@selector(findRelationInfoHandler:) 
                                                                   sessionId:[ERConfiger shareERConfiger].sessionID 
                                                                  contTypeId:conTypeID 
                                                                  relationId:[NSString stringWithFormat:@"%d",sender.tag]
                                                                      contId:conID 
                                                                      pageNo:@"1" 
                                                                  perPageNum:@"12"];
    
    
}


-(void)findRelationInfoHandler:(id)value{
    
    NSLog(@"??????????findRelationInfoHandler执行???????????");
    
    if ([value isKindOfClass:[NSError class]]) {
        NSLog(@"Error: %@", value);
        return;
    }
    if ([value isKindOfClass:[SoapFault class]]) {
        NSLog(@"Fault: %@", value);
        return;
    }
    list = [[NSMutableArray alloc] init];
    SDZContentList *result = (SDZContentList *)value;
    if ([req cancel]) {
        
        for (SDZContent *content in result) {
            
            
            [list addObject:content];
            
        }
    }

    [tbView reloadData];

}

-(UIView *)createIntroView{

    UIView *introView = [[UIView alloc] initWithFrame:CGRectMake(0, 30, 450, 500)];
    introView.tag = 10;
    UIImageView *picView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 220, 210)];
    UILabel *tl = [[UILabel alloc] initWithFrame:CGRectMake(picView.frame.size.width+20, 0, 300, 30)];
    tl.font = [UIFont systemFontOfSize:14.0f];
    tl.text = title;
    tl.textColor = [UIColor colorWithRed:0.14f green:0.57f blue:0.94f alpha:1];
    [introView addSubview:tl];
    picView.image = img;
    UILabel *l;
    
    CGFloat ctfheight;
    for (SDZContTypeField *ctf in ctArr) {
        if (!ctf.addressData) {
            if ([ctArr indexOfObject:ctf]==0) {
                ctfheight = 30;
            }else {
                ctfheight = ctfheight+30;
            }
            
            l = [[UILabel alloc] initWithFrame:CGRectMake(picView.frame.size.width+20, ctfheight, 300, 30)];
            l.text = [NSString stringWithFormat:@"%@:%@",ctf.name,ctf.value];
            l.font = [UIFont systemFontOfSize:11.0f];
            if ([l.text isEqualToString:@""]) {
            }else {
                [introView addSubview:l];
            }
        }else {
            
        }
    }
    UIImageView *detailIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jieshao.png"]];
    detailIcon.frame = CGRectMake(500, 10, 71, 29);
    UITextView *introText = [[UITextView alloc] initWithFrame:CGRectMake(detailIcon.frame.origin.x, detailIcon.frame.origin.y+29, 360, 250)];
    introText.text =descText;
    introText.editable = NO;
    [introView addSubview:detailIcon];
    [introView addSubview:introText];
    [introView addSubview:picView];
    [self.view addSubview:introView];
    
    return introView;

}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSLog(@"numberOfRowsInSection:nowtag:%d",nowTag);
        
//    tableView = (UITableView*)[self.view viewWithTag:nowTag];
    
        if (list !=nil) {
            int row = ([list count]+RELATION_ROW_NUM-1)/RELATION_ROW_NUM;
            NSLog(@"row:%d",row);
            
            return row;
    }
    return 0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"cellForRowAtIndexPath:nowtag:%d",nowTag);
//    tableView = (UITableView*)[self.view viewWithTag:nowTag];
    
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
    if (list==nil) {
        
        return cell;
    }
    int rowcount =([list count]-indexPath.row*RELATION_ROW_NUM)/RELATION_ROW_NUM;
    if (rowcount>=1) {
        rowcount = RELATION_ROW_NUM;
    }else {
        rowcount =[list count]-indexPath.row*RELATION_ROW_NUM;
    }
    NSLog(@"rowcount:%d",rowcount);
    for (int i=0; i<rowcount; i++) {
        SDZContent *content = [list objectAtIndex:indexPath.row*RELATION_ROW_NUM+i];
        
        NSLog(@"11111111111");
        UIView *singleView = [[UIView alloc] initWithFrame:CGRectMake(i*280+30, 10, 280, 120)];
        
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
        [pic addTarget:self action:@selector(reFlashViewShow:) forControlEvents:UIControlEventTouchUpInside];
        pic.titleLabel.text =[NSString stringWithFormat:@"%@|%@",content.name,content.desc];
        pic.titleLabel.hidden = YES;
        CGSize size = CGSizeMake(160,85);
        CGSize descSize = [content.name sizeWithFont:[UIFont systemFontOfSize:16] 
                                   constrainedToSize:size 
                                       lineBreakMode:UILineBreakModeWordWrap
                           ];  
        UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(140, 10, 160, descSize.height)];                                          // 每个内容的标题
        
        NSLog(@"%@",content.name);
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
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    
    
    return cell;
}

-(void)reFlashViewShow:(UIButton*)sender{
    for (UIView *vi in [self.view subviews]) {
        [vi removeFromSuperview];
    }
    conTypeID = [NSString stringWithFormat:@"%d",nowTag];
    conID = [NSString stringWithFormat:@"%d",sender.tag];
    img = sender.imageView.image;
    NSArray *d = [sender.titleLabel.text componentsSeparatedByString:@"|"];
    title = [d objectAtIndex:0];
    descText = [d objectAtIndex:1];
    [self startLoadData];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

@end
