//
//  TestGem.m
//  Diamonds

#import "TestGem.h"

#import "Grid.h"

#import "GemAggregate.h"
#import "DroppablePair.h"
#import "Gem.h"

#import "MockSpriteBatch.h"
#import "MockResourceManager.h"
#import "MockTexture.h"

@interface TestDroppablePairBase : TestCase 
{
    DroppablePair* pair;
}
@end

@implementation TestDroppablePairBase

- (DroppablePair*) makePairAt: (GridCell) cell
{
    
    GemType gems[2];    
    gems[0] = Diamond;
    gems[1] = Ruby;
    
    pair = [[DroppablePair alloc] initAt: cell with: gems resources: nil];
    return pair;
}

- (void) setUp
{
    [super setUp];
    [self makePairAt: MakeCell(4, 12)];
}

@end

@interface TestDroppablePair : TestDroppablePairBase 
@end

@implementation TestDroppablePair

- (void) testDroppablePairSizeIs1x2
{
    assertEquals(1, pair.width);
    assertEquals(2, pair.height);
}

- (void) testDroppablePairIsCreatedWithCorrectPivotAndBuddy
{    
    assertEquals(Diamond, pair.pivot.type);
    assertEquals(Ruby, pair.buddy.type);
}

- (void) testDroppablePairIsCreatedWithPivotAndBuddyAndSprites
{    
    assertNotNil([pair.pivot sprite]);
    assertNotNil([pair.buddy sprite]);
}

- (void) testDroppablePairIsCreatedWithTheCorrectCell
{
    assertEquals(MakeCell(4, 12), pair.cell);    
}

- (void) testDroppablePairCreatesTwoGemsAtTheCorrectCells
{
    assertEquals(MakeCell(4, 12), pair.pivot.cell);    
    assertEquals(MakeCell(4, 13), pair.buddy.cell);    
}

@end

@interface TestDroppablePairInGrid : TestDroppablePairBase 
@end

@implementation TestDroppablePairInGrid

/*
- (void) testDroppablePairRotatesLeft
{
//    Grid* grid = [[Grid alloc] initWithResources: nil width: 8 height: 14];
    

    [self makePairAt: MakeCell(1, 2)];
  //  [grid put: pair];
    
    pair = [pair rotateLeft];
    
    assertEquals(2, pair.width);    
    assertEquals(1, pair.height);    
}
 */

@end



@interface TestDroppablePairDrawing : TestGemDrawingBase 
@end

@implementation TestDroppablePairDrawing
{    
    DroppablePair* pair;
}

- (void) makePairAt: (GridCell) cell
{
    MockResourceManager* resources = [MockResourceManager new];
    
    GemType gems[2];    
    gems[0] = Diamond;
    gems[1] = Ruby;
    
    pair = [[DroppablePair alloc] initAt: cell with: gems resources: resources];        
}

- (void) testDroppablePairDrawsTwoSprites
{
    [self makePairAt: MakeCell(4, 13)];

    [batch begin];
    [pair drawIn: batch info: info];
    [batch end];    

    assertEquals(2, batch.numberOfSpritesDrawn);
}

- (void) testDroppablePairDrawsTwoSpritesWithTheCorrectTextures
{
    [self makePairAt: MakeCell(4, 13)];
    
    [batch begin];
    [pair drawIn: batch info: info];
    [batch end];    
    
    assertEqualObjects(@"diamond", [[batch.sprites objectAtIndex: 0] texture].name);
    assertEqualObjects(@"ruby", [[batch.sprites objectAtIndex: 1] texture].name);
}

@end