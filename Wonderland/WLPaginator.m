//
//  WLPaginator.m
//  Wonderland
//
//  Created by Hoan Tran on 8/20/14.
//  Copyright (c) 2014 Bluepego Consulting. All rights reserved.
//


#import "WLPaginator.h"

@interface WLPaginator () // private interface
{
	NSMutableArray	*ranges;				// NSRanges of text for each page
	NSUInteger		lastPageWithContent;
    NSDictionary    *fontAttrs;
}
- (NSRange)rangeOfTextForPage:(NSUInteger)page;
@end

@implementation WLPaginator

- (void)resetPageData
{
	// Something changed that requires re-pagination.
	// Forget the array of known text ranges for each page,
	//	which will force each page to be recalculated.
	ranges = [NSMutableArray array];
	lastPageWithContent = 1;
}

#pragma mark Properties

- (void)setBookText:(NSString *)bookData
{
	// Book data setter: reset ranges for new text
	_bookText = bookData;
	[self resetPageData];
}

- (void)setFont:(UIFont *)font
{
	// Font property setter: reset cached ranges if font changes
	if ([_font isEqual:font])
		return;
	_font = font;
    fontAttrs = nil;
	[self resetPageData];
}

- (NSDictionary*)fontAttrs
{
    if (fontAttrs==nil)
    {
        NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
        style.lineBreakMode = NSLineBreakByWordWrapping;
        fontAttrs = @{
                      NSFontAttributeName: self.font,
                      NSParagraphStyleAttributeName: style
                      };
    }
    return fontAttrs;
}

- (void)setViewSize:(CGSize)viewSize
{
	// View size setter: reset cached ranges if view size changes
	if (CGSizeEqualToSize(_viewSize,viewSize))
		return;
	_viewSize = viewSize;
	[self resetPageData];
}

- (NSUInteger)lastKnownPage
{
	return lastPageWithContent;
}

#pragma mark Pagination

// A quick macro to create an NSRange from a start and end locations,
//	rather than start and legnth.
#define SpanRange(LOCATION,LENGTH) ({ NSUInteger loc_=(LOCATION); NSMakeRange(loc_,(LENGTH)-loc_); })

- (NSRange)rangeOfTextForPage:(NSUInteger)page
{
	// Return the range of text in _bookData that fits on this page.
	// If the returned length is 0, there is no text on this page.
	
	if (ranges.count>=page)
		// The range for this page has already been calculated: return it immediately
		return [ranges[page-1] rangeValue];
	
	// The text for this page has never been determined.
	
	// Get the size of the area the text must fit in.
	CGSize constraintSize = _viewSize;
	CGFloat targetHeight = constraintSize.height;
	constraintSize.height = 32000;	// ∞
	
	// Find the location in the text where this page starts.
	// (hint: it's were the previous page ends.)
	NSRange textRange = NSMakeRange(0,0);
	if (page!=1)
		textRange.location = NSMaxRange([self rangeOfTextForPage:page-1]);
	// Skip over any leading whitespace (never start a page with whitespace)
	NSCharacterSet *wordBreakCharSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];
	while (textRange.location<_bookText.length &&
		   [wordBreakCharSet characterIsMember:[_bookText characterAtIndex:textRange.location]])
    {
		textRange.location += 1;
    }
	
	// First pass: Add one paragraph at a time until the text won't fit, or there's no more text.
	CGSize textSize = CGSizeMake(0,0);
    CGRect textBounds;
	NSCharacterSet *paraCharSet = [NSCharacterSet characterSetWithCharactersInString:@"\r"];
	while (textSize.height<targetHeight)
    {
		// Extend range by one paragraph and test layout
		NSRange paraRange = [_bookText rangeOfCharacterFromSet:paraCharSet
													   options:NSLiteralSearch
														 range:SpanRange(NSMaxRange(textRange),_bookText.length)];
		if (paraRange.location==NSNotFound)
			// There's no more text to append: we've reached the end of the book
			break;
		
		// Extend the range to include the range of the paragraph-end mark.
		textRange.length = NSMaxRange(paraRange)-textRange.location;
		// Recalculate the size of the text in the view
		NSString *testText = [_bookText substringWithRange:textRange];
        textBounds = [testText boundingRectWithSize:constraintSize
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:self.fontAttrs
                                            context:[NSStringDrawingContext new]];
        textSize = textBounds.size;
    }
	// The above loop exits when (a) the amount of text added now exceeds the space
	//	available in the view or (b) there's no more text.
	
	// Second pass: Shorten the text one word at a time until it fits again.
	while (textSize.height>targetHeight)
    {
		NSRange wordRange = [_bookText rangeOfCharacterFromSet:wordBreakCharSet
													   options:NSBackwardsSearch
														 range:textRange];
		if (wordRange.location==NSNotFound)
			// This is virtually impossible. It would mean that testRange was down to a single
			//	word, and that word did not fit in the view! Unlikely as it is, we still don't
			//	want our app to lock up in an infinite loop...
			break;
		
		// Trim the length of textRange to remove the last word break
		textRange.length = wordRange.location-textRange.location;
		NSString *testText = [_bookText substringWithRange:textRange];
        textBounds = [testText boundingRectWithSize:constraintSize
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:self.fontAttrs
                                            context:[NSStringDrawingContext new]];
        textSize = textBounds.size;
    }
	// When this loop exits, testRange contains exactly the text that will fit on this page.
	
	// Note: if this page is off the end of the "book", the range length will be 0.
	if (textRange.length!=0)
		// This page is not empty: remember the last page number that's not empty.
		lastPageWithContent = page;
	
	// Save the range and return it.
	// Note: ranges.count must be one less than page to get to this point in the code.
	[ranges addObject:[NSValue valueWithRange:textRange]];
	return textRange;
}

#pragma mark Data Model Interface

- (BOOL)availablePage:(NSUInteger)page
{
	// The first page must *always* be available or the initial page view controller has nothing.
	if (page==1)
		return YES;
	// Return YES if the requested page number contains text.
	NSRange textRange = [self rangeOfTextForPage:page];
	return (textRange.length!=0);
}

- (NSString*)textForPage:(NSUInteger)page
{
	// Return the text for |page|
	return [_bookText substringWithRange:[self rangeOfTextForPage:page]];
}

@end
