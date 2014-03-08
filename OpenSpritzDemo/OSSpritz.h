//
//  OSSpritz.h
//  OpenSpritzDemo
//
//  Created by Francesco Mattia on 07/03/14.
//  Copyright (c) 2014 Fr4ncis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OSSpritz : NSObject

+ (int)offsetForWord:(NSString*)word;
+ (NSArray*)spritzString:(NSString*)text;

@end
