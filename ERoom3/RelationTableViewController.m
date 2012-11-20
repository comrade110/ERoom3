//
//  RelationTableViewController.m
//  ERoom3
//
//  Created by user on 12-11-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RelationTableViewController.h"
#import <SDwebImage/UIButton+WebCache.h>

#define RELATION_ROW_NUM 3

@implementation RelationTableViewController

@synthesize conID,conTypeID,relationID,rlist,tbName;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"zmhuishi???????????????");

    [[ClientClass shareNavService] findSingleContentRelationContentInfo:self 
                                                                 action:@selector(findRelationInfoHandler:) 
                                                              sessionId:[ERConfiger shareERConfiger].sessionID 
                                                             contTypeId:conTypeID 
                                                             relationId:relationID
                                                                 contId:conID 
                                                                 pageNo:@"1" 
                                                             perPageNum:@"12"];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


-(void)findRelationInfoHandler:(id)value{
    if ([value isKindOfClass:[NSError class]]) {
        NSLog(@"Error: %@", value);
        return;
    }
    if ([value isKindOfClass:[SoapFault class]]) {
        NSLog(@"Fault: %@", value);
        return;
    }
    list = (SDZContentList *)value;
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 600, 600) style:UITableViewStylePlain];
    
    tableview.delegate = self;
    tableview.dataSource = self;
    NSLog(@"屌屌屌屌屌屌");
    self.tableView = tableview;
    [tableview reloadData];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (list) {
        return [list count];
    }else {
        return 0;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell;
    
    NSLog(@"@@@@@@@@@@@@@@@@@\n@@@@@@@@@@@@@@@@@\n@@@@@@@@@@@@@@@@@@@@");
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
    for (int i=0; i<rowcount; i++) {
        SDZContent *content = [list objectAtIndex:indexPath.row*3+i];
        UIView *singleView = [[UIView alloc] initWithFrame:CGRectMake(i*320+30, 10, 320, 120)];
        UIButton *pic = [UIButton buttonWithType:UIButtonTypeCustom];   //  每个内容的大图
//        [pic.layer setMasksToBounds:YES];
//        [pic.layer setCornerRadius:5.0];
//        [pic.layer setBorderWidth:2.0];
//        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0, 0, 0, 0.3 }); 
//        [pic.layer setBorderColor:colorref];
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
        pic.titleLabel.text =content.desc;
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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
