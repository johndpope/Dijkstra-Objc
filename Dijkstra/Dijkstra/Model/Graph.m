//
//  Graph.m
//  Dijkstra
//
//  Created by Julien Gomès on 07/06/2014.
//  Copyright (c) 2014 Prunelle. All rights reserved.
//

#import "Graph.h"

@implementation Graph

@synthesize edgeList = _edgeList;
@synthesize vertexList = _vertexList;

- (id) init {
    if([super init]) {
        _edgeList = [NSMutableArray new];
        _vertexList = [NSMutableArray new];
    }
    return self;
}

@end
