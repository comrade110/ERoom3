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
    [[ClientClass shareNavService] getMoudleIdByModuleEntry:self action:@selector(getMoudleIdByModuleEntryHandler:) sessionId:[ERConfiger shareERConfiger].sessionID moduleEntry:self.targetID];

	// Do any additional setup after loading the view.
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
    long result = (long)value;
    NSLog(@"result:%ld",result);
    
    [[ClientClass shareNavService] findContTypeAndCatalogGroupAndCatalog:self action:@selector(findHandler:) sessionId:[ERConfiger shareERConfiger].sessionID moduleId:[NSString stringWithFormat:@"%d",2]];
    
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

        
        NSLog(@"%@",(NSDictionary*)value);

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
