//
//  ViewController.m
//  Breakout
//
//  Created by John Malloy on 1/16/14.
//  Copyright (c) 2014 Big Red INC. All rights reserved.
//

#import "ViewController.h"
#import "PaddleView.h"
#import "BallView.h"


@interface ViewController () <UICollisionBehaviorDelegate>
{
    __weak IBOutlet PaddleView *paddleView;
    
    __weak IBOutlet UIView *ballView;
    
    UIDynamicAnimator *dynamicAnimator;
    UIDynamicItemBehavior *dragPaddle;
    UIPushBehavior *pushBehavior;
    UICollisionBehavior *collisonBehavior;
    
}

@end

@implementation ViewController

- (void)viewDidLoad

{
    
    UIDynamicItemBehavior *ballDynamicBehavior;
    UIDynamicItemBehavior *paddleDynamicBehavior;
    
    [super viewDidLoad];
    
    dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    pushBehavior = [[UIPushBehavior alloc] initWithItems:@[ballView] mode:UIPushBehaviorModeInstantaneous];
    
    pushBehavior.pushDirection = CGVectorMake(0.5, 1.0);
    pushBehavior.active = YES;
    pushBehavior.magnitude = 0.5;
    
    
    [dynamicAnimator addBehavior:pushBehavior];
    
    collisonBehavior = [[UICollisionBehavior alloc] initWithItems:@[ballView,paddleView]];
    collisonBehavior.collisionDelegate = self;
    
    collisonBehavior.collisionMode = UICollisionBehaviorModeEverything;
    collisonBehavior.translatesReferenceBoundsIntoBoundary = YES;
    
    [dynamicAnimator addBehavior:collisonBehavior];
    
    
    ballDynamicBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[ballView]];
    ballDynamicBehavior.allowsRotation = NO;
    ballDynamicBehavior.elasticity = 1.0;
    ballDynamicBehavior.friction = 0.0;
    ballDynamicBehavior.resistance = 0.0;
    
    [dynamicAnimator addBehavior:ballDynamicBehavior];
    
    
    
    paddleDynamicBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[paddleView]];
    paddleDynamicBehavior.allowsRotation = NO;
    paddleDynamicBehavior.density = 1000.0;
    
    [dynamicAnimator addBehavior:paddleDynamicBehavior];
    

    
}


- (IBAction)dragPaddle:(UIPanGestureRecognizer *)panGestureRecognizer;
{
    paddleView.center = CGPointMake([panGestureRecognizer locationInView:self.view].x, paddleView.center.y);
    [dynamicAnimator updateItemUsingCurrentState:paddleView];
}


-(void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p

{

    //CGRect screenRect = [[UIScreen mainScreen] bounds];

        //CGRect screenBound = [[UIScreen mainScreen] bounds];

    [UIView animateWithDuration:0.5 animations:^{ballView.clipsToBounds = YES;}];


}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
