//
//  RequestTableViewCell.m
//  NewDemo
//
//  Created by apple on 16/3/14.
//  Copyright © 2016年 EaseMob. All rights reserved.
//

#import "RequestTableViewCell.h"

@implementation RequestTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        NSLog(@"走不走着");
        self.bgeCount.layer.cornerRadius=15;
        self.bgeCount.backgroundColor=[UIColor redColor];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
