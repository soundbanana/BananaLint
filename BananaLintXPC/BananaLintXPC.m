//
//  SwiftLintXPC.m
//  BananaLint
//
//  Created by Danil Chemaev on 2024/04/22.
//
//

#import "BananaLintXPC.h"
#import "XcodeHelper.h"
#import "SwiftLintHelper.h"

@interface BananaLintXPC ()
@property (nonatomic,retain) XcodeHelper *xcodeHelper;
@property (nonatomic,retain) SwiftLintHelper *swiftlintHelper;
@end

@implementation BananaLintXPC

- (id)init{
    self = [super init];
    self.xcodeHelper = [[XcodeHelper alloc] init];
    self.swiftlintHelper = [[SwiftLintHelper alloc] init];
    
    return self;
}

- (void)setSwiftLintPath:(NSString *)path relativePath:(BOOL)isRelative{
    if(isRelative){
        NSString *resolvedPath = [self.xcodeHelper.activeProjectFolderPath stringByAppendingPathComponent:path];
        self.swiftlintHelper.swiftLintPath = resolvedPath;
    }
    else{
        self.swiftlintHelper.swiftLintPath = path;
    }
}

- (void)activeWorkspaceDocumentPath:(void (^)(NSString *))reply {
    reply([self.xcodeHelper activeWorkspaceDocumentPath]);
}

- (void)activeProjectFolderPath:(void (^)(NSString *))reply {
    reply([self.xcodeHelper activeProjectFolderPath]);
}

- (void)currentFilePath:(void (^)(NSString *))reply {
    reply([self.xcodeHelper currentFilePath]);
}

- (void)defaultSwiftLintYmlPath:(void (^)(NSString *))reply {
    reply([self.xcodeHelper defaultSwiftLintYmlPath]);
}

- (void)autocorrectCurrentFile:(void (^)(BOOL))completion {
    NSString *filePath = [self.xcodeHelper currentFilePath];
    [self autocorrectFileAt:filePath withCompletion:completion];
}

- (void)autocorrectFileAt:(NSString *)path withCompletion:(void (^)(BOOL))completion {
    int status = [self.swiftlintHelper autoCorrect:path withRule:NULL];
    completion(status == 0);
}

- (void)autocorrectProject:(void (^)(BOOL))completion {
    NSString *projectPath = [self.xcodeHelper activeProjectFolderPath];
    int status = [self.swiftlintHelper autoCorrect:projectPath withRule:NULL];
    completion(status == 0);
}

- (void)xcodeFormatShortcut {
    [self.xcodeHelper xcodeFormatShortcut];
}

@end
