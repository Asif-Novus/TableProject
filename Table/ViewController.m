//
//  ViewController.m
//  Table
//
//  Created by UsFromMini on 2/16/16.
//  Copyright © 2016 Jamil. All rights reserved.
//

#import "ViewController.h"
#import "Info.h"
#import "AppDelegate.h"


@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *myArray;
@end

@implementation ViewController
@synthesize managedObjectContext;


-(void)viewWillAppear:(BOOL)animated{
    [self get];
}

- (void)get
{
    AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Info"];
    NSArray *fetchData = [[appdelegate.managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    if (fetchData.count) {
        self.myArray    =   [NSArray arrayWithArray:fetchData];
        [self.tableView reloadData];
        
        NSLog(@"Array Count: %zd",  self.myArray.count);
        NSLog(@"Array Here: %@",    self.myArray);
    
    }
}

-(UITableView *)makeTableView
{
    CGFloat x = 0;
    CGFloat y = 100;
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height - 50;
    
    
    CGRect tableFrame = CGRectMake(x, y, width, height);
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:tableFrame style:UITableViewStylePlain];
    
    
    //tableView.backgroundColor = [UIColor blueColor];
    tableView.rowHeight = 45;
    tableView.userInteractionEnabled = YES;
    tableView.delegate = self;
    tableView.dataSource = self;
    
    return tableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    
    
    
    UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(300.0, 40.0, 50.0, 50.0)];
    button.backgroundColor = [UIColor lightGrayColor];
    [button setTitle:@"Next" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(goToNextPage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    self.tableView = [self makeTableView];
    [self.view addSubview:self.tableView];
}

-(void)goToNextPage{
    
    NextViewController *nvc = [[NextViewController alloc]init];
    [self presentViewController:nvc  animated:YES completion:nil];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  [self.myArray count];
 
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50.0;
}




- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    Info *inf=  [self.myArray objectAtIndex:section];

    UILabel* nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width-40*2, 40)];
    nameLabel.text = inf.name;
    nameLabel.backgroundColor = [UIColor brownColor];
    
    return nameLabel;
}

-(NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    Info *inf=[self.myArray objectAtIndex:section];
    return  [inf.detail count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"newCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    Info *inf=[self.myArray objectAtIndex:indexPath.section];
    NSArray *array = [inf.detail allObjects];

    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    Detail *detail=[array objectAtIndex:indexPath.row];
    cell.textLabel.text=[NSString stringWithFormat:@"Dept:%@  ",detail.dept] ;

    return cell;
}



- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NextViewController *nvc = [[NextViewController alloc]init];
    nvc.info=self.myArray[indexPath.row];
    [self presentViewController:nvc animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
