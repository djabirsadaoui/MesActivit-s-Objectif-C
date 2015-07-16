//
//  MasterViewCtrl.m
//  MesActivites
//
//  Created by m2sar on 03/12/2014.
//  Copyright (c) 2014 fr.upmc.sar. All rights reserved.
//

#import "MasterViewCtrl.h"
#import "Cellule.h"
#import "MonSplitViewCtrl.h"







@implementation MasterViewCtrl
BOOL fermeDetailVC;
UIImageView * backgrd, *vue_back;
UIImage *img_backgrd_view;
UIImage * img_backgrd;
UIImage *img_header;
NSInteger sect_cel,row_cel;



-(id) initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if(self) {
        contenu = [[NSMutableArray alloc] init];
        section_array = [[NSMutableArray alloc] init];
        fermeDetailVC = YES;
        [[self tableView] setSectionFooterHeight: 80.0];
        [[self tableView] setSeparatorColor: [UIColor blackColor]];
        
        img_backgrd = [[UIImage alloc] init];
        img_backgrd = [UIImage imageNamed: @"bg-tableview-cell.png"];
        img_header = [[UIImage alloc] init];
        img_header = [UIImage imageNamed: @"bg-header.png"];
        
        img_backgrd_view = [[UIImage alloc] init];
        img_backgrd_view = [UIImage imageNamed: @"bg-tableview-cell-sel.png"];
        vue_back= [[UIImageView alloc]initWithImage:img_backgrd_view];
        [[self tableView] setBackgroundView:vue_back];

        backgrd = [[UIImageView alloc] initWithImage: img_backgrd];
        [section_array addObject:@"Vacances"];
        [section_array addObject:@"Personel"];
        [section_array addObject:@"Urgent"];
        [section_array addObject:@"Aujourd'hui"];
        
        // initialiser les sections et rajouter les dans le contenu
        for (int i=0; i < 4 ; i++) {
            NSMutableArray * section = [[NSMutableArray alloc] init];
            [contenu addObject: section];
           
        }
        // ajouter la bar de navigation edit + add
        [[self tableView] setDataSource:self];
        [[self tableView] setDelegate: self];
        [self setTitle: @"Liste des taches"];
        [[self navigationItem] setLeftBarButtonItem: [self editButtonItem]];
         UIBarButtonItem *addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:(UIBarButtonSystemItemAdd) target:self action:@selector(ajout_cell:)];
        [[self navigationItem] setRightBarButtonItem:addButton];
    }
    
    return self;
}


-(void) ajout_cell: (id) sender  {
    Cellule *cell = [[Cellule alloc] initWithLabel:[NSString stringWithFormat:@"Nouvelle Tâche"] andWithDetail:[NSString stringWithFormat:@"Priorité actuelle %d",0] andWithPriorety:0 andWithMyImage:[UIImage imageNamed:(@"prio-0.png")]] ;
    [[contenu objectAtIndex:3] addObject: cell];
    [[self tableView] reloadData];
}
//   la supprission de cellule
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // supprimer la donnée du tableau de contenu
        [[contenu objectAtIndex:[indexPath section]] removeObjectAtIndex:[indexPath row]] ;
        // supprimer la cellule de la vue
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationFade)];
    }
    
}

        // activer le droit de réarrangement
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
        // la méthode qui répond à la réarrangement
-(void) tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    NSInteger sourceSection =[sourceIndexPath section];// récupérer index de la section source
    NSInteger sourceCellule = [sourceIndexPath row]; // récupérer index de la cellule dans la section
    NSInteger destinationSection = [destinationIndexPath section]; // récupérer index la section de déstination
    NSInteger destinationCellule = [destinationIndexPath row]; // récupérer indes de la cellule de déstination
    // supprimer l'objet de la source
    Cellule *cel = [[[contenu objectAtIndex:sourceSection]objectAtIndex:sourceCellule]retain];
    [[contenu objectAtIndex:sourceSection]removeObjectAtIndex:sourceCellule];
    // ajout de la cellule dans le nouveau endroit
    [[contenu objectAtIndex:destinationSection]insertObject:cel atIndex:destinationCellule];
    [[self tableView] reloadData];
    
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    sect_cel =[indexPath section];
    row_cel =[indexPath row];
    _cellule_selected = [[contenu objectAtIndex:sect_cel]objectAtIndex:row_cel];
    [[(MonSplitViewCtrl*)_monSplitvc detail]setCellule:_cellule_selected];
    fermeDetailVC = NO;
    [_monSplitvc setPreferredDisplayMode:(UISplitViewControllerDisplayModeAutomatic)];
    [_monSplitvc showDetailViewController:[[(MonSplitViewCtrl *)_monSplitvc  detail] navigationController] sender:self];
    
    
}

-(void)splitViewController:(UISplitViewController *)svc willChangeToDisplayMode:(UISplitViewControllerDisplayMode)displayMode{
    if (displayMode == UISplitViewControllerDisplayModePrimaryHidden) {
        // terminal est en mode portrail mater est caché
        
        [[[[[(MonSplitViewCtrl *)_monSplitvc  detail]navigationController]topViewController]navigationItem]setLeftBarButtonItem:[svc displayModeButtonItem]];
    }
    if (displayMode==UISplitViewControllerDisplayModeAllVisible) {// les deux vues mster au dessus de détail
               [[[[[(MonSplitViewCtrl *)_monSplitvc detail]navigationController]topViewController]navigationItem]setLeftBarButtonItem:nil];
    }
}
-(UISplitViewControllerDisplayMode) targetDisplayModeForActionInSplitViewController:(UISplitViewController *)svc{
     [[(MonSplitViewCtrl*)_monSplitvc detail]positionner:[[UIScreen mainScreen] bounds].size];
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        return UISplitViewControllerDisplayModeAllVisible;
    }else{
        return UISplitViewControllerDisplayModePrimaryOverlay;
        }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIScreen * ecran = [UIScreen mainScreen];
    CGRect rect = [ecran bounds];
    float w = rect.size.width;
    UIImage* image = [[UIImage alloc] init];
    image =[UIImage imageNamed:@"bg-header.png"];
    UIImageView * viewImage = [[UIImageView alloc]initWithImage:image];
     UIView *v = [[UIView alloc]init];
    [v setFrame:CGRectMake(0, 0, w, 80)];
    [v addSubview:viewImage];
    UILabel *lab = [[UILabel alloc]init];
    [lab setTextColor:[UIColor whiteColor]];
    [lab setFrame:CGRectMake(20.0, 12.0, 100, 25)];
    [lab setText:[section_array objectAtIndex:section]];
    [viewImage release];
    [v addSubview:lab];
    [[self tableView] addSubview:v];
    return v;

}

-(BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController{
    return fermeDetailVC;
}


// hauteur de header
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50.0;
}
// nombre de sections
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return [section_array count];
}
//nombre de cellules par section
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  [[contenu objectAtIndex: section] count];
}

// a chaque changement sur la cellule
-(void)updateCellule:(Cellule *)cel{
    [[contenu objectAtIndex:sect_cel] setObject:cel atIndex:row_cel];
    [[self tableView] reloadData];
     //[[(MonSplitViewCtrl*)_monSplitvc detail]positionner:[[UIScreen mainScreen] bounds].size];
   }


//Remplissage d une cellule
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    Cellule * MyCell = [[contenu objectAtIndex: [indexPath section]]
                         objectAtIndex:[indexPath row]];
    
    NSString * CellId = MyCell.detail;

    //prend une cell morte de la meme prio
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier: CellId];
    // [cellId autorelease];
    if (cell == nil) {
               cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellId];
    }
    [[cell textLabel] setText: [NSString stringWithFormat: @"%@", MyCell.label]];
    [[cell detailTextLabel] setText: [NSString stringWithFormat: @"%@", MyCell.detail]];
    [[cell imageView] setImage:[MyCell myImage]];
    [cell setBackgroundColor:[UIColor colorWithPatternImage:img_backgrd]];
    return cell;
}
-(void) viewDidLoad {
    [super viewDidLoad];   
    fermeDetailVC = YES;
    [[self navigationItem] setTitle:@"Master"];
}



@end
