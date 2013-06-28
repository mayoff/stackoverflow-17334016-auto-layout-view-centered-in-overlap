    #import "AppDelegate.h"
    #import "DraggableView.h"
    #import "SpacerView.h"

    static NSLayoutConstraint *constraintWithPriority(NSLayoutConstraint *constraint,
        NSLayoutPriority priority)
    {
        constraint.priority = priority;
        return constraint;
    }

    @implementation AppDelegate {
        NSView *rootView;
        DraggableView *leftView;
        DraggableView *rightView;
        SpacerView *spacerView;
        NSTextField *middleView;
    }

    - (void)awakeFromNib {
        rootView = self.window.contentView;
        [self createLeftView];
        [self createRightView];
        [self createSpacerView];
        [self createMiddleView];
    }

    - (void)createLeftView {
        leftView = [[DraggableView alloc] init];
        leftView.translatesAutoresizingMaskIntoConstraints = NO;
        [rootView addSubview:leftView];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(leftView);
        [rootView addConstraints:[NSLayoutConstraint
            constraintsWithVisualFormat:@"H:|-(20)-[leftView(80)]"
            options:0 metrics:nil views:views]];
        [leftView addConstraints:[NSLayoutConstraint
            constraintsWithVisualFormat:@"V:[leftView(120)]"
            options:0 metrics:nil views:views]];
        leftView.yConstraint = [NSLayoutConstraint
            constraintWithItem:leftView attribute:NSLayoutAttributeTop
            relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeTop
            multiplier:1 constant:20];
        [rootView addConstraint:leftView.yConstraint];
    }

    - (void)createRightView {
        rightView = [[DraggableView alloc] init];
        rightView.translatesAutoresizingMaskIntoConstraints = NO;
        [rootView addSubview:rightView];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(rightView);
        [rootView addConstraints:[NSLayoutConstraint
            constraintsWithVisualFormat:@"H:[rightView(80)]-(20)-|"
            options:0 metrics:nil views:views]];
        [rightView addConstraints:[NSLayoutConstraint
            constraintsWithVisualFormat:@"V:[rightView(120)]"
            options:0 metrics:nil views:views]];
        rightView.yConstraint = [NSLayoutConstraint
            constraintWithItem:rightView attribute:NSLayoutAttributeTop
            relatedBy:NSLayoutRelationEqual
            toItem:rootView attribute:NSLayoutAttributeTop
            multiplier:1 constant:20];
        [rootView addConstraint:rightView.yConstraint];
    }

    - (void)createSpacerView {
        spacerView = [[SpacerView alloc] init];
        spacerView.translatesAutoresizingMaskIntoConstraints = NO;
        [rootView addSubview:spacerView];

        NSDictionary *views = NSDictionaryOfVariableBindings(leftView, rightView, spacerView);
        [rootView addConstraints:[NSLayoutConstraint
            constraintsWithVisualFormat:@"H:[leftView][spacerView][rightView]"
            options:0 metrics:nil views:views]];
        [rootView addConstraints:[NSLayoutConstraint
            constraintsWithVisualFormat:@"V:|-(0@1)-[spacerView]-(0@1)-|"
            options:0 metrics:nil views:views]];

        [rootView addConstraint:constraintWithPriority([NSLayoutConstraint
            constraintWithItem:spacerView attribute:NSLayoutAttributeTop
            relatedBy:NSLayoutRelationGreaterThanOrEqual
            toItem:leftView attribute:NSLayoutAttributeTop
            multiplier:1 constant:0], 2)];
        [rootView addConstraint:constraintWithPriority([NSLayoutConstraint
            constraintWithItem:spacerView attribute:NSLayoutAttributeTop
            relatedBy:NSLayoutRelationGreaterThanOrEqual
            toItem:rightView attribute:NSLayoutAttributeTop multiplier:1 constant:0], 2)];
        
        [rootView addConstraint:constraintWithPriority([NSLayoutConstraint
            constraintWithItem:spacerView attribute:NSLayoutAttributeBottom
            relatedBy:NSLayoutRelationLessThanOrEqual
            toItem:leftView attribute:NSLayoutAttributeBottom
            multiplier:1 constant:0], 2)];
        [rootView addConstraint:constraintWithPriority([NSLayoutConstraint
            constraintWithItem:spacerView attribute:NSLayoutAttributeBottom
            relatedBy:NSLayoutRelationLessThanOrEqual
            toItem:rightView attribute:NSLayoutAttributeBottom
            multiplier:1 constant:0], 2)];
    }

    - (void)createMiddleView {
        middleView = [[NSTextField alloc] init];
        middleView.translatesAutoresizingMaskIntoConstraints = NO;
        middleView.stringValue = @"Center";
        [middleView setEditable:NO];
        [middleView setSelectable:NO];
        [rootView addSubview:middleView];

        [rootView addConstraint:[NSLayoutConstraint
            constraintWithItem:middleView attribute:NSLayoutAttributeCenterX
            relatedBy:NSLayoutRelationEqual
            toItem:spacerView attribute:NSLayoutAttributeCenterX
            multiplier:1 constant:0]];
        [rootView addConstraint:[NSLayoutConstraint
            constraintWithItem:middleView attribute:NSLayoutAttributeCenterY
            relatedBy:NSLayoutRelationEqual
            toItem:spacerView attribute:NSLayoutAttributeCenterY
            multiplier:1 constant:0]];
    }

    @end
