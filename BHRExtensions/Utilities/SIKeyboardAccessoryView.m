//
//  SIShellAccessoryView.m
//  SimpleSSH
//
//  Created by Benedikt Hirmer on 2/23/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "SIKeyboardAccessoryView.h"
#import "UIColor+BHRExtensions.h"

NSString * const SIShellButtonInfoTitle = @"title";
NSString * const SIShellButtonInfoType = @"type";
NSString * const SIShellButtonInfoID = @"identifier";

double KEYBOARD_HEIGHT = 48.0f;
double VERTICAL_PADDING = 4.0f;

@interface SIKeyboardAccessoryView ()

@property (nonatomic, strong) NSArray<SIKeyboardButtonView *> *buttons;
@property (nonatomic, strong) NSArray<UIView *> *spacers;
@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) UIVisualEffectView *visualEffectView;

@end

@implementation SIKeyboardAccessoryView

- (instancetype)initWithInterfaceStyle:(UIUserInterfaceStyle)interfaceStyle
{
	self = [super initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, KEYBOARD_HEIGHT + 2 * VERTICAL_PADDING)];

	if (self)
{
		_interfaceStyle = interfaceStyle;
		[self _sharedInit];
	}
	return self;
}

- (void)_sharedInit
{
    self.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIVisualEffect *effect = nil;
    if (@available(iOS 26, *)) {
        effect = [[UIGlassContainerEffect alloc] init];
    } else {
        effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemUltraThinMaterial];
    }
    
    self.visualEffectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    self.visualEffectView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.visualEffectView];
    
    // Create horizontal stack view for groups
    self.stackView = [[UIStackView alloc] init];
    self.stackView.translatesAutoresizingMaskIntoConstraints = NO;
    self.stackView.axis = UILayoutConstraintAxisHorizontal;
    self.stackView.alignment = UIStackViewAlignmentFill;
    self.stackView.distribution = UIStackViewDistributionFill;
    self.stackView.spacing = [self itemSpace];
    [self.visualEffectView.contentView addSubview:self.stackView];
    
    // Setup visual effect view constraints
    [NSLayoutConstraint activateConstraints:@[
        [self.visualEffectView.topAnchor constraintEqualToAnchor:self.topAnchor],
        [self.visualEffectView.leftAnchor constraintEqualToAnchor:self.leftAnchor],
        [self.visualEffectView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
        [self.visualEffectView.rightAnchor constraintEqualToAnchor:self.rightAnchor],
    ]];
    
    // Setup stack view constraints
    [NSLayoutConstraint activateConstraints:@[
        [self.stackView.topAnchor constraintEqualToAnchor:self.visualEffectView.contentView.topAnchor constant:VERTICAL_PADDING],
        [self.stackView.leftAnchor constraintEqualToAnchor:self.visualEffectView.contentView.leftAnchor constant:8.0],
        [self.stackView.bottomAnchor constraintEqualToAnchor:self.visualEffectView.contentView.bottomAnchor constant:-VERTICAL_PADDING],
        [self.stackView.rightAnchor constraintEqualToAnchor:self.visualEffectView.contentView.rightAnchor constant:-8.0],
        [self.stackView.heightAnchor constraintEqualToConstant:KEYBOARD_HEIGHT],
    ]];
    
    [self _createButtons];
}

- (void)_createButtons
{
    NSMutableArray *buttons = [@[] mutableCopy];
    NSArray *buttonsInfo = [self buttonsInfo];
    
    // Check if buttonsInfo returns groups (array of arrays) or flat array
    BOOL isGrouped = buttonsInfo.count > 0 && [buttonsInfo.firstObject isKindOfClass:[NSArray class]];
    
    if (isGrouped) {
        // Handle grouped buttons
        [self _createGroupedButtons:buttonsInfo buttonsArray:buttons];
    } else {
        // Handle flat array (backward compatibility)
        [self _createFlatButtons:buttonsInfo buttonsArray:buttons];
    }
    
    self.buttons = buttons;
    [self _updateColors];
}

- (void)_createGroupedButtons:(NSArray *)buttonGroups buttonsArray:(NSMutableArray *)allButtons
{
    NSMutableArray<UIView *> *spacers = [NSMutableArray array];
    
    for (NSArray *group in buttonGroups) {
        // Create a stack view for each group
        UIStackView *groupStackView = [[UIStackView alloc] init];
        groupStackView.axis = UILayoutConstraintAxisHorizontal;
        groupStackView.alignment = UIStackViewAlignmentFill;
        groupStackView.distribution = UIStackViewDistributionFill;
        groupStackView.spacing = [self itemSpace];
        
        for (NSDictionary *buttonDictionary in group) {
            SIKeyboardButtonView *button = [self _createButtonFromDictionary:buttonDictionary];
            if (button) {
                [allButtons addObject:button];
                [groupStackView addArrangedSubview:button];
            }
        }
        
        // Add flexible space after each middle group
        if (group != [buttonGroups firstObject]) {
            UIView *flexibleSpace = [[UIView alloc] init];
            flexibleSpace.translatesAutoresizingMaskIntoConstraints = NO;
            [flexibleSpace setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
            [flexibleSpace setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
            [self.stackView addArrangedSubview:flexibleSpace];
            [spacers addObject:flexibleSpace];
        }
        
        [self.stackView addArrangedSubview:groupStackView];
    }
    
    
    // Set equal width constraints for all spacers with high priority
    if (spacers.count > 1) {
        UIView *firstSpacer = spacers.firstObject;
        for (NSInteger i = 1; i < spacers.count; i++) {
            UIView *spacer = spacers[i];
            NSLayoutConstraint *equalWidthConstraint = [spacer.widthAnchor constraintEqualToAnchor:firstSpacer.widthAnchor];
            equalWidthConstraint.priority = UILayoutPriorityRequired;
            [equalWidthConstraint setActive:YES];
        }
    }
    
    self.spacers = spacers;
}

- (void)_createFlatButtons:(NSArray *)buttonsInfo buttonsArray:(NSMutableArray *)allButtons
{
    // Create a single group for flat array (backward compatibility)
    UIStackView *groupStackView = [[UIStackView alloc] init];
    groupStackView.axis = UILayoutConstraintAxisHorizontal;
    groupStackView.alignment = UIStackViewAlignmentFill;
    groupStackView.distribution = UIStackViewDistributionFill;
    groupStackView.spacing = [self itemSpace];
    
    for (NSDictionary *buttonDictionary in buttonsInfo) {
        SIKeyboardButtonView *button = [self _createButtonFromDictionary:buttonDictionary];
        if (button) {
            [allButtons addObject:button];
            [groupStackView addArrangedSubview:button];
        }
    }
    
    [self.stackView addArrangedSubview:groupStackView];
}

- (SIKeyboardButtonView *)_createButtonFromDictionary:(NSDictionary *)buttonDictionary
{
    NSString *buttonTitle = [buttonDictionary objectForKey:SIShellButtonInfoTitle];
    NSString *buttonID = [buttonDictionary objectForKey:SIShellButtonInfoID];
    SIShellAccessoryButton buttonType = [[buttonDictionary objectForKey:SIShellButtonInfoType] unsignedIntegerValue];
    
    // skip "none" button
    if (buttonType == SIShellAccessoryButtonNone) {
        return nil;
    }
    
    //if no id was given use title as ID
    if (buttonID == nil) {
        buttonID = buttonTitle;
    }
    
    //view creation
    SIKeyboardButtonView *button = [[SIKeyboardButtonView alloc] initWithInterfaceStyle:self.interfaceStyle];
    button.title = buttonTitle;
    button.delegate = self;
    button.restorationIdentifier = buttonID;
    
    return button;
}

-(CGSize)intrinsicContentSize {
    return CGSizeMake(320.0f, KEYBOARD_HEIGHT + 2.0 * VERTICAL_PADDING);
}

+ (BOOL)requiresConstraintBasedLayout
{
	return YES;
}

- (void)_updateColors
{
	for (SIKeyboardButtonView *button in self.buttons)
	{
		button.interfaceStyle = self.interfaceStyle;
	}
	
	// Background color is now handled by the visual effect view
}

- (void)setInterfaceStyle:(UIUserInterfaceStyle)interfaceStyle
{
	if (_interfaceStyle != interfaceStyle)
	{
		_interfaceStyle = interfaceStyle;
		[self _updateColors];
	}
}

#pragma mark - Actions

- (void)sendButtonWithType:(SIShellAccessoryButton)buttonType
{
	if ([self.delegate respondsToSelector:@selector(shellAccessoryView:didPressButton:)])
	{
		[self.delegate shellAccessoryView:self
									 didPressButton:buttonType];
	}
}

#pragma mark - KeyboardbuttonDelegate

- (void)tappedShellButtonView:(SIKeyboardButtonView *)buttonView;
{
	NSInteger tappedButtonIndex = [self.buttons indexOfObject:buttonView];
	NSArray *buttonsInfo = [self buttonsInfo];
	
	// Check if buttonsInfo returns groups (array of arrays) or flat array
	BOOL isGrouped = buttonsInfo.count > 0 && [buttonsInfo.firstObject isKindOfClass:[NSArray class]];
	
	NSDictionary *buttonInfo = nil;
	
	if (isGrouped) {
		// Handle grouped buttons - find the correct group and position
		NSInteger currentIndex = 0;
		for (NSArray *group in buttonsInfo) {
			if (tappedButtonIndex < currentIndex + group.count) {
				// Found the group containing this button
				NSInteger localIndex = tappedButtonIndex - currentIndex;
				buttonInfo = [group objectAtIndex:localIndex];
				break;
			}
			currentIndex += group.count;
		}
	} else {
		// Handle flat array (backward compatibility)
		buttonInfo = [buttonsInfo objectAtIndex:tappedButtonIndex];
	}

	SIShellAccessoryButton buttonType = [[buttonInfo objectForKey:SIShellButtonInfoType] integerValue];

	[self sendButtonWithType:buttonType];
}

- (NSArray *)buttonsInfo
{
	return nil;
}

- (NSString *)separatorID
{
	return nil;
}

- (CGFloat)itemSpace
{
	return 3.0f;
}

@end


