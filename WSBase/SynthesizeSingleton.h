//
//  SynthesizeSingleton.h
//  BaseStaticLibrary
//
//  Created by wrs on 15/4/18.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#ifndef BaseStaticLibrary_SynthesizeSingleton_h
#define BaseStaticLibrary_SynthesizeSingleton_h

#define SYNTHESIZE_SINGLETON_FOR_CLASS(classname) \
\
static classname *shared##classname = nil; \
\
+ (classname *)shared##classname \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [[self alloc] init]; \
} \
} \
\
return shared##classname; \
} \
\
+ (id)allocWithZone:(NSZone *)zone \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [super allocWithZone:zone]; \
return shared##classname; \
} \
} \
\
return nil; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return self; \
} \
\
//- (id)retain \
//{ \
//return self; \
//} \
\
- (NSUInteger)retainCount \
{ \
return NSUIntegerMax; \
} \
\
//- (void)release \
//{ \
//} \
//\
//- (id)autorelease \
//{ \
//return self; \
//}



/*******************GCD******************/
#define DEFINE_SHARED_INSTANCE_USING_BLOCK(block) \
static dispatch_once_t onceToken = 0; \
__strong static id sharedInstance = nil; \
dispatch_once(&onceToken, ^{ \
sharedInstance = block(); \
}); \
return sharedInstance; \


//  用法
//+ (BVARCSingleton *) sharedInstance
//{
//    DEFINE_SHARED_INSTANCE_USING_BLOCK(^{
//        return [[self alloc] init];
//    });
//}


#endif
