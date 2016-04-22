//
//  ViewController.m
//  NewDemo
//
//  Created by EaseMob on 16/2/22.
//  Copyright (c) 2016年 EaseMob. All rights reserved.
//

#import "ViewController.h"
#import "chatViewController.h"
#import "UserListViewController.h"
#import "MyTableViewController.h"
@interface ViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userText;
@property (weak, nonatomic) IBOutlet UITextField *passWordText;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIView *inderView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
  
    self.inderView.hidden=YES;
    self.detailLabel.hidden=YES;
    self.userText.delegate=self;
    self.passWordText.delegate=self;
    }

- (IBAction)resign:(id)sender {
    self.detailLabel.hidden=NO;
    if (self.userText.text.length==0||self.passWordText.text.length==0) {
        self.detailLabel.text=@"账号或密码不能为空";
    }else
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            EMError *error = [[EMClient sharedClient]registerWithUsername:self.userText.text password:self.passWordText.text];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (!error) {
                    self.detailLabel.text=@"注册成功，点击登陆";
                    
                } else {
                   self.detailLabel.text=@"注册失败";
                                    }
            });
        });

    }
    
}

- (IBAction)login:(id)sender {
    //self.detailLabel.hidden=NO;
    if (self.userText.text.length==0||self.passWordText.text.length==0) {
        self.detailLabel.text=@"账号密码不能为空";
        self.detailLabel.hidden=NO;
    }else
    {
        self.inderView.hidden=NO;
        [self.indicator startAnimating];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            EMError *error = [[EMClient sharedClient]loginWithUsername:self.userText.text password:self.passWordText.text];
          
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (!error) {
                    
                     [[EMClient sharedClient].options setIsAutoLogin:YES];
                    UITabBarController* tab=[[UITabBarController alloc]init];
                    chatViewController* chatVC=[chatViewController new];
                    UINavigationController* naviChat=[[UINavigationController alloc]initWithRootViewController:chatVC];
                    
                    UserListViewController* ListVc=[UserListViewController new];
                    ListVc.myUserID=self.userText.text;
                    UINavigationController* naviList=[[UINavigationController alloc]initWithRootViewController:ListVc];
                    UIStoryboard* sb=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
                    
                    MyTableViewController* myVc=[sb instantiateViewControllerWithIdentifier:@"my"];
                    UINavigationController* naviMy=[[UINavigationController alloc]initWithRootViewController:myVc];
                    tab.viewControllers=@[naviChat,naviList,naviMy];
                    
                    
                    
                    [self.indicator stopAnimating];
                    [self.inderView removeFromSuperview];
//                    [self.navigationController pushViewController:tab animated:YES];
                     [UIApplication sharedApplication].delegate.window.rootViewController=tab;
                    
                    
                } else {
                    [self.indicator stopAnimating];
                    [self.inderView removeFromSuperview];
                    self.detailLabel.hidden=NO;
                    self.detailLabel.text=@"账号密码有误";
                }
            });
        });
    }

    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.detailLabel.hidden=YES;
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
