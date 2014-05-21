//
//  OSSpritzLabel.m
//  OpenSpritzDemo
//
//  Created by Francesco Mattia on 08/03/14.
//  Copyright (c) 2014 Fr4ncis. All rights reserved.
//

#import "OSSpritzLabel.h"
#import "OSSpritz.h"

#define kInterspace 2.0f
#define maxWordLength 18
#define pivotChar 9
#define guideHeight 9

@implementation OSSpritzLabel {
    UIFont *font;
    NSArray *labelViews;
    NSArray *spritzedText;
    NSInteger currentChar;
    int currentWord;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self setUp];
    }
    return self;
}

- (void)setUp
{
    font = [UIFont fontWithName:@"Menlo-Bold" size:20.0f];
    float charWidth = [@"m" sizeWithAttributes:@{NSFontAttributeName:font}].width;
    
    // Draw guidelines first so they're on the bottom
    [self drawGuideLines];
    
    for (int i = 0; i < 18; i++)
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i*(charWidth+kInterspace), 0, charWidth, self.frame.size.height)];
        
        label.textAlignment = NSTextAlignmentCenter;
        label.font = font;
        label.backgroundColor = [UIColor redColor]; // HIT - individual letter background color (needs to match field bg color)
        if (i==pivotChar) label.textColor = [UIColor blueColor]; // HIT - this is now set in the for loop below
        label.alpha = 0;
        label.text = @"m";
        [self addSubview:label];
    }
    
    self.wordsPerMinute = 250;
    labelViews = [self.subviews copy];
    currentWord = 0;
    currentChar = 0;
    
    // HIT -- color all label views properly including the pivot char
    for (int i = 0; i < [labelViews count]; i++)
    {
        if (i == pivotChar)
            continue;
        
        UILabel *label = ((UILabel*)labelViews[i]);
        
        label.textColor = [UIColor greenColor];
    }
}

- (void)drawGuideLines
{
    float guideX = ((UIView*)labelViews[pivotChar]).center.x;
    //// Abstracted Attributes
    UIBezierPath* upperLinePath = [UIBezierPath bezierPathWithRect:CGRectMake(0,  0, self.frame.size.width, 1)];
    UIBezierPath* upperGuidePath = [UIBezierPath bezierPathWithRect:CGRectMake(guideX, 0, 1, guideHeight)];
    UIBezierPath* downLinePath = [UIBezierPath bezierPathWithRect:CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1)];
    UIBezierPath* downGuidePath = [UIBezierPath bezierPathWithRect:CGRectMake(guideX, self.frame.size.height-1-guideHeight, 1, guideHeight)];
    
    NSArray *paths = @[upperLinePath, upperGuidePath, downGuidePath, downLinePath];
    
    
    for (UIBezierPath *path in paths)
    {
        CAShapeLayer *line = [CAShapeLayer layer];
        line.path=path.CGPath;
        line.fillColor = [UIColor blackColor].CGColor;
        line.opacity = 1.0;
        line.strokeColor = nil;
        [self.layer addSublayer:line];
    }
//    UIBezierPath *boxPath = [UIBezierPath bezierPath];
//
//    // Set the starting point of the shape.
//    [boxPath moveToPoint:CGPointMake(0.0, 0.0)];
//    
//    // Draw the lines.
//    [boxPath addLineToPoint:CGPointMake(self.frame.size.width, 0.0)];
//    [boxPath addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
//    [boxPath addLineToPoint:CGPointMake(0.0, self.frame.size.height)];
//    [boxPath closePath];
//    
//    // Create a layer from the bezier path
//    CAShapeLayer *boxLayer = [CAShapeLayer layer];
//    boxLayer.fillRule = kCAFillRuleEvenOdd;
//    boxLayer.fillColor = [UIColor redColor].CGColor;
//    boxLayer.path = boxPath.CGPath;
//    
//    // Add the layer to the window
//    [self.layer addSublayer:boxLayer];
//    
////    // Determine the center of the pivot character
//    float guideX = ((UIView*)labelViews[pivotChar]).center.x;
////
////    // Create pivot char guide paths
////    UIBezierPath* upperGuidePath = [UIBezierPath bezierPathWithRect:CGRectMake(guideX, 0, 1, guideHeight)];
////    UIBezierPath* lowerGuidePath = [UIBezierPath bezierPathWithRect:CGRectMake(guideX, self.frame.size.height-1-guideHeight, 1, guideHeight)];
////    
////    NSArray *paths = @[upperGuidePath, lowerGuidePath];
////    
////    // Iterate over the two paths defining attributes and adding them to the window
////    for (UIBezierPath *path in paths)
////    {
////        CAShapeLayer *line = [CAShapeLayer layer];
////        line.path=path.CGPath;
////        line.fillColor = [UIColor blueColor].CGColor;
////        line.opacity = 1.0;
////        line.strokeColor = nil;
////        [self.layer addSublayer:line];
////    }
//    
//    
//    
//  
//     //// Abstracted Attributes                                                //x, y width        heaight
//     UIBezierPath* upperLinePath = [UIBezierPath bezierPathWithRect:CGRectMake(0,  0, self.frame.size.width, 1)];
//     UIBezierPath* upperGuidePath = [UIBezierPath bezierPathWithRect:CGRectMake(guideX, 0, 1, guideHeight)];
//     UIBezierPath* downLinePath = [UIBezierPath bezierPathWithRect:CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1)];
//     UIBezierPath* downGuidePath = [UIBezierPath bezierPathWithRect:CGRectMake(guideX, self.frame.size.height-1-guideHeight, 1, guideHeight)];
//  
//     NSArray *paths = @[upperLinePath, upperGuidePath, downGuidePath, downLinePath];
//  
//  
//     for (UIBezierPath *path in paths)
//     {
//         CAShapeLayer *line = [CAShapeLayer layer];
//         line.path=path.CGPath;
//         line.fillColor = [UIColor blackColor].CGColor;
//         line.opacity = 1.0;
//         line.strokeColor = nil;
//         [self.layer addSublayer:line];
//     }
  
  
  

}

- (void)setText:(NSString *)text
{
    _text = text;
    spritzedText = [OSSpritz spritzString:text];
}

- (void)start
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    if (currentWord >= [spritzedText count]) {
        currentWord = 0;
        currentChar = 0;
        return;
    }
    
    [self displayStringAndHighlight];
    
    float timeMod = [OSSpritz timeForWord:spritzedText[currentWord]];
    
    currentWord++;
    NSTimeInterval interval = 60.0 / (float)self.wordsPerMinute * timeMod;
    [self performSelector:@selector(start) withObject:nil afterDelay:interval];
}

- (BOOL)characterIsPartOfWordAtLocation:(int)location
{
    static NSCharacterSet *separatorCharset;
    separatorCharset = [NSCharacterSet characterSetWithCharactersInString:@" \n"];
    return [[_text substringWithRange:(NSRange){location, 1}] stringByTrimmingCharactersInSet:separatorCharset].length == 0;
}

- (void)gotoWordAtLocation:(int)location
{
    while ([self characterIsPartOfWordAtLocation:location]) {
        location++;
    }
    
    // find currentWord and sets currentChar from char position
    currentChar = location;
    NSString *partial = [_text substringToIndex:currentChar+1];
    //NSLog(@"partial: %@", partial);
    NSArray *spritzPartial = [OSSpritz spritzString:partial];
    int i = 0;
    while ([spritzPartial[i] isEqualToString:spritzedText[i]] && i < [spritzPartial count]-1) { i++; }
    //NSLog(@"last word: %@", spritzPartial[i]);
    currentChar -= [spritzPartial[i] length];
    currentChar = MAX(currentChar, 0); // fix issue with first word
    currentWord = i;
    
    [self displayStringAndHighlight];
}

- (void)displayStringAndHighlight
{
    NSString *currentWordStr = spritzedText[currentWord];
    [self placeInLabels:currentWordStr];
    //NSLog(@"search in: %@", [_text substringWithRange:(NSRange){currentChar,[_text length]-currentChar}]);
    if ([currentWordStr length] > 0 && [[currentWordStr substringFromIndex:([currentWordStr length]-1)] isEqualToString:@"-"])
    {
        currentWordStr = [currentWordStr substringToIndex:[currentWordStr length]-1];
    }
    NSRange range = [_text rangeOfString:currentWordStr options:NSLiteralSearch range:(NSRange){currentChar,[_text length]-currentChar}];
    if (range.location != NSNotFound)
    {
        currentChar = range.location + range.length;
        //NSLog(@"Range: %d %d", range.location, range.length);
        if ([self.delegate respondsToSelector:@selector(highlightRange:)])
        {
            [self.delegate highlightRange:range];
        }
    }
}

- (void)placeInLabels:(NSString*)word
{
    int offset = [OSSpritz offsetForWord:word];
    for (int i = 0; i < [labelViews count]; i++)
    {
        UILabel *label = ((UILabel*)labelViews[i]);
        
        if (i < offset)
            label.alpha = 0;
        
        else if (i >= offset && i < word.length + offset)
        {
            label.alpha = 1;
            label.text = [word substringWithRange:(NSRange){i-offset,1}];
        }
        
        else
            label.alpha = 0;
    }
}

- (void)pause
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

@end