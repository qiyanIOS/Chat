//
//  UserListViewController.m
//  NewDemo
//
//  Created by apple on 16/3/8.
//  Copyright © 2016年 EaseMob. All rights reserved.
//

#import "UserListViewController.h"
#import "EaseMessageViewController.h"
#import "ListTableViewCell.h"
#import "ViewController.h"
#import "AddFriendViewController.h"
#import "RequestTableViewCell.h"
#import "FriendDesViewController.h"
@interface UserListViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,EMContactManagerDelegate>
@property(nonatomic,strong)UITableView* listTableView;
@property(nonatomic,strong)NSArray* listArray;

@property(nonatomic,strong)UIAlertView* suerAlert;
@property(nonatomic,strong)NSString* userId;
@property(nonatomic,strong)UIAlertView* alert;
@property(nonatomic,strong)RequestTableViewCell* cell;
@property(nonatomic,assign)NSInteger count;
@property(nonatomic,strong)NSString* message;
@property(nonatomic,strong)NSMutableArray* requestArray;
@end

@implementation UserListViewController
-(UITableView*)listTableView
{
    if (!_listTableView) {
        _listTableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _listTableView.delegate=self;
        _listTableView.dataSource=self;
    }
    return _listTableView;
}
-(NSMutableArray*)requestArray
{
    if (!_requestArray) {
        _requestArray=[NSMutableArray array];
    }
    return _requestArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    [self getFriendList];
    [self initItem];
    _count=1;
    self.title=@"好友列表";
    //注册好友回调
    [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
  
}
-(void)didReceiveFriendInvitationFromUsername:(NSString *)aUsername message:(NSString *)aMessage
{
   
    
    NSLog(@"来了一条好友请求");
    _cell.bgeCount.layer.cornerRadius=_cell.bgeCount.frame.size.width/2;
    _cell.bgeCount.backgroundColor=[UIColor redColor];
    _cell.bgeCount.layer.masksToBounds=YES;
    _cell.bgeCount.text=[NSString stringWithFormat:@"%ld",_count];
    _count++;
    self.userId=aUsername;
    self.message=aMessage;
    
    NSArray* array=@[aUsername,aMessage];
    //[self.requestArray addObjectsFromArray:@[aUsername,aMessage]];
    [self.requestArray addObject:array];
}

-(void)didReceiveAgreedFromUsername:(NSString *)aUsername
{
    [self getFriendList];
    [self.listTableView reloadData];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView==self.suerAlert) {
        if (buttonIndex==0) {
            EMError* error=[[EMClient sharedClient].contactManager declineInvitationForUsername:_userId];
            if (!error) {
                NSLog(@"拒绝");
            }
        }else
        {
            EMError* error=[[EMClient sharedClient].contactManager acceptInvitationForUsername:_userId];
            if (!error) {
                NSLog(@"加好友成功");
                [self getFriendList];
                [self.listTableView reloadData];
            }
        }

    }else
         {
             if (buttonIndex==1) {
                 EMError* error=[[EMClient sharedClient] logout:YES];
                 if (!error) {
                     UIStoryboard* sb=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
                     ViewController* vc=[sb instantiateViewControllerWithIdentifier:@"login"];
                     [UIApplication sharedApplication].delegate.window.rootViewController=vc;
                     //[self.navigationController popViewControllerAnimated:YES];
                 }
             }
         }
    }
-(void)initItem
{
    NSLog(@"haoyou ");
    UIBarButtonItem* item=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addfriend)];
   
    self.navigationItem.leftBarButtonItem=item;
   

    
    UIBarButtonItem* leftItem=[[UIBarButtonItem alloc]initWithTitle:@"退出" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem=leftItem;
}
-(void)addfriend
{
    UIStoryboard* sb=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AddFriendViewController* addVc=[sb instantiateViewControllerWithIdentifier:@"add"];
    
    [addVc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:addVc animated:YES];
    

}
-(void)back
{
    _alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"多呆一会吗！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"退出", nil];
    _alert.delegate=self;
    [_alert show];
}
-(void)getFriendList
{
    EMError* error=nil;
    self.listArray=[[EMClient sharedClient].contactManager getContactsFromDB];
    if (!error) {
        NSLog(@"获取成功 -- %@",self.listArray);
    }
}
-(void)initTableView
{
    [self.listTableView registerNib:[UINib nibWithNibName:@"ListTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
     [self.listTableView registerNib:[UINib nibWithNibName:@"RequestTableViewCell" bundle:nil] forCellReuseIdentifier:@"requestCell"];
    [self.view addSubview:self.listTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }else
    {
       return self.listArray.count;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
       _cell=[tableView dequeueReusableCellWithIdentifier:@"requestCell"];
        _cell.selectionStyle=UITableViewCellSelectionStyleNone;

        return _cell;
    }else
    {
    ListTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
   // cell.textLabel.text=self.listArray[indexPath.row];
        cell.selectionStyle=UITableViewCellAccessoryNone;
    return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        FriendDesViewController* friendVc=[FriendDesViewController new];
        //[_cell.bgeCount removeFromSuperview];
        friendVc.aUserName=self.userId;
        friendVc.aMessage=self.message;
        friendVc.array=self.requestArray;
        [self.navigationController pushViewController:friendVc animated:YES];
    }
       else
           {
    EaseMessageViewController *cct = [[EaseMessageViewController alloc] initWithConversationChatter:self.listArray[indexPath.row] conversationType:EMConversationTypeChat];
    cct.str=self.listArray[indexPath.row];
        cct.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:cct animated:YES];
           }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    return 80;
}
@end
