
#import "RectangleScene.h"

@interface RectangleScene()

@property (strong, nonatomic) NSColor *darkColor;
@property (strong, nonatomic) NSColor *lightColor;
@property (strong, nonatomic) NSMutableArray<SKShapeNode *> *allNodes;
@property (strong, nonatomic) NSMutableArray<SKShapeNode *> *animatingNodes;
@property (strong, nonatomic) NSTimer *animationTimer;
@property (strong, nonatomic) SKAction *fadeIn;
@property (strong, nonatomic) SKAction *fadeOut;

@end

@implementation RectangleScene

#pragma mark Initialization

- (instancetype)initWithSize:(CGSize)size {
    self = [super initWithSize:size];
    if (self) {
        self.fadeIn = [SKAction fadeInWithDuration:2];
        self.fadeOut = [SKAction fadeOutWithDuration:4];
        self.allNodes = [NSMutableArray new];
        self.animatingNodes = [NSMutableArray new];
        self.darkColor = [NSColor colorWithWhite:0.12 alpha:1];
        self.lightColor = [NSColor colorWithWhite:0.85 alpha:1];
        [self commonInit];
    }
    
    return self;
}

#pragma mark Instance Overrides

- (BOOL)acceptsFirstResponder {
    return NO;
}

- (void)didMoveToView:(SKView *)view {
    [self spawnNodes];
}

#pragma mark Internal Methods

- (void)commonInit {
    self.backgroundColor = self.darkColor;
}

- (void)spawnNodes {
    CGFloat width = self.size.width;
    
    CGFloat squareSize = width * 0.02;
    CGFloat cornerRadius = squareSize * 0.1;
    CGFloat spacing = 10;
    
    CGFloat squareWidth = squareSize + spacing;
    NSInteger columnsOfSquares = (NSInteger)width / squareWidth;
    CGFloat xRemainder = width - (squareWidth * (CGFloat)columnsOfSquares);
    
    CGFloat height = self.size.height;
    CGFloat squareHeight = squareSize + spacing;
    NSInteger rowsOfSquares = (NSInteger)height / squareHeight;
    NSInteger currentRow = 1;
    CGFloat yRemainder = height - (squareHeight * (CGFloat)rowsOfSquares);
    CGFloat currentYLocation = (yRemainder / 2) + (spacing / 2);
    
    while (currentRow <= rowsOfSquares) {
        CGFloat currentXLocation = (xRemainder / 2) + (spacing / 2);
        CGFloat currentColumn = 1;
        
        while (currentColumn <= columnsOfSquares) {
            CGRect rect = CGRectMake(currentXLocation, currentYLocation, squareSize, squareSize);
            SKShapeNode *square = [SKShapeNode shapeNodeWithRect:rect cornerRadius:cornerRadius];
            square.fillColor = self.lightColor;
            square.strokeColor = NSColor.clearColor;
            square.alpha = 0;
            [self addChild:square];
            [self.allNodes addObject:square];
            currentColumn += 1;
            currentXLocation += squareWidth;
        }
        
        currentRow += 1;
        currentYLocation += squareHeight;
    }
    
    [self startTimer];
}

- (void)timerFired:(NSTimer *)timer {
    SKShapeNode *nodeToAnimate;
    
    while (nodeToAnimate == nil) {
        NSInteger randomIndex = (NSInteger)arc4random_uniform((int)self.allNodes.count);
        SKShapeNode *node = self.allNodes[randomIndex];
        
        if (![self.animatingNodes containsObject:node]) {
            nodeToAnimate = node;
            [self.animatingNodes addObject:node];
        }
    }
    
    SKAction *group1 = [SKAction group:@[self.fadeIn]];
    SKAction *group2 = [SKAction group:@[self.fadeOut]];
    SKAction *sequence = [SKAction sequence:@[group1, group2]];
    
    [nodeToAnimate runAction:sequence completion:^{
        [self.animatingNodes removeObject:nodeToAnimate];
    }];
}

- (void)startTimer {
    self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
}

@end
