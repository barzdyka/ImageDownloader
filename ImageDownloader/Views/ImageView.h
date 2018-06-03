//
//  ImageView.h
//  ImageDownloader
//
//  Created by Viktoryia Barzdyka on 5/31/18.
//  Copyright © 2018 Barzdyka. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageView : UIView

- (void) setImageViewContent: (UIImage*) image with: (NSString*) url;
- (void) setGroupImageViewContent: (NSMutableArray*) array;

@end
