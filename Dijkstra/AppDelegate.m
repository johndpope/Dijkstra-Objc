//
//  AppDelegate.m
//  Dijkstra
//
//  Created by Julien Gomès on 07/06/2014.
//  Copyright (c) 2014 Prunelle. All rights reserved.
//

#import "AppDelegate.h"
#import "Vertex.h"
#import "Edge.h"
#import "Graph.h"
#import "Dijkstra.h"

@interface AppDelegate ()
            

@end

@implementation AppDelegate
            

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self test];
    
    return YES;
}

- (void) test {
    Vertex *vertexA = [Vertex new];
    vertexA.name = @"1";
    vertexA.vertexId = 1;
    currentIndex = 1;
    
    Graph *graph = [Graph new];
    
    [self createGraph:graph withRoot:vertexA andLevel:10];
    NSTimeInterval startTime = [NSDate timeIntervalSinceReferenceDate] * 1000;
    
    Dijkstra *dijkstra = [Dijkstra new];
    [dijkstra initWithGraph:graph];
    [dijkstra execute:vertexA];
    
    NSTimeInterval stopTime = [NSDate timeIntervalSinceReferenceDate] * 1000;
    
    NSArray *path = [dijkstra getPath:[graph.vertexList lastObject]];
    NSLog(@"* Path");
    for (Vertex *vertex in path) {
        NSLog(@"- %@",vertex.name);
    }
    
    NSLog(@"Duration : %lf",stopTime-startTime);
}

- (void) createGraph:(Graph *)graph withRoot:(Vertex *)root andLevel:(NSUInteger)level {
    if (level == 0) {
        return;
    } else {
        Vertex *firstChild = [Vertex new];
        firstChild.vertexId = ++currentIndex;
        firstChild.name = [NSString stringWithFormat:@"%lu",(unsigned long)firstChild.vertexId];
        
        Vertex *secondChild = [Vertex new];
        secondChild.vertexId = ++currentIndex;
        secondChild.name = [NSString stringWithFormat:@"%lu",(unsigned long)secondChild.vertexId];
        
        Edge *rootToFirstChild = [Edge new];
        rootToFirstChild.source = root;
        rootToFirstChild.destination = firstChild;
        rootToFirstChild.distances = @[[NSNumber numberWithInteger:1]];
        
        Edge *rootToSecondChild = [Edge new];
        rootToSecondChild.source = root;
        rootToSecondChild.destination = secondChild;
        rootToSecondChild.distances = @[[NSNumber numberWithInteger:1]];
        
        [graph.vertexList addObject:firstChild];
        [graph.vertexList addObject:secondChild];
        [graph.edgeList addObject:rootToFirstChild];
        [graph.edgeList addObject:rootToSecondChild];
        
        [self createGraph:graph withRoot:firstChild andLevel:level-1];
        [self createGraph:graph withRoot:secondChild andLevel:level-1];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
