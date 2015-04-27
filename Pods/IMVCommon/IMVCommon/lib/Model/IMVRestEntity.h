//
//  IMRestEntity.h
//  MobileExam
//
//  Created by 陈少华 on 15/4/2.
//  Copyright (c) 2015年 inmovation. All rights reserved.
//

#import "IMVEntity.h"

typedef void(^RestSuccessBlock)(id object);
typedef void(^RestFailureBlock)(NSError *error);

/**
 *  如果后台的接口是spring rest框架的，那么可以继承自该类，提供了对象的get，post，put方法
 */
@interface IMVRestEntity : IMVEntity

/**
 *  对象的id
 */
@property (strong, nonatomic) NSString *oid;


+ (id)entityWithOid:(NSString *)oid;

#ifdef RKObjectMapping
+ (NSString *)pathPattern;

+ (NSArray *)relationshipMappings;

+ (RKObjectMapping *)objectMapping;

+ (void)getObject:(id)object success:(RestSuccessBlock)success failure:(RestFailureBlock)failure;

+ (void)getObjectsAtPage:(RestPage *)page success:(RestSuccessBlock)success failure:(RestFailureBlock)failure;

+ (void)getObjectDetailWithObjectId:(NSString *)objectId parameters:(NSDictionary *)parameters success:(RestSuccessBlock)success failure:(RestFailureBlock)failure;

+ (void)searchObjectsWithSearch:(NSString *)search parameters:(NSDictionary *)parameters atPage:(RestPage *)page success:(RestSuccessBlock)success failure:(RestFailureBlock)failure;

+ (void)postObject:(id)object success:(RestSuccessBlock)success failure:(RestFailureBlock)failure;

+ (void)putObject:(id)object success:(RestSuccessBlock)success failure:(RestFailureBlock)failure;

+ (void)patchObject:(id)object success:(RestSuccessBlock)success failure:(RestFailureBlock)failure;

+ (void)deleteObject:(id)object success:(RestSuccessBlock)success failure:(RestFailureBlock)failure;

+ (void)cancelRequest;
#endif

@end
