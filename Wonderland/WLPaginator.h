//
//  WLPaginator.h
//  Wonderland
//
//  Created by Hoan Tran on 8/20/14.
//  Copyright (c) 2014 Bluepego Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>

// WLPaginator is a utility class that encapsulates the logic of
//	determining how much text will fit on each page of the
//	book interface.
// The calculations required are not trivial, so the work is
//	performed once for each page and the range of text that
//	fits on that page is then saved in the |ranges| array.
// As long as the size of the display and the font remain the
//	same, subsequent requests for the range of text for that
//	page returns the same value. If either changes, the ranges
//	are discarded and the next attempt to load a page will
//	recalculate the range(s).

@interface WLPaginator : NSObject

@property (strong,nonatomic) NSString *bookText;
@property (strong,nonatomic) UIFont *font;
@property (readonly,nonatomic) NSDictionary *fontAttrs;
@property (nonatomic) CGSize viewSize;
@property (readonly,nonatomic) NSUInteger lastKnownPage;

- (BOOL)availablePage:(NSUInteger)page;
- (NSString*)textForPage:(NSUInteger)page;

@end