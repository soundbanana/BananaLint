//
//  SwiftLintHelper.h
//  BananaLint
//
//  Created by Danil Chemaev on 2024/04/23.
//  
//

#import <Foundation/Foundation.h>

@interface SwiftLintHelper : NSObject
@property (nonatomic,retain) NSString * _Nullable swiftLintPath;
- (int)runSwiftLint:(NSArray<NSString *>*_Nonnull)arguments;
- (int)autoCorrect:(NSString *_Nonnull)path withRule:(NSString* _Nullable)rulePath;
@end
