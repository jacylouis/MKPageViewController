//
//  ViewController.m
//  MKPageViewController
//
//  Created by MarkXiu on 16/7/9.
//  Copyright © 2016年 xsm. All rights reserved.
//

#import "ViewController.h"
#import "MKViewController.h"
#import "CustomViewController.h"
@interface ViewController ()<MKViewControllerDelegate ,MKViewControllerDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)click:(id)sender {
    MKViewController *vc = [[MKViewController alloc] init];
    vc.delegate = self;
    vc.dataSource = self;
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)numbersOfChildViewControllerInMkViewController:(MKViewController *)viewController {
    return 10;
}

- (UIViewController *)MKViewController:(MKViewController *)viewController ViewControllerAtIndex:(NSInteger)index {    CustomViewController *vc = [[CustomViewController alloc] init];
    return vc;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
