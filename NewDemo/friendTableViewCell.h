//
//  friendTableViewCell.h
//  NewDemo
//
//  Created by apple on 16/3/15.
//  Copyright © 2016年 EaseMob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface friendTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *txImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@end
