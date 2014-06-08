//
//  Vertex.m
//  Dijkstra
//
//  Created by Julien Gomès on 07/06/2014.
//  Copyright (c) 2014 Prunelle. All rights reserved.
//

#import "Vertex.h"

@implementation Vertex

@synthesize vertexId = _vertexId;
@synthesize name = _name;

- (id)copyWithZone:(NSZone *)zone
{
    Vertex *copy = [[Vertex alloc] init];
    
    if (copy) {
        copy.vertexId = _vertexId;
        copy.name = _name;
    }
    
    return copy;
}

- (BOOL)isEqual:(id)anObject {
    return _vertexId == ((Vertex *)anObject).vertexId;
}

- (NSUInteger)hash {
    return _vertexId;
}

@end

