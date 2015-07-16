//
//  MonSplitViewCtrl.h
//  MesActivites
//
//  Created by m2sar on 03/12/2014.
//  Copyright (c) 2014 fr.upmc.sar. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "MasterViewCtrl.h"
#import "DetailViewCtrl.h"



@interface MonSplitViewCtrl : UISplitViewController


@property (readwrite, nonatomic, retain) MasterViewCtrl * master;
@property (readwrite, nonatomic, retain) DetailViewCtrl * detail;


@end


