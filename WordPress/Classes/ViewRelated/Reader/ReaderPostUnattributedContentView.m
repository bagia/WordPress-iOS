#import "ReaderPostUnattributedContentView.h"

@implementation ReaderPostUnattributedContentView

- (void)buildAttributionView
{
    //noop
}

- (void)buildAttributionBorderView
{
    // noop
}

- (void)configureAttributionView
{
    // noop
}

- (CGSize)sizeThatFits:(CGSize)size
{
    CGFloat innerWidth = size.width - (WPContentViewOuterMargin * 2);
    CGSize innerSize = CGSizeMake(innerWidth, CGFLOAT_MAX);
    CGFloat height = 0;
    height += self.actionView.intrinsicContentSize.height;
    if (!self.featuredImageView.hidden) {
        height += (size.width * WPContentViewMaxImageHeightPercentage);
    }
    height += [self.titleLabel sizeThatFits:innerSize].height;
    height += [self sizeThatFitsContent:innerSize].height;

    if ([self.contentProvider sourceAttributionStyle] != SourceAttributionStyleNone) {
        height += [self.discoverPostAttributionView sizeThatFits:innerSize].height;
        height += WPContentViewAttributionVerticalPadding;
    }

    height += WPContentViewTitleContentPadding;
    height += (WPContentViewVerticalPadding * 2);

    return CGSizeMake(size.width, ceil(height));
}

- (void)configureConstraints
{
    UIView *featuredImageView = self.featuredImageView;
    UIView *titleLabel = self.titleLabel;
    UIView *contentView = self.contentView;
    UIView *discoverAttributionView = self.discoverPostAttributionView;
    UIView *discoverAttributionSpacer = self.discoverAttributionSpacerView;
    UIView *actionView = self.actionView;

    CGFloat contentViewOuterMargin = [self horizontalMarginForContent];
    NSDictionary *views = NSDictionaryOfVariableBindings(featuredImageView,
                                                         titleLabel,
                                                         contentView,
                                                         discoverAttributionView,
                                                         discoverAttributionSpacer,
                                                         actionView);
    NSDictionary *metrics = @{@"outerMargin": @(WPContentViewOuterMargin),
                              @"contentViewOuterMargin": @(contentViewOuterMargin),
                              @"verticalPadding": @(WPContentViewVerticalPadding),
                              @"titleContentPadding": @(WPContentViewTitleContentPadding),
                              @"borderHeight": @(WPContentViewBorderHeight),
                              @"priority":@900
                              };

    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[featuredImageView]|"
                                                                 options:0
                                                                 metrics:metrics
                                                                   views:views]];

    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(outerMargin)-[titleLabel]-(outerMargin)-|"
                                                                 options:0
                                                                 metrics:metrics
                                                                   views:views]];

    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(contentViewOuterMargin)-[contentView]-(contentViewOuterMargin)-|"
                                                                 options:0
                                                                 metrics:metrics
                                                                   views:views]];

    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(outerMargin@priority)-[discoverAttributionView]-(outerMargin@priority)-|"
                                                                 options:0
                                                                 metrics:metrics
                                                                   views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(outerMargin@priority)-[discoverAttributionSpacer]-(outerMargin@priority)-|"
                                                                 options:0
                                                                 metrics:metrics
                                                                   views:views]];

    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(outerMargin)-[actionView]-(outerMargin)-|"
                                                                 options:0
                                                                 metrics:metrics
                                                                   views:views]];

    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[featuredImageView]-(verticalPadding@priority)-[titleLabel]-(titleContentPadding@priority)-[contentView]-(verticalPadding@priority)-[discoverAttributionView][discoverAttributionSpacer][actionView]|"
                                                                 options:0
                                                                 metrics:metrics
                                                                   views:views]];

    // Create a constraint to wrangle height of the original attribution spacer view
    self.discoverAttributionBottomPaddingHeightConstraint = [NSLayoutConstraint constraintWithItem:self.discoverAttributionSpacerView
                                                                                         attribute:NSLayoutAttributeHeight
                                                                                         relatedBy:NSLayoutRelationEqual
                                                                                            toItem:nil
                                                                                         attribute:nil
                                                                                        multiplier:1.0
                                                                                          constant:0];
    [self addConstraint:self.discoverAttributionBottomPaddingHeightConstraint];
}

@end
