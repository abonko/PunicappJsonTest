//
//  PJTMainTableViewCell.m
//  PunicappJsonTest
//
//  Created by Александр Бонко on 2/28/17.
//  Copyright © 2017 PunicApp. All rights reserved.
//

#import "PJTMainTableViewCell.h"

@interface PJTMainTableViewCell ()

    @property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation PJTMainTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void) setItem:(PJTItem *)item{
    _item = item;
    _titleLabel.text = item.title;
}

@end
