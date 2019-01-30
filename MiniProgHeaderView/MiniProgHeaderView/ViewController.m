//
//  ViewController.m
//  MiniProgHeaderView
//
//  Created by 古秀湖 on 2019/1/30.
//  Copyright © 2019 古秀湖. All rights reserved.
//

#import "ViewController.h"
#import "MiniProgHeaderView-Swift.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    MenuView *menu = [MenuView new];
    menu.backgroundColor = [UIColor whiteColor];
    [self.tableView addSubview:menu];
}


@end
