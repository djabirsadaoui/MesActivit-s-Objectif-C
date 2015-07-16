//
//  AppDelegate.m
//  MesActivites
//
//  Created by m2sar on 03/12/2014.
//  Copyright (c) 2014 fr.upmc.sar. All rights reserved.
//

#import "AppDelegate.h"
#import "MonSplitViewCtrl.h"
#import "MasterViewCtrl.h"
#import "DetailViewCtrl.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    MonSplitViewCtrl * splitvc = [[MonSplitViewCtrl alloc] init];
    MasterViewCtrl * mastervc = [[MasterViewCtrl alloc] init];
    DetailViewCtrl * detailvc = [[DetailViewCtrl alloc] init];
   
    [mastervc setMonSplitvc: splitvc];// master=>split
    [splitvc  setMaster: mastervc];// master<=split
    
    [detailvc setMonSplitvc: splitvc]; //detail=>split
    [splitvc  setDetail: detailvc]; //detail<=split
    
    UINavigationController * nmvc = [[UINavigationController alloc] initWithRootViewController:mastervc];
    UINavigationController * ndvc = [[UINavigationController alloc] initWithRootViewController:detailvc];
    
    [splitvc setViewControllers: [NSArray arrayWithObjects: nmvc ,ndvc,nil]];// construction du tableau
    [splitvc setDelegate: mastervc];
         if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone &&
        [[UIScreen mainScreen] scale] != 3.0) {
        
        UIViewController * contVC = [[UIViewController alloc] init];
        [[contVC view] addSubview: [splitvc view]];
        
        UITraitCollection * traiCtrl = [UITraitCollection traitCollectionWithVerticalSizeClass:UIUserInterfaceSizeClassCompact];
        
        [contVC setOverrideTraitCollection: traiCtrl forChildViewController: splitvc];
        [splitvc setPreferredDisplayMode: UISplitViewControllerDisplayModeAllVisible];
        [[self window] setRootViewController:contVC];
        [contVC release];
    }
    else {
        [[self window] setRootViewController: splitvc];
        [splitvc setPreferredDisplayMode: UISplitViewControllerDisplayModeAutomatic];
        
        if ([[UIScreen mainScreen] bounds].size.width < [[UIScreen mainScreen] bounds].size.height) {
            [[[ndvc topViewController] navigationItem] setLeftBarButtonItem: [splitvc displayModeButtonItem]];
            [[[ndvc topViewController] navigationItem] setLeftItemsSupplementBackButton:YES];
            

            
            
        }
       
    }
    
    [[self window] makeKeyAndVisible];
    
    [mastervc release];
    [detailvc release];
    [nmvc release];
    [ndvc release];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
 
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
 
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
