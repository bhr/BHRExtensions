//
//  SIShellButtonView.m
//  SimpleSSH
//
//  Created by Benedikt Hirmer on 3/16/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "SIKeyboardButtonView.h"
#import "UIColor+BHRExtensions.h"

#define MIN_WIDTH 20.0f

@interface SIKeyboardButtonView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) CALayer *backgroundLayer;

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
	
	_titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
	_titleLabel.textAlignment = NSTextAlignmentCenter;
	_titleLabel.translatesAutoresizingMaskIntoConstraints = NO;

	[self addSubview:_titleLabel];
	
	
	_backgroundLayer = [CALayer layer];
	_backgroundLayer.contentsScale = [UIScreen mainScreen].scale;
	_backgroundLayer.zPosition = -1;
	_backgroundLayer.cornerRadius = 3.0f;
	_backgroundLayer.shadowRadius = 0.7f;
	_backgroundLayer.shadowOpacity = 1.0f;
	
	_backgroundLayer.shadowOffset = CGSizeMake(0.f, 1.0f);
	
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
	[self addConstraints:self.titleLabelConstraints];
	
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
	self.backgroundLayer.shadowPath = CGPathCreateWithRoundedRect(shadowRect, shadowCornerRadius, shadowCornerRadius, nil);
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
	UIColor *backgroundColor;
	
	switch (self.interfaceStyle) {
		case UIUserInterfaceStyleDark:
		{
			_backgroundLayer.shadowColor = [[UIColor colorWithWhite:0.15f alpha:1.f] CGColor];
			backgroundColor = [UIColor colorWithWhite:0.35f alpha:1.0f];
		}
			break;
		case UIUserInterfaceStyleLight:
		case UIUserInterfaceStyleUnspecified:
		{
			_backgroundLayer.shadowColor = [[UIColor colorWithWhite:0.5f alpha:1.f] CGColor];
			backgroundColor = [UIColor colorWithWhite:1.0f alpha:1.0f];
		}
			break;
	}
	
	if (self.selected) {
		backgroundColor = [backgroundColor colorByAddingBrightness:-0.25f];
	}
	
	if (self.highlighted) {
		backgroundColor = [backgroundColor colorByAddingAlpha:-0.4f];
	}
	
	self.backgroundLayer.backgroundColor = [backgroundColor CGColor];
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

@end
