//
//  ESObjectPool.m
//  CocoapodsTest
//
//  Created by Bas van Kuijck on 27-09-13.
//
//

#import "ESObjectPool.h"
typedef void (^ObjectBlock)(id obj);
@interface ESObjectPool ()
{
    Class _allocClass;
    NSMutableArray *_pool;
    NSMutableArray *_inUse;
    ObjectBlock _initBlock;
    
}

-(id)_create;
@end
@implementation ESObjectPool
@synthesize capacity,staticPool=_staticPool,usageCount,retainedCount,usedObjects;

#pragma mark - Constructor
// ____________________________________________________________________________________________________________________

+(id)dynamicObjectPool
{
    ESObjectPool *pool = [[self.class alloc] initAsStatic:NO];
#if !__has_feature(objc_arc)
    [pool autorelease];
#endif
    return pool;
}

+(id)staticObjectPool
{
    ESObjectPool *pool = [[self.class alloc] initAsStatic:YES];
#if !__has_feature(objc_arc)
    [pool autorelease];
#endif
    return pool;
}

-(id)initAsStatic:(BOOL)aIsStatic
{
    if (self = [super init]) {
        _staticPool = aIsStatic;
        @synchronized(self) {
            _pool = [[NSMutableArray alloc] init];
            _inUse = [[NSMutableArray alloc] init];
        }
    }
    return self;
}

-(void)allocObjectsWithCapacity:(int)aCapacity withClass:(Class)aClass
{
    [self allocObjectsWithCapacity:aCapacity withClass:aClass withInitBlock:nil];
}

-(void)allocObjectsWithCapacity:(int)aCapacity withClass:(Class)aClass withInitBlock:(void (^)(id obj))initBlock
{
    if (aCapacity <= 0) { return; }
    _allocClass = aClass;
    _initBlock = [initBlock copy];
    @synchronized(self) {
        for (int i = 0; i < aCapacity; i++) {
            [_pool addObject:[self _create]];
        }
    }
}

-(id)_create
{
    id obj = [_allocClass alloc];
    if (_initBlock != nil) {
        _initBlock(obj);
    }
    return obj;
    
}

#pragma mark - Pulling
// ____________________________________________________________________________________________________________________

-(id)pull
{
    @synchronized(self) {
        if (self.capacity == 0) {
            return nil;
        }
        
        if (self.usageCount == 0) {
            if (self.isStaticPool) {
                [NSException raise:@"pool drained" format:@"Object pool is drained, original capacity: %i", self.capacity];
                return nil;
            }
            [_pool addObject:[self _create]];
        }
        for (int i = 0; i < self.capacity; i++) {
            id obj = _pool[i];
            if (![_inUse containsObject:obj]) {
                [_inUse addObject:obj];
                return obj;
            }
        }
        
        return nil;
    }
}

-(void)push:(id)obj
{
    if (self.retainedCount == 0) {
        [NSException raise:@"pool is full" format:@"The objectpool is full, maximum capacity: %i", self.capacity];
        return;
    }
    if (![obj isKindOfClass:_allocClass]) {
        [NSException raise:@"invalid class" format:@"The objectclass you're trying to push into the pool (%@) should be a instance of the class %@", NSStringFromClass([obj class]), NSStringFromClass(_allocClass)];
        return;
    }
    @synchronized(self) {
        if (![_pool containsObject:obj]) {
            
            [NSException raise:@"invalid object" format:@"The object is not available in the pool %@", NSStringFromClass([obj class])];
            return;
        }
        [_inUse removeObject:obj];
    }
}

-(int)usageCount
{
    return self.capacity - self.retainedCount;
}

- (int)capacity
{
    @synchronized(self) {
        return (int)_pool.count;
    }
}

-(int)retainedCount
{
    @synchronized(self) {
        return (int)_inUse.count;
    }
}

- (NSArray *)usedObjects
{
    @synchronized(self) {
        return [NSArray arrayWithArray:_inUse];
    }
}

#pragma mark - Destructor
// ____________________________________________________________________________________________________________________


-(void)drain
{
    @synchronized(self) {
        [_inUse removeAllObjects];
        for (id obj in _pool) {
#if !__has_feature(objc_arc)
            [obj release];
#endif
        }
        [_pool removeAllObjects];
    }
}


- (void)dealloc
{
    [self drain];
#if !__has_feature(objc_arc)
    [_pool release], _pool = nil;
    [_inUse release], _inUse = nil;
    [_initBlock release], _initBlock = nil;
#endif
    [super dealloc];
}
@end