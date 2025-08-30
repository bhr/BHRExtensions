//
//  SIShellButtonView.m
//  SimpleSSH
//
//  Created by Benedikt Hirmer on 3/16/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "SIKeyboardButtonView.h"
#import "UIColor+BHRExtensions.h"

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_260000
#define MIN_WIDTH 26.0f
#else
#define MIN_WIDTH 20.0f
#endif

@interface SIKeyboardButtonView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) CALayer *backgroundLayer;
@property (nonatomic, strong) UIVisualEffectView *visualEffectView;

@property (nonatomic, strong) UILongPressGestureRecognizer *buttonGestureRecognizer;
@property (nonatomic, assign) BOOL highlighted;

@property (nonatomic, strong) NSArray *titleLabelConstraints;

@end

@implementation SIKeyboardButtonView

- (instancetype)initWithInterfaceStyle:(UIUserInterfaceStyle)interfaceStyle
{
	_interfaceStyle = interfaceStyle;
	return [self initWithFrame:CGRectZero];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
	{
		[self sharedInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self)
	{
		[self sharedInit];
	}
	return self;
}

- (void)sharedInit
{
	self.opaque = NO;
	self.translatesAutoresizingMaskIntoConstraints = NO;
	
	_buttonGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self
																			 action:@selector(handleLongPress:)];
	_buttonGestureRecognizer.delegate = self;
	_buttonGestureRecognizer.minimumPressDuration = 0.0f;
	[self addGestureRecognizer:_buttonGestureRecognizer];
	
	// Create visual effect view
	UIVisualEffect *effect = nil;
	if (@available(iOS 26, *)) {
		effect = [[UIGlassEffect alloc] init];
	} else {
		effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemUltraThinMaterial];
	}
	
	self.visualEffectView = [[UIVisualEffectView alloc] initWithEffect:effect];
	self.visualEffectView.translatesAutoresizingMaskIntoConstraints = NO;
	self.visualEffectView.layer.cornerRadius = 8.0f;
	self.visualEffectView.clipsToBounds = YES;
	[self addSubview:self.visualEffectView];
	
	_titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
	_titleLabel.textAlignment = NSTextAlignmentCenter;
    
    if (@available(iOS 26.0, *)) {
        _titleLabel.font = [UIFont systemFontOfSize:18.0f weight:UIFontWeightMedium width:UIFontWidthCondensed];
    }
    
	_titleLabel.translatesAutoresizingMaskIntoConstraints = NO;

	[self.visualEffectView.contentView addSubview:_titleLabel];
	
	_backgroundLayer = [CALayer layer];
	_backgroundLayer.contentsScale = [UIScreen mainScreen].scale;
	_backgroundLayer.zPosition = -1;
	_backgroundLayer.cornerRadius = 8.0f;

    if (@available(iOS 26.0, *)) {
        // do nothing
    } else {
        _backgroundLayer.shadowRadius = 0.7f;
        _backgroundLayer.shadowOpacity = 1.0f;
        
        _backgroundLayer.shadowOffset = CGSizeMake(0.f, 1.0f);
    }
    
	[self _updateBackgroundLayerColors];
	
	[self.layer addSublayer:_backgroundLayer];
}

#pragma mark - Actions

- (void)handleLongPress:(UILongPressGestureRecognizer *)sender
{
	if (sender.state == UIGestureRecognizerStateBegan)
	{
		self.highlighted = YES;
	}
	
	if (sender.state == UIGestureRecognizerStateEnded ||
		sender.state == UIGestureRecognizerStateCancelled ||
		sender.state == UIGestureRecognizerStateFailed)
    {
		self.highlighted = NO;
    }
	
	if (sender.state == UIGestureRecognizerStateEnded)
	{
		CGPoint location = [sender locationInView:self];
		
        if (CGRectContainsPoint(self.bounds, location))
		{
			if ([self.delegate respondsToSelector:@selector(tappedShellButtonView:)])
			{
				[self.delegate tappedShellButtonView:self];
			}
		}
	}
}

#pragma mark - View updating

- (void)updateConstraints
{
	if (self.titleLabelConstraints)
	{
		[self removeConstraints:self.titleLabelConstraints];
	}
	
	// Setup visual effect view constraints
	[NSLayoutConstraint activateConstraints:@[
		[self.visualEffectView.topAnchor constraintEqualToAnchor:self.topAnchor],
		[self.visualEffectView.leftAnchor constraintEqualToAnchor:self.leftAnchor],
		[self.visualEffectView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
		[self.visualEffectView.rightAnchor constraintEqualToAnchor:self.rightAnchor],
	]];
	
	NSMutableArray *titleConstraints = [@[] mutableCopy];
	
	NSDictionary *viewsDict = @{@"label": self.titleLabel};
	CGSize stringSize = [self.titleLabel.text sizeWithAttributes:[self _labelAttributes]];
	CGFloat intrinsicSizeWidth = stringSize.width + 2.0f; //padding
	
	intrinsicSizeWidth = MAX(intrinsicSizeWidth, MIN_WIDTH);
	
	[titleConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-4-[label(intrinsicSizeWidth)]-4-|"
																				  options:0
																				  metrics:@{@"intrinsicSizeWidth": @(intrinsicSizeWidth)}
																					views:viewsDict]];
	[titleConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[label]|"
																				  options:0
																				  metrics:nil
																					views:viewsDict]];
	
	self.titleLabelConstraints = titleConstraints;
	[self.visualEffectView.contentView addConstraints:self.titleLabelConstraints];
	
	[super updateConstraints];
}

- (void)layoutSubviews
{
	[super layoutSubviews];
		
	[self _updateBackgroundLayer];
}

- (NSDictionary *)_labelAttributes
{
	return @{
			 NSFontAttributeName: self.titleLabel.font
			 };
}


- (void)_updateBackgroundLayer
{
	CGRect buttonRect = CGRectInset(self.bounds, 1.0f, 1.0f);
	CGRect shadowRect = CGRectMake(0, 0, CGRectGetWidth(buttonRect), CGRectGetHeight(buttonRect));
	CGFloat shadowCornerRadius = self.backgroundLayer.cornerRadius;
	self.backgroundLayer.frame = buttonRect;
	CGPathRef path = CGPathCreateWithRoundedRect(shadowRect, shadowCornerRadius, shadowCornerRadius, nil);
	self.backgroundLayer.shadowPath = path;
	CGPathRelease(path);
}

- (void)setInterfaceStyle:(UIUserInterfaceStyle)interfaceStyle
{
	if (_interfaceStyle != interfaceStyle)
	{
		_interfaceStyle = interfaceStyle;
		[self _updateBackgroundLayerColors];
	}
}

- (void)_updateBackgroundLayerColors
{
	// Update visual effect view alpha based on state
	CGFloat alpha = 1.0f;
	
	if (self.selected) {
		alpha = 0.8f;
	}
	
	if (self.highlighted) {
		alpha = 0.6f;
	}
	
	self.visualEffectView.alpha = alpha;
	
	// Keep shadow for older iOS versions
	if (@available(iOS 26.0, *)) {
		// No shadow needed for glass effect
	} else {
		UIColor *shadowColor;
		switch (self.interfaceStyle) {
			case UIUserInterfaceStyleDark:
			{
				shadowColor = [UIColor colorWithWhite:0.15f alpha:1.f];
			}
				break;
			case UIUserInterfaceStyleLight:
			case UIUserInterfaceStyleUnspecified:
			{
				shadowColor = [UIColor colorWithWhite:1.0f alpha:1.f];
			}
				break;
		}
		_backgroundLayer.shadowColor = [shadowColor CGColor];
	}
}

#pragma mark -


- (void)setHighlighted:(BOOL)highlighted
{
	if (_highlighted != highlighted)
	{
		_highlighted = highlighted;
		[self _updateBackgroundLayerColors];
	}
}

- (void)setSelected:(BOOL)selected
{
	if (_selected != selected)
	{
		_selected = selected;
		[self _updateBackgroundLayerColors];
	}
}

- (void)setTitle:(NSString *)title
{
	if (_title != title)
	{
		_title = title;
		self.titleLabel.text = title;
		[self setNeedsUpdateConstraints];
	}
}


 - (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

@end
