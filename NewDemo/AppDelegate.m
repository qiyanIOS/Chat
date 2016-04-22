//
//  AppDelegate.m
//  NewDemo
//
//  Created by EaseMob on 16/2/22.
//  Copyright (c) 2016年 EaseMob. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "UserListViewController.h"
#import "MyTableViewController.h"
#import "chatViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
    _window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor=[UIColor whiteColor];
    [_window makeKeyAndVisible];
    
    UIStoryboard* sb=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController* vc=[sb instantiateViewControllerWithIdentifier:@"login"];
    _window.rootViewController=[[UINavigationController alloc]initWithRootViewController:vc];
    
    

    
    //AppKey:注册的appKey，详细见下面注释。
    //apnsCertName:推送证书名(不需要加后缀)，详细见下面注释。
    EMOptions *options = [EMOptions optionsWithAppkey:@"qiyandemo#mychat"];
    options.apnsCertName = @"nil";
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    
    if ([EMClient sharedClient].options.isAutoLogin) {
        NSLog(@"33");
        
        UITabBarController* tab=[[UITabBarController alloc]init];
        chatViewController* chatVC=[chatViewController new];
        UINavigationController* naviChat=[[UINavigationController alloc]initWithRootViewController:chatVC];
        
        UserListViewController* ListVc=[UserListViewController new];
    
        UINavigationController* naviList=[[UINavigationController alloc]initWithRootViewController:ListVc];
        UIStoryboard* sb=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        MyTableViewController* myVc=[sb instantiateViewControllerWithIdentifier:@"my"];
        
        UINavigationController* naviMy=[[UINavigationController alloc]initWithRootViewController:myVc];
        tab.viewControllers=@[naviChat,naviList,naviMy];
        
        

        _window.rootViewController=tab;
        
    }
    


    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     [[EMClient sharedClient] applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
      [[EMClient sharedClient] applicationWillEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
