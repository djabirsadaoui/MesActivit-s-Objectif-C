//
//  DetailViewCtrl.h
//  MesActivites
//
//  Created by m2sar on 03/12/2014.
//  Copyright (c) 2014 fr.upmc.sar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cellule.h"


@interface DetailViewCtrl : UIViewController<UITextFieldDelegate,UITextViewDelegate,UIImagePickerControllerDelegate>


@property (readwrite, nonatomic, retain) UISplitViewController * monSplitvc;
-(void) setCellule:(Cellule*)cel;




@end
