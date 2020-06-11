//
//  ViewController.m
//  Assistance
//
//  Created by wenpeiding on 09/06/2020.
//  Copyright © 2020 wenpeiding. All rights reserved.
//

#import "ViewController.h"
#import "View/FriendViewCell.h"
#import "Utils/Constants.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initTableView];
    
    _model = [[FriendModel alloc]init];
    _model.delegate = self;
    NSString *token = getUserToken(false);
    if(token.length == 0) {
        token = getUserToken(true);
    }
    [_model loadData:token];
    //self.view.backgroundColor = [UIColor colorWithRed:255 green:134 blue:126 alpha:1.0];
}

- (void)initTableView{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //[self.tableView //setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.estimatedRowHeight = 80;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.tableFooterView = [[UIView alloc]init];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dealloc{
    NSLog(@"ViewController dealloc");
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdentifier = @"reuseIdentifier";
    FriendViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if(cell == nil) {
        cell = [[FriendViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    }
    FriendEntity *entity = [_model itemWithIndexPath:indexPath.row];
    if(entity.name.length == 0) {
        cell.textLabel.text = entity.token;
    } else {
        cell.textLabel.text = entity.name;
    }
    
    if(entity.number.length == 0) {
        cell.detailTextLabel.text = @"no number";
    } else {
        cell.detailTextLabel.text = entity.number;
    }
    
    [cell showImageWithData:entity.imageData];
    NSLog(@"row:%ld", indexPath.row);
    
    return cell;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"count:%lu", _model.dataSource.count);
    return _model.dataSource.count;
}

- (void)loadComplete{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"reload:%@", _model.dataSource);
        [self.tableView reloadData];
        
    });
}

-(void)reloadByRow:(NSInteger)row{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
}
@end
