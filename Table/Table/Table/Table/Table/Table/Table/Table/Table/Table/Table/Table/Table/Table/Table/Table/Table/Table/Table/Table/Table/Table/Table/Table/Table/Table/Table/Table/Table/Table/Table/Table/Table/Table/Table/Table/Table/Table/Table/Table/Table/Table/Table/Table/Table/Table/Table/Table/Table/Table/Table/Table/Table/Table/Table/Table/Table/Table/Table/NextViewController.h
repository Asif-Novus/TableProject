//
//  NextViewController.h
//  Table
//
//  Created by UsFromMini on 2/16/16.
//  Copyright © 2016 Jamil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "Info.h"
#import "Detail.h"

@interface NextViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic,strong) Info *info;
@end
