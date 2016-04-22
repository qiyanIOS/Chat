//
//  ListTableViewCell.h
//  NewDemo
//
//  Created by apple on 16/3/14.
//  Copyright © 2016年 EaseMob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *nameId;
@property (weak, nonatomic) IBOutlet UILabel *lastTime;
@property (weak, nonatomic) IBOutlet UILabel *lastChat;

@end
