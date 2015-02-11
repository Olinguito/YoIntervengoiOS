//
//  ESObjectPool.h
//  CocoapodsTest
//
//  Created by Bas van Kuijck on 27-09-13.
//
//  [ v1.3.1 ]
//   - Thread Safe
//
//  [ v1.1.1 ]
//   - Fixed void return
//
//  [ v1.1 ]
//   - Renamed instance methods

#import <Foundation/Foundation.h>

@interface ESObjectPool : NSObject

@property (nonatomic, readonly) int capacity;
@property (nonatomic, readonly, getter=isStaticPool) BOOL staticPool;
@property (nonatomic, readonly) int usageCount;
@property (nonatomic, readonly, assign) NSArray *usedObjects;
@property (nonatomic, readonly) int retainedCount;

+(id)dynamicObjectPool;
+(id)staticObjectPool;
-(id)initAsStatic:(BOOL)aIsStatic;
-(void)allocObjectsWithCapacity:(int)aCapacity withClass:(Class)aClass;
-(void)allocObjectsWithCapacity:(int)aCapacity withClass:(Class)aClass withInitBlock:(void (^)(id obj))initBlock;
-(id)pull;
-(void)push:(id)obj;

-(void)drain;
@end
