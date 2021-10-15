//
//  AppDelegate.m
//  MVVMDemo
//
//  Created by 陈小明 on 2021/5/12.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "MVCViewController.h"
#import "MVPViewController.h"
#import "MVVMViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];

    //MVCViewController *vc = [[MVCViewController alloc] init];
    //MVPViewController *vc = [[MVPViewController alloc] init];
    MVVMViewController *vc = [[MVVMViewController alloc] init];

    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    return YES;
}



@end
