//
//  PJTItemDetailsViewController.m
//  PunicappJsonTest
//
//  Created by Александр Бонко on 3/1/17.
//  Copyright © 2017 PunicApp. All rights reserved.
//

#import "PJTItemDetailsViewController.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"

@interface PJTItemDetailsViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation PJTItemDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_imageView setImageWithURL:[NSURL URLWithString:_item.img] placeholderImage:[UIImage imageNamed:@"android.png"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _titleLabel.text = _item.title;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
