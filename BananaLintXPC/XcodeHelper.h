//
//  XcodeHelper.h
//  BananaLint
//
//  Created by Danil Chemaev on 2024/04/23.
//  
//

#import <Foundation/Foundation.h>

@interface XcodeHelper : NSObject
- (NSString *)activeWorkspaceDocumentPath;
- (NSString *)activeProjectFolderPath;
- (NSString *)currentFilePath;
- (NSString *)defaultSwiftLintYmlPath;
- (void)save;
- (void)xcodeFormatShortcut;
@end

