//
//  DetailViewCtrl.m
//  MesActivites
//
//  Created by m2sar on 03/12/2014.
//  Copyright (c) 2014 fr.upmc.sar. All rights reserved.
//

#import "DetailViewCtrl.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import "MonSplitViewCtrl.h"


@implementation DetailViewCtrl


UILabel * labeltitle,*prop;
UITextField * txtfield;
UISegmentedControl * segment;
UIImageView * img_view;
UIImage *img,*image_cellule,*image_prio;
UIView * vue;
Cellule * MonCellule;
UIImagePickerController *photoPicker;
UIPopoverController *pop;
NSString *title;
int priority;
NSArray * niveau_prio;
UIDevice *terminal;
bool isIpad;

//ABPeoplePickerNavigationController * abnav;

-(void)setCellule:(Cellule *)cel{
    MonCellule = [[Cellule alloc]init];
    MonCellule = cel;
    [MonCellule setPicture:[cel picture]] ;
    if (!segment) {
    segment = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4", nil]];
    }
    [segment setSelectedSegmentIndex:MonCellule.priorety];
    if (!txtfield) {
         txtfield =[[UITextField alloc]init];
    }
    [txtfield setText:[MonCellule label] ];
   if (MonCellule.picture) {
       [img_view setImage:MonCellule.picture];
        [vue addSubview:img_view];
    }else{
            [img_view removeFromSuperview];
        
        
    }
       [self positionner:[[UIScreen mainScreen]bounds].size];
}


-(void) viewDidLoad {
    [super viewDidLoad];
    [[self navigationItem] setTitle:@"Detail"];
    terminal = [[UIDevice alloc]init];
     isIpad = ([terminal userInterfaceIdiom] ==  UIUserInterfaceIdiomPad);
    UIBarButtonItem *photoButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:(UIBarButtonSystemItemCamera) target:self action:@selector(accesPhoto:)];
    [[self navigationItem] setRightBarButtonItem:photoButton];
    img =[[UIImage alloc]init];
    img = [UIImage imageNamed:@"fond-alu.png"];
    niveau_prio = [NSArray  arrayWithObjects:@"prio-0.png",@"prio-1.png",@"prio-2.png",@"prio-3.png",@"prio-4.png", nil];
    UIScreen * ecran = [UIScreen mainScreen];
    CGRect rect = [ecran bounds];
    vue = [[UIView alloc] initWithFrame:rect];
   
    [vue setBackgroundColor:[UIColor colorWithPatternImage:img]];
    [self setView:vue];
    if (!segment) {
        segment = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4", nil]];
    }         // abnav = [[ABPeoplePickerNavigationController alloc]init];
    labeltitle = [[UILabel alloc]init];
    [labeltitle setText:[NSString stringWithFormat:@"Title:"]];
    [labeltitle setTextColor:[UIColor blackColor]];
     prop = [[UILabel alloc]init];
    [prop setText:[NSString stringWithFormat:@"Priority:"]];
    [prop setTextColor:[UIColor blackColor]];
   
    if (!txtfield) {
        txtfield =[[UITextField alloc]init];
    }
    
    [segment setTintColor:[UIColor whiteColor]];
    [segment setSelectedSegmentIndex:priority];
    [segment addTarget:self action:@selector(change_prio:) forControlEvents:UIControlEventValueChanged];    
    [txtfield setKeyboardAppearance:(UIKeyboardAppearanceLight)];
    [txtfield setDelegate:self];
    [vue addSubview:labeltitle];
    [labeltitle release];
    [vue addSubview:txtfield];
    [txtfield release];
    [vue addSubview:segment];
    [vue addSubview:prop];
    [prop release];
    [segment release];
    [self positionner:[[UIScreen mainScreen]bounds].size];
}
- (void)drawRect:(CGRect)rect{
    [self positionner:[[UIScreen mainScreen]bounds].size];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
     [textField resignFirstResponder];
    
    return true;
}
-(BOOL)textFieldShouldClear:(UITextField *)textField{
    return true;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    [MonCellule setLabel:[textField text]];
    [[(MonSplitViewCtrl*)_monSplitvc master]updateCellule:MonCellule] ;
   
    return true ;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [textField setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5]];
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
     [textField setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0]];
 
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
   
    if ([text isEqual: @"\n"]) {
        //[textView resignFirstResponder];  

        return  false;
    }else{
        
        
        return true;
    }
   
}
-(void)accesPhoto:(id)sender{
    if(!photoPicker){
        photoPicker = [[UIImagePickerController alloc]init];
        [photoPicker setDelegate: self];
    }
    [photoPicker setSourceType:(UIImagePickerControllerSourceTypeCamera)];
    NSArray *mediatype = [UIImagePickerController availableMediaTypesForSourceType:(UIImagePickerControllerSourceTypeCamera)];
    [photoPicker setMediaTypes:mediatype];
    [self presentViewController:photoPicker animated:YES completion:nil];
        
    }
    
-(void) change_prio:(id)sender{
    [MonCellule setPriorety:(int)[segment selectedSegmentIndex]];
    [MonCellule setDetail:[NSString stringWithFormat:@"Priorité actuelle %d",(int)[segment selectedSegmentIndex]]];
    if (!image_prio) {
        image_prio = [[UIImage alloc]init];
    };
    NSUInteger index = [segment selectedSegmentIndex];    
     image_prio = [UIImage imageNamed:[NSString stringWithFormat:@"prio-%d",(int)index]];
    [MonCellule setMyImage:image_prio];
    [[(MonSplitViewCtrl*)_monSplitvc master]updateCellule:MonCellule] ;
   
}



-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];// cacher la fenetre de la bibliothéque
    NSString *mediatype = [info objectForKey:UIImagePickerControllerMediaType];// récupérer le type film ou photo
    if (CFStringCompare((CFStringRef) mediatype, kUTTypeImage, 0)== kCFCompareEqualTo) {// si type est image
         MonCellule.picture =[info objectForKey:UIImagePickerControllerEditedImage];
                if (!MonCellule.picture) {
         MonCellule.picture = [info objectForKey:UIImagePickerControllerOriginalImage];
         }
         if (img_view) {
         [img_view removeFromSuperview];
         [img_view release];
                  }
        img_view = [[UIImageView alloc]initWithImage:MonCellule.picture];
        [[(MonSplitViewCtrl*)_monSplitvc master]updateCellule:MonCellule] ;
        [img_view sizeToFit];      
        [vue addSubview:img_view];
      
        [self positionner:[[UIScreen mainScreen]bounds].size];        
    }else{
        [[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"clef-problem", comment="") message:NSLocalizedString(@"clef-movie", comment="") delegate:nil cancelButtonTitle:NSLocalizedString(@"clef-ok", comment="") otherButtonTitles:nil]show];
    }
    
    
}



-(void)positionner:(CGSize) size; {
    int w = size.width;
    int h = size.height;
    int wtitle = w/(w*0.01);
    int htile = h/(h*0.04);
    int wtxt = w/(w*0.007);
    int wsegmen = w/(w*0.004);
    int hsegmen = h/(h*0.03);
    [labeltitle setFrame:(CGRectMake(10, 70, wtitle, htile))];
    [txtfield setFrame:(CGRectMake(70, 70, wtxt, htile))];
    [prop setFrame:(CGRectMake(10, 110, wtitle, htile))];
    [segment setFrame:(CGRectMake(10, 150, wsegmen, hsegmen))];
       if (MonCellule.picture) {
           if (w >= h) {
               if (isIpad) {
                   [img_view setFrame:CGRectMake(10, 200,(w-340), h-210)];
               }else{
                   [img_view setFrame:CGRectMake(w/2, 80,(w/2)-20, h-100)];
               }
              
           }else{
                [img_view setFrame:CGRectMake(10, 200,(w-20), h-210)];
              
           }

       

    }
    
    
      }


@end