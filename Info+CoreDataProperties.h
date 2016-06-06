//
//  Info+CoreDataProperties.h
//  Table
//
//  Created by UsFromMini on 2/16/16.
//  Copyright © 2016 Jamil. All rights reserved.
//
//  Delete this file and regenerate it using "Create NSManagedObject Subclass…"
//  to keep your implementation up to date with your model.
//

#import "Info.h"

NS_ASSUME_NONNULL_BEGIN

@interface Info (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *age;
@property (nullable, nonatomic, retain) NSString *gender;
@property (nullable, nonatomic, retain) NSSet<Detail *> *detail;

@end

@interface Info (CoreDataGeneratedAccessors)

- (void)addDetailObject:(Detail *)value;
- (void)removeDetailObject:(Detail *)value;
- (void)addDetail:(NSSet<Detail *> *)values;
- (void)removeDetail:(NSSet<Detail *> *)values;

@end

NS_ASSUME_NONNULL_END
