//
//  MasterViewCtrl.h
//  MesActivites
//
//  Created by m2sar on 03/12/2014.
//  Copyright (c) 2014 fr.upmc.sar. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "Cellule.h"
#import "DetailViewCtrl.h"




@interface MasterViewCtrl : UITableViewController <UISplitViewControllerDelegate>

@property (readwrite, nonatomic, assign) UISplitViewController * monSplitvc;
@property (nonatomic, copy) Cellule *cellule_selected;
-(void) updateCellule:(Cellule*)cel;
@end
NSMutableArray * contenu;
NSMutableArray * section_array;
