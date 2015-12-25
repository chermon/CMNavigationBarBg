//
//  ViewController.m
//  CMNavigationBarBg
//
//  Created by shuwang on 15/12/24.
//  Copyright © 2015年 chermon. All rights reserved.
//

#import "HomeViewController.h"
#import "UINavigationBar+BarBackground.h"

#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define NAVBAR_CHANGE_POINT 50
@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    UIView *_topView;
    UIImageView *_topImageView;
}
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, ScreenWidth, ScreenHeight)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
    _topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
    _topImageView.contentMode = UIViewContentModeScaleAspectFill;
    _topImageView.layer.masksToBounds = YES;
    [_topImageView setImage:[UIImage imageNamed:@"background.png"]];
    [_topView addSubview:_topImageView];
    
    _tableView.tableHeaderView = _topView;
    
    UIImageView *imgPhoto = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/2-40,_topView.frame.size.height/4, 80, 80)];
    [imgPhoto setImage:[UIImage imageNamed:@"wo.png"]];
    [_topView addSubview:imgPhoto];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.navigationController.navigationBar bar_backgroundColor:[UIColor clearColor]];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];

    [self scrollViewDidScroll:_tableView];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor * color = [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1];
    
     CGFloat yOffset = _tableView.contentOffset.y;
    
        //下拉图片放大
        if (yOffset < 0) {
            _topView.frame = CGRectMake(0, yOffset, ScreenWidth, 200-yOffset);
            _topImageView.frame = CGRectMake(0, yOffset, ScreenWidth, 200-yOffset);
        }
        
    
    if (yOffset > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - yOffset) / 64));
        [self.navigationController.navigationBar bar_backgroundColor:[color colorWithAlphaComponent:alpha]];
    }else{
        [self.navigationController.navigationBar bar_backgroundColor:[color colorWithAlphaComponent:0]];
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = @"test";
    
    return cell;
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
