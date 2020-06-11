//
//  FriendViewCell.m
//  Assistance
//
//  Created by wenpeiding on 10/06/2020.
//  Copyright © 2020 wenpeiding. All rights reserved.
//

#import "FriendViewCell.h"

@implementation FriendViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    return self;
}

- (void)showImageWithData:(NSData *)imageData{
    UIImage *image = [UIImage imageWithData:imageData];
    if(!image) {
        image = [UIImage imageNamed:@"person_default"];
    }
    self.imageView.image = image;
}
@end