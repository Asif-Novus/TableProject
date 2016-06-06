//
//  NextViewController.m
//  Table
//
//  Created by UsFromMini on 2/16/16.
//  Copyright © 2016 Jamil. All rights reserved.
//

#import "NextViewController.h"
#import "AppDelegate.h"

@interface NextViewController () <UITextFieldDelegate>
@property (strong,nonatomic)UITextField* nameField ;
@property (strong,nonatomic)UITextField* ageField;
@property (strong,nonatomic)UITextField* genderField;
@property (strong, nonatomic) IBOutlet UIPickerView *picker;
@property (strong,nonatomic) NSArray* pickerData;
@property(strong,nonatomic) NSString* selectedCategory;
@end

@implementation NextViewController
@synthesize managedObjectContext;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _pickerData = @[@"Item 1", @"Item 2", @"Item 3", @"Item 4", @"Item 5", @"Item 6"];
    self.picker.dataSource = self;
    self.picker.delegate = self;
    self.picker.backgroundColor = [UIColor lightGrayColor];
    UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(20.0, 40.0, 150.0, 50.0)];
    button.backgroundColor = [UIColor grayColor];
    [button setTitle:@"Previous Page" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(goToPreviousPage) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
    UILabel* nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 100, 50, 50)];
    nameLabel.text = @"Name";
    
    [self.view addSubview:nameLabel];
    
    UILabel* ageLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 170, 50, 50)];
    ageLabel.text = @"Age";
    
    [self.view addSubview:ageLabel];
    
    UILabel* genderLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 240, 70,   50)];
    genderLabel.text = @"Gender";
    
    [self.view addSubview:genderLabel];
    
    
    _nameField = [[UITextField alloc]initWithFrame:CGRectMake(80, 100, 200, 50)];
    _nameField.borderStyle = UITextBorderStyleRoundedRect;
    _nameField.font = [UIFont systemFontOfSize:15];
    _nameField.placeholder = @"Enter Name";
    _nameField.autocorrectionType = UITextAutocorrectionTypeNo;
    _nameField.keyboardType = UIKeyboardTypeDefault;
    _nameField.returnKeyType = UIReturnKeyDone;
    _nameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _nameField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _nameField.delegate = self;
    
    [self.view addSubview:_nameField];
    
    
    _ageField = [[UITextField alloc]initWithFrame:CGRectMake(80, 170, 200, 50)];
    _ageField.borderStyle = UITextBorderStyleRoundedRect;
    _ageField.font = [UIFont systemFontOfSize:15];
    _ageField.placeholder = @"Enter Age";
    _ageField.autocorrectionType = UITextAutocorrectionTypeNo;
    _ageField.keyboardType = UIKeyboardTypeDefault;
    _ageField.returnKeyType = UIReturnKeyDone;
    _ageField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _ageField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _ageField.delegate = self;
    
    [self.view addSubview:_ageField];
    
    
    _genderField = [[UITextField alloc]initWithFrame:CGRectMake(80, 240, 200, 50)];
    _genderField.borderStyle = UITextBorderStyleRoundedRect;
    _genderField.font = [UIFont systemFontOfSize:15];
    _genderField.placeholder = @"Enter Gender";
    _genderField.autocorrectionType = UITextAutocorrectionTypeNo;
    _genderField.keyboardType = UIKeyboardTypeDefault;
    _genderField.returnKeyType = UIReturnKeyDone;
    _genderField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _genderField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _genderField.delegate = self;
    
    [self.view addSubview:_genderField];

    
    
    
    UIButton* submitButton = [[UIButton alloc] initWithFrame:CGRectMake(80.0, 310.0, 70.0, 50.0)];
    submitButton.backgroundColor = [UIColor lightGrayColor];
    [submitButton setTitle:@"Submit" forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(submitData:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
    
    if (_info) {
        _nameField.text=_info.name;
        _ageField.text=[_info.age stringValue];
        _genderField.text=_info.gender;
        [submitButton setTitle:@"Update" forState:UIControlStateNormal];
        
        UIButton * deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(200, 40, 150, 50)];
        
        deleteButton.backgroundColor = [UIColor grayColor];
        [deleteButton setTitle:@"Delete" forState:UIControlStateNormal];
        [deleteButton addTarget:self action:@selector(deleteData:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:deleteButton];
        
        

        
    }
    
    
}

-(void)goToPreviousPage{
    
    ViewController *vc = [[ViewController alloc]init];
    [self presentViewController:vc  animated:YES completion:nil];

    
}
-(void) deleteData:(id)sender{
    
    NSLog(@"delete pressed");
    
    AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [appdelegate.managedObjectContext deleteObject: _info];
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![appdelegate.managedObjectContext save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
    [self goToPreviousPage];
}


-(void) submitData:(id)sender{
    
    AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    UIButton *btn=(UIButton*)sender;
    NSLog(@"selected is: %@", _selectedCategory);
    if ([btn.titleLabel.text isEqualToString:@"Update"]) {
        
        _info.name= _nameField.text;
        _info.gender= _genderField.text;
        _info.age = @([_ageField.text intValue]);
    }
    else{
        //    // Create a new managed object
        
        Info *info1 = [NSEntityDescription insertNewObjectForEntityForName:@"Info"
                                                               inManagedObjectContext:appdelegate.managedObjectContext];
        info1.name= _nameField.text;
        info1.gender= _genderField.text;
        info1.age = @([_ageField.text intValue]);
        
        for (int i=0; i<4; i++) {
            Detail *detail = [NSEntityDescription insertNewObjectForEntityForName:@"Detail"
                                                        inManagedObjectContext:appdelegate.managedObjectContext];
            detail.dept= @"ME";
            [info1 addDetailObject:detail];

        }
       
    }
    NSError *error = nil;
    // Save the object to persistent store
    if (![appdelegate.managedObjectContext save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    [self goToPreviousPage];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _pickerData.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    //_selectedCategory = _pickerData[row];
    _genderField.text = _pickerData[row];
    return _pickerData[row];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
