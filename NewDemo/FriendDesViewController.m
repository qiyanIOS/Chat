//
//  FriendDesViewController.m
//  NewDemo
//
//  Created by apple on 16/3/14.
//  Copyright © 2016年 EaseMob. All rights reserved.
//

#import "FriendDesViewController.h"
#import "friendTableViewCell.h"

@interface FriendDesViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView* tableView;


@end

@implementation FriendDesViewController
-(UITableView*)tableView
{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   self.title=@"好友请求";
    [self initTableView];
}
-(void)initTableView
{
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"friendTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return self.array.count;
    }else
    {
        return 0;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    friendTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    NSArray* decArray=self.array[indexPath.row];
    cell.nameLabel.text=decArray[0];
    cell.messageLabel.text=decArray[1];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 140;
    }else
    {
        return 0;
    }
}
@end
