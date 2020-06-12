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
    [self loadData];
    //self.view.backgroundColor = [UIColor colorWithRed:255 green:134 blue:126 alpha:1.0];
    [self creatDownBtn];
    //self.navigationItem.title
}

- (void)initTableView{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.estimatedRowHeight = 80;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    //self.tableView.tableFooterView = [[UIView alloc]init];
    self.spinner.backgroundColor = [UIColor redColor];
    self.spinner.tintColor = [UIColor greenColor];
    self.spinner.attributedTitle = [[NSAttributedString alloc] initWithString:@"刷新下载列表"];
    [self.tableView addSubview:self.spinner];
    [self.tableView sendSubviewToBack:self.spinner];
     [self.refreshControl addTarget:self  action:@selector(handleRefresh:)  forControlEvents:UIControlEventValueChanged];
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
        [self.spinner endRefreshing];
        [self.tableView reloadData];
        
    });
}

-(void)reloadByRow:(NSInteger)row{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)creatDownBtn{
    kScreenWidth = self.view.bounds.size.width;
    kScreenHeight = self.view.bounds.size.height;
    addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(20, kScreenHeight - 90,kScreenWidth - 40,50);
    [addBtn setTitle:@"Add" forState:UIControlStateNormal];
    addBtn.layer.cornerRadius = 30;
    addBtn.backgroundColor = [UIColor redColor];
    [addBtn addTarget:self action:@selector(addFriend) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:addBtn];
    [self.tableView bringSubviewToFront:addBtn];
    btnY = (int)addBtn.frame.origin.y;
}


#pragma mark 实现代理方法固定悬浮按钮的位置
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    addBtn.frame = CGRectMake(20, btnY + self.tableView.contentOffset.y, kScreenWidth - 40, 50);
    
}

 - (void) handleRefresh:(id)paramSender{
     [self loadData];
 }

- (void)loadData{
    NSString *token = getUserToken(false);
    if(token.length == 0) {
        token = getUserToken(true);
    }
    [_model loadData:token];
}

- (void)addFriend{
    NSString *friendToken = @"dhdhdhdf";
    [_model addOrRemoveFriend:friendToken type:1];
}
@end
