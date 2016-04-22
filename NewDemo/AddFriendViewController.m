//
//  AddFriendViewController.m
//  NewDemo
//
//  Created by apple on 16/3/14.
//  Copyright © 2016年 EaseMob. All rights reserved.
//

#import "AddFriendViewController.h"

@interface AddFriendViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userText;
@property (weak, nonatomic) IBOutlet UITextView *detalTextView;
@property (weak, nonatomic) IBOutlet UILabel *phLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@end

@implementation AddFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.detalTextView.delegate=self;
    
}
- (IBAction)addFriend:(id)sender {
    
    if (self.userText.text.length==0) {
        UIAlertView* alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"好友账号不能为空！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
        [alert show];
    }else
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
           EMError* error=[[EMClient sharedClient].contactManager addContact:self.userText.text message:self.detalTextView.text];
    
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (!error) {
                    
                    UIAlertView* alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"申请信息已经发送" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
                    [alert show];
                }
        
            });
        });
    
    
    }
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    self.phLabel.hidden=YES;
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if ([self.detalTextView.text isEqualToString:@""]) {
        self.phLabel.hidden=NO;
    }else
    {
        self.countLabel.text=@"0";
        self.phLabel.hidden=YES;
    }
}
//textView的字数限定
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (range.location>=50) {
       
        return NO;
    }else
    {
        self.countLabel.text=[NSString stringWithFormat:@"%ld",range.location+1];
        return YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
