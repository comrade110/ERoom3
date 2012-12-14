//
//  MealViewController.m
//  ERoom3
//
//  Created by user on 12-12-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MealViewController.h"

@interface MealViewController ()

@end

@implementation MealViewController

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
    
    [[ClientClass shareUserService] findCatalogs:self action:@selector(findCatalogsHandler:) sessionId:[ERConfiger shareERConfiger].sessionID goodsType:@"1"];
    
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


-(void)findCatalogsHandler:(id)value{
    
    if ([value isKindOfClass:[NSError class]]) {
        NSLog(@"Error: %@", value);
        return;
    }
    if ([value isKindOfClass:[SoapFault class]]) {
        NSLog(@"Fault: %@", value);
        return;
    }
    SDZHotelGoodsCatalogList *list = (SDZHotelGoodsCatalogList*)value;
    
    for (SDZHotelGoodsCatalog *gc in list) {
        NSLog(@"%@:%@\n=======",gc.catalog ,gc.type);
    }

}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

@end
