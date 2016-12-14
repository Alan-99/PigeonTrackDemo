//
//  CustomAutoCompleteCellTableViewCell.m
//  YingYanSDKDemo
//
//  Created by alan on 16/12/6.
//  Copyright © 2016年 Baidu. All rights reserved.
//

#import "CustomAutoCompleteCellTableViewCell.h"

@implementation CustomAutoCompleteCellTableViewCell

- (id)init
{
    self = [super init];
    if(self){
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self){
        [self initialize];
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    //The view that is displayed just above the background view when the cell is selected.
    [self setSelectedBackgroundView:[self purpleSelectedBackgroundView]];
}

- (UIView *)purpleSelectedBackgroundView
{
    UIView *selectedBackgroundView = [[UIView alloc]initWithFrame:self.bounds];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = selectedBackgroundView.bounds;
    gradientLayer.colors = @[(id)[[UIColor purpleColor] CGColor],
                             (id)[[UIColor colorWithRed:89/225.0 green:47/225.0 blue:115/225.0 alpha:1.0]CGColor]];
    [selectedBackgroundView.layer insertSublayer:gradientLayer atIndex:0];
    return selectedBackgroundView;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self initialize];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
