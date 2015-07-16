//
//  Cellule.h
//  MesActivites
//
//  Created by m2sar on 03/12/2014.
//  Copyright (c) 2014 fr.upmc.sar. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>




@interface Cellule : NSObject

@property(readwrite,copy)NSString *label;
@property(readwrite,retain)NSString *detail;
@property (nonatomic, copy) UIImage *myImage;
@property(readwrite,assign)int priorety;
@property (nonatomic, retain) UIImage *picture;


//andWithMyImage:(UIImage*)myImg
-(id)initWithLabel:(NSString*)lab andWithDetail:(NSString*)det andWithPriorety:(int)pre andWithMyImage:(UIImage*)img;



@end