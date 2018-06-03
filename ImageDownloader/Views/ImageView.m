//
//  ImageView.m
//  ImageDownloader
//
//  Created by Viktoryia Barzdyka on 5/31/18.
//  Copyright © 2018 Barzdyka. All rights reserved.
//

#import "ImageView.h"

@interface ImageView ()

@property (strong, nonatomic) UIImageView *image;
@property (strong, nonatomic) UILabel *url;
@property (strong, nonatomic) UIImageView *firstGroupImage;
@property (strong, nonatomic) UIImageView *secondGroupImage;
@property (strong, nonatomic) UIImageView *thirdGroupImage;

@end

@implementation ImageView

#define offset 5

- (id) initWithFrame: (CGRect) frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initSeparateImageViewContentWithFrame: frame];
         [self initGroupImageViewContentWithFrame:frame];
    }
    return self;
}

- (void) initSeparateImageViewContentWithFrame: (CGRect) frame {
    
    //separate image
    self.image = [[[UIImageView alloc] initWithFrame:CGRectMake(offset, offset, frame.size.width * 0.3f, frame.size.height-2*offset)] autorelease];
    [self.image setContentMode:UIViewContentModeScaleAspectFit];
    [self addSubview:self.image];
    
    //url
    self.url = [[[UILabel alloc] initWithFrame:CGRectMake(_image.frame.size.width + 2*offset, 0, frame.size.width/2, frame.size.height)] autorelease];
    [self.url setNumberOfLines:3];
    [self.url setAdjustsFontSizeToFitWidth:YES];
    [self.url setTextAlignment:NSTextAlignmentLeft];
    [self.url setContentMode:UIViewContentModeScaleAspectFit];
    [self addSubview:_url];
    [self setBackgroundColor:[UIColor lightGrayColor]]; 
}

- (void) initGroupImageViewContentWithFrame: (CGRect) frame {
    
    //first image in the group
    self.firstGroupImage = [[[UIImageView alloc] initWithFrame:CGRectMake(offset, offset, frame.size.width * 0.3f, frame.size.height-2*offset)] autorelease];
    [self.firstGroupImage setContentMode:UIViewContentModeScaleAspectFit];
    [self addSubview:self.firstGroupImage];
    
    //second image in the group
    self.secondGroupImage = [[[UIImageView alloc] initWithFrame:CGRectMake(_firstGroupImage.frame.size.width + 2*offset, offset, frame.size.width * 0.3f, frame.size.height-2*offset)] autorelease];
    [self.secondGroupImage setContentMode:UIViewContentModeScaleAspectFit];
    [self addSubview:self.secondGroupImage];
    
    //third image in the group
    self.thirdGroupImage = [[[UIImageView alloc] initWithFrame:CGRectMake(_secondGroupImage.frame.size.width*2 +  3*offset, offset, frame.size.width * 0.3f, frame.size.height-2*offset)] autorelease];
    [self.thirdGroupImage setContentMode:UIViewContentModeScaleAspectFit];
    [self addSubview:self.thirdGroupImage];
}

- (void) setImageViewContent: (UIImage*) image with: (NSString*) url {
    [self.image setImage:image];
    [self.url setText:url];
}

- (void) setGroupImageViewContent: (NSArray*) array {
    [self.firstGroupImage setImage:array[0]];
    [self.secondGroupImage setImage:array[1]];
    [self.thirdGroupImage setImage:array[2]];
}

-(void)dealloc{
    [_url release];
    [_image release];
    [_firstGroupImage release];
    [_secondGroupImage release];
    [_thirdGroupImage release];
    [super dealloc];
}

@end
