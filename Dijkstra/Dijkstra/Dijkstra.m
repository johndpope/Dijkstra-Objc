//
//  Dijkstra.m
//  Dijkstra
//
//  Created by Julien Gomès on 07/06/2014.
//  Copyright (c) 2014 Prunelle. All rights reserved.
//

#import "Dijkstra.h"
#import "Edge.h"

@implementation Dijkstra

- (void) initWithGraph:(Graph *)graph {
    _graph = graph;
}

- (void) execute:(Vertex *)destination {
    _settledStopList = [NSMutableArray new];
    _unSettledStopList = [NSMutableArray new];
    _predecessors = [NSMutableDictionary new];
    _distanceFromVertex = [NSMutableDictionary new];
    
    [_distanceFromVertex setObject:[self createDistance:0] forKey:destination];
    [_unSettledStopList addObject:destination];
    
    while ([_unSettledStopList count] > 0) {
        Vertex *tmpVertex = [self getVertexWithMinimunDistanceAmong:_unSettledStopList];
        
        //NSLog(@"* Current vertex %@",tmpVertex.name);
        
        [_settledStopList addObject:tmpVertex];
        [_unSettledStopList removeObject:tmpVertex];
        
        [self findMinimalDistanceForVertexAndInsertInUnSettledVertex:tmpVertex];
    }
}

- (NSArray *) createDistance:(NSUInteger) value {
    NSMutableArray *distances = [NSMutableArray new];
    NSUInteger dimension = [[[_graph.edgeList objectAtIndex:0] distances] count];
    for (int index=0; index<dimension; index++) {
        [distances addObject:[NSNumber numberWithInteger:value]];
    }
    return distances;
}

- (Vertex *) getVertexWithMinimunDistanceAmong:(NSArray *) unSettledStopList {
    Vertex *vertex = nil;
    for (Vertex *tmpVertex in unSettledStopList) {
        if(vertex == nil) {
            vertex = tmpVertex;
        } else {
            NSArray *shortestDistanceForVertexA = [self getShortestDistanceForVertex:vertex];
            NSArray *shortestDistanceForVertexTmpVertex = [self getShortestDistanceForVertex:tmpVertex];
            
            if([self compareShortestDistance:shortestDistanceForVertexA and:shortestDistanceForVertexTmpVertex] == -1) {
                vertex = tmpVertex;
            }

        }
    }
    return vertex;
}

- (NSUInteger) compareShortestDistance:(NSArray *)distancesA and:(NSArray *)distancesB {
    NSUInteger result = 0;
    
    for (int index=0 ; index<[distancesA count]; index++) {
        NSUInteger distanceA = [[distancesA objectAtIndex:index] integerValue];
        NSUInteger distanceB = [[distancesB objectAtIndex:index] integerValue];
        
        if(distanceA < distanceB) {
            result = -1;
            break;
        } else if (distanceA > distanceB) {
            result = 1;
            break;
        } else {
            result = 0;
        }
    }
    return result;
}

- (void) findMinimalDistanceForVertexAndInsertInUnSettledVertex:(Vertex *) vertex {
    NSArray *neighborList = [self getNeighbors:vertex];
    
    for (Vertex *neighbour in neighborList) {
        NSArray *shortestDistanceForVertex = [self getShortestDistanceForVertex:vertex];
        NSArray *shortestDistanceForNeighbour = [self getShortestDistanceForVertex:neighbour];
        NSArray *distanceBetweenVertexAndTarget = [self getDistanceBetween:vertex and:neighbour];
        
        NSArray *distances = [self addDistance:shortestDistanceForVertex and:distanceBetweenVertexAndTarget];
        
        //NSLog(@"  - Neightbour : %@",neighbour.name);
        //NSLog(@"     - shortestDistanceForVertex : %lu",(unsigned long)[[shortestDistanceForVertex objectAtIndex:0] integerValue]);
        //NSLog(@"     - shortestDistanceForNeighbour : %lu",(unsigned long)[[shortestDistanceForNeighbour objectAtIndex:0] integerValue]);
        //NSLog(@"     - distanceBetweenVertexAndTarget : %lu",(unsigned long)[[distanceBetweenVertexAndTarget objectAtIndex:0] integerValue]);
        //NSLog(@"     - Distance : %lu",(unsigned long)[[distances objectAtIndex:0] integerValue]);
        
        if([self compareShortestDistance:shortestDistanceForNeighbour and:distances] == 1) {
            [_distanceFromVertex setObject:distances forKey:neighbour];
            [_predecessors setObject:vertex forKey:neighbour];
            [_unSettledStopList addObject:neighbour];
        }
    }
}

- (NSArray *) getShortestDistanceForVertex:(Vertex *) vertex {
    NSArray *distances = [NSMutableArray new];
    
    if([_distanceFromVertex objectForKey:vertex] != nil) {
        distances = [_distanceFromVertex objectForKey:vertex];
    } else {
        distances = [self createDistance:NSUIntegerMax];
    }
    return distances;
}

- (NSArray *) getNeighbors:(Vertex *)vertex {
    NSMutableArray *neighbors = [NSMutableArray new];
    for (Edge *edge in _graph.edgeList) {
        if ([edge.source isEqual:vertex]) {
            [neighbors addObject:edge.destination];
        }
    }
    return neighbors;
}

- (NSArray *) addDistance:(NSArray *)distancesA and:(NSArray *)distancesB {
    NSMutableArray *distances = [NSMutableArray new];
    for (int index=0; index<[distancesA count]; index++) {
        NSUInteger distanceA = [[distancesA objectAtIndex:index] integerValue];
        NSUInteger distanceB = [[distancesB objectAtIndex:index] integerValue];
        NSNumber *result = [NSNumber numberWithInteger:distanceA+distanceB];
        [distances addObject:result];
    }
    return distances;
}

- (NSArray *) getDistanceBetween:(Vertex *)source and:(Vertex *)destination {
    NSArray *distances = [NSMutableArray new];
    for (Edge *edge in _graph.edgeList) {
        if ([edge.source isEqual:source] && [edge.destination isEqual:destination]){
            distances = edge.distances;
        }
    }
    return distances;
}

- (NSArray *) getPath:(Vertex *)destination {
    NSMutableArray *path = [NSMutableArray new];
    Vertex *step = destination;
    if ([_predecessors objectForKey:step] == nil) {
        return nil;
    }
    [path addObject:step];
    while ([_predecessors objectForKey:step] != nil) {
        step = [_predecessors objectForKey:step];
        [path addObject:step];
    }
    return [[path reverseObjectEnumerator] allObjects];
}

@end
