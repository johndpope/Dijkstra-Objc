//
//  Graph.h
//  Dijkstra
//
//  Created by Julien Gomès on 07/06/2014.
//  Copyright (c) 2014 Prunelle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Graph : NSObject {
    NSMutableArray *_edgeList;
    NSMutableArray *_vertexList;
}

@property (retain) NSMutableArray *edgeList;
@property (retain) NSMutableArray *vertexList;

@end
