//
//  CItySingleViewController.m
//  ERoom3
//
//  Created by user on 12-11-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CItySingleViewController.h"

@implementation CItySingleViewController

@synthesize conID,conTypeID,img,descText;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
//- (void)didClickPage:(XLCycleScrollView *)csView atIndex:(NSInteger)index
//{
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
//                                                    message:[NSString stringWithFormat:@"当前点击第%d个页面",index]
//                                                   delegate:self
//                                          cancelButtonTitle:@"确定"
//                                          otherButtonTitles:nil];
//    [alert show];
//
//}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
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
    
    for (SDZRelation *relation in (SDZRelationList*)value) {
        NSLog(@"selfidn:%ld rightContTypeId:%@\n selfname:%@\n",relation.selfid,relation.rightContTypeId,relation.selfname);
        
    }
    XLCycleScrollView *csView = [[XLCycleScrollView alloc] initWithFrame:self.view.bounds];
    csView.delegate = self;
    csView.datasource = self;
    [self.view addSubview:csView];
    
}


-(UIView *)pageAtIndex:(NSInteger)index
{
    if (index == 0) {
        return [self createIntroView];
    }else {
        for (SDZRelation *relation in relationList) {
            
            relationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 600, 600)];
            
            rtableVC = [[RelationTableViewController alloc] init];
            NSString *reID =[NSString stringWithFormat:@"%ld",relation.selfid];
            
            rtableVC.relationID = reID;
            rtableVC.tbName = relation.selfname;
            rtableVC.conID = conID;
            rtableVC.conTypeID = conTypeID;
            [rtableVC.view setFrame:relationView.frame];
            [relationView addSubview:rtableVC.view];

            
            return relationView;
        }
    }
    return nil;
}

- (NSInteger)numberOfPages
{
    return [relationList count]+1;
}



-(UIView *)createIntroView{

    UIView *introView = [[UIView alloc] initWithFrame:CGRectMake(0, 30, 600, 500)];
    UIImageView *picView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 220, 210)];
    picView.image = img;
    UILabel *l;
    for (SDZContTypeField *ctf in ctArr) {
        if (!ctf.addressData) {
            l = [[UILabel alloc] initWithFrame:CGRectMake(picView.frame.size.width+20, 10+[ctArr indexOfObject:ctf]*30, 350, 30)];
            l.text = [NSString stringWithFormat:@"%@:%@",ctf.name,ctf.value];
            if ([l.text isEqualToString:@""]) {
            }else {
                [introView addSubview:l];
            }
        }else {
            
        }
    }
    UIImageView *detailIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jieshao.png"]];
    detailIcon.frame = CGRectMake(10, l.frame.origin.y+45, 71, 29);
    UITextView *introText = [[UITextView alloc] initWithFrame:CGRectMake(10, detailIcon.frame.origin.y+29, 580, 250)];
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
