//
//  ViewController.m
//  MiniProgHeaderView
//
//  Created by 古秀湖 on 2019/1/30.
//  Copyright © 2019 古秀湖. All rights reserved.
//

#import "ViewController.h"
#import "MiniProgHeaderView-Swift.h"
#import <MJRefresh.h>

@interface ViewController ()<MenuViewDelegate>

@property(nonatomic, strong) MenuView *menuVIew;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.menuVIew = [MenuView new];
    self.menuVIew.delegate = self;
    [self.menuVIew setBackgroundColor:[UIColor whiteColor]];
    
    UIView *contentView = [UIView new];
    [contentView setBackgroundColor:[UIColor yellowColor]];
    self.menuVIew.contentView = contentView;
    
    [self.tableView addSubview:self.menuVIew];
    
    //添加个上拉刷新控件
    __weak __typeof(self)weakSelf = self;
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
       
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
               
                [weakSelf.tableView.mj_footer endRefreshing];
            });
        });
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row%2 == 0) {
        [self.menuVIew setContentHeight:160];
    } else {
        [self.menuVIew setContentHeight:80];
    }
}

///在这里处理上拉刷新能不能显示
- (void)menuWithStatusChanged:(BOOL)status{
    
    self.tableView.mj_footer.hidden = status;
}
@end
