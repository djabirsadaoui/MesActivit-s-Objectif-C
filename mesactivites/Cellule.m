//
//  Cellule.m
//  MesActivites
//
//  Created by m2sar on 03/12/2014.
//  Copyright (c) 2014 fr.upmc.sar. All rights reserved.
//

#import "Cellule.h"



@implementation Cellule





-(id)initWithLabel:(NSString *)lab andWithDetail:(NSString *)det andWithPriorety:(int)pre andWithMyImage:(UIImage *)img{
    self =[self init];
    [self setLabel:lab];
    [self setDetail:det];
    [self setPriorety:pre];
    [self setMyImage:img];
   
    return self;
}
-(void)dealloc {
    [_label release];
    _label = nil;
    [_detail release];
    _detail = nil;
    [_myImage release];
    _myImage = nil;
    [super dealloc];
}










@end