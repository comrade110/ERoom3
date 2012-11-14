//
//  NaviViewController.m
//  ERoom3
//
//  Created by user on 12-11-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NaviViewController.h"



@implementation NaviViewController

@synthesize targetID;

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
    UIImageView *bg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 80, 1024, 39)];
    bg.image = [UIImage imageNamed:@"cityw_daohangt.png"];
    sv = [[UIScrollView alloc] initWithFrame:CGRectMake(300, 80, 994, 39)];
    
    sv.delegate = self;
    
    [self.view addSubview:bg];
    [self.view addSubview:sv];
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
        UIButton *topbtn = [[UIButton alloc] initWithFrame:CGRectMake(mcount*120, 30, 90, 30)];
        [topbtn setTitle:module.name forState:UIControlStateNormal];
        [topbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        topbtn.tag = mcount;
        mcount++;
        [self.view addSubview:topbtn];
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
    NSNumber *result = (NSNumber*)value;
    
    [[ClientClass shareNavService] findAllModules:self action:@selector(findAllModulesHandler:) sessionId:[ERConfiger shareERConfiger].sessionID];
    
    [[ClientClass shareNavService] findContTypeAndCatalogGroupAndCatalog:self action:@selector(findHandler:) sessionId:[ERConfiger shareERConfiger].sessionID moduleId:[result stringValue]];
    
    
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
        
    for (NSDictionary *dic in result.valueArr) {
        [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            UILabel *type = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, 40, 39)];
            type.text = [key substringFromIndex:2];
            type.textColor = [UIColor whiteColor];
            type.backgroundColor = [UIColor clearColor];
            [self.view addSubview:type];
            NSArray *objArr = obj;
            for (int i=0; i<[objArr count]; i++) {
                
                NSDictionary *objdic = [objArr objectAtIndex:i];
                [objdic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10+i*90, 3, 80, 39)];
                    btn.tag = (int)key;
                    NSLog(@"obj:%@",obj);
                    btn.titleLabel.font = [UIFont systemFontOfSize:11.0f];
                    [btn setTitle:(NSString*)obj forState:UIControlStateNormal];
                    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    [sv addSubview:btn];
                    
                }];
                
            }
        }];
    }

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
