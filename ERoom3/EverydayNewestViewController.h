//
//  EverydayNewestViewController.h
//  ERoom3
//
//  Created by user on 12-11-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClientClass.h"
#import "ERConfiger.h"
#import <MediaPlayer/MediaPlayer.h>

@interface EverydayNewestViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{

    UITableView             *tbView;
    
    SDZfindEverydayNewestList *list;
    
    MPMoviePlayerViewController *mpvc;
}
@property ( strong, nonatomic ) MPMoviePlayerController * movieController;
@end
