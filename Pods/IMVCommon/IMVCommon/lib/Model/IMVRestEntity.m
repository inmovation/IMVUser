//
//  IMRestEntity.m
//  MobileExam
//
//  Created by 陈少华 on 15/4/2.
//  Copyright (c) 2015年 inmovation. All rights reserved.
//

#import "IMVRestEntity.h"

@implementation IMVRestEntity

+ (NSString *)getPropertyTypeWithPropertyAttr:(NSString *)propertyAttr
{
    NSArray *componets = [propertyAttr componentsSeparatedByString:@"\""];
    NSString *type = nil;
    if (componets.count>=3) {
        type = [componets objectAtIndex:1];
    }
    return type;
}

+ (id)entityWithOid:(NSString *)oid
{
    id entity = [[self alloc] init];
    [entity setOid:oid];
    return entity;
}

+ (NSString *)pathPattern
{
    NSString *path = [[NSString stringWithFormat:@"%@s", NSStringFromClass([self class])] lowercaseString];
    return path;
}

+ (NSString *)pathWithObject:(id)object
{
    NSString *path = [NSString stringWithFormat:@"api/%@", [self pathPattern]];
    if (!object) {
        return path;
    }
    if ([object isKindOfClass:[NSString class]]) {
        path = [NSString stringWithFormat:@"%@/%@", path, object];
    }
    else if ([object isKindOfClass:[IMVRestEntity class]])
    {
        path = [NSString stringWithFormat:@"%@/%@", path, [object oid]];
    }
    return path;
}

#ifdef RKObjectMapping

+ (NSArray *)relationshipMappings
{
    return nil;
}

+ (RKObjectMapping *)objectMapping
{
    RKObjectMapping *objectMapping = [RKObjectMapping mappingForClass:[self class]];
    NSMutableArray *attributes = [NSMutableArray array];
    unsigned int outCount;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for(int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        
        NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:[NSString defaultCStringEncoding]];
        NSString *propertyAttr = [NSString stringWithCString:property_getAttributes(property) encoding:[NSString defaultCStringEncoding]];
        NSString *propertyType = [self getPropertyTypeWithPropertyAttr:propertyAttr];
        Class propertyClass = NSClassFromString(propertyType);
        if (propertyClass == nil) {
            RKLogWarning(@"%@.%@ is not a class, mapping ignored", NSStringFromClass([self class]), propertyName);
            continue;
        }
        
        if ([propertyClass isSubclassOfClass:[RestEntity class]]) {
            [objectMapping addRelationshipMappingWithSourceKeyPath:propertyName mapping:[propertyClass objectMapping]];
        }
        else if ([propertyClass isSubclassOfClass:[NSArray class]] || [propertyClass isSubclassOfClass:[NSDictionary class]])
        {
            
        }
        else
        {
            [attributes addObject:propertyName];
        }
    }
    free(properties);
    
    [attributes addObject:@"oid"];
    //    [attributes addObject:@"authorities"];
    [objectMapping addAttributeMappingsFromArray:attributes];
    NSArray *relationMappings = [self relationshipMappings];
    
    [objectMapping addPropertyMappingsFromArray:relationMappings];
    
    
    return objectMapping;
}


+ (NSDictionary*)getDictionaryFromObject_Ext:(id)obj
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int propsCount;
    objc_property_t *props = class_copyPropertyList([obj class], &propsCount);
    for(int i = 0;i < propsCount; i++) {
        objc_property_t prop = props[i];
        id value = nil;
        
        @try {
            NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
            value = [self getObjectInternal_Ext:[obj valueForKey:propName]];
            if(value != nil) {
                [dic setObject:value forKey:propName];
            }
        }
        @catch (NSException *exception) {
            //[self logError:exception];
            NSLog(@"%@",exception);
        }
        
    }
    free(props);
    return dic;
}

+ (id)getObjectInternal_Ext:(id)obj
{
    if(!obj
       || [obj isKindOfClass:[NSString class]]
       || [obj isKindOfClass:[NSNumber class]]
       || [obj isKindOfClass:[NSNull class]]) {
        return obj;
    }
    
    if([obj isKindOfClass:[NSArray class]]) {
        NSArray *objarr = obj;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objarr.count];
        for(int i = 0;i < objarr.count; i++) {
            [arr setObject:[self getObjectInternal_Ext:[objarr objectAtIndex:i]] atIndexedSubscript:i];
        }
        return arr;
    }
    
    if([obj isKindOfClass:[NSDictionary class]]) {
        NSDictionary *objdic = obj;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];
        for(NSString *key in objdic.allKeys) {
            [dic setObject:[self getObjectInternal_Ext:[objdic objectForKey:key]] forKey:key];
        }
        return dic;
    }
    return [self getDictionaryFromObject_Ext:obj];
}

+ (void)getObject:(id)object success:(RestSuccessBlock)success failure:(RestFailureBlock)failure
{
    NSString *path = [self pathWithObject:object];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[self objectMapping] method:RKRequestMethodGET pathPattern:path keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [[RestClient sharedInstence] operationWithObject:object path:path parameters:nil method:RKRequestMethodGET responseDescriptor:responseDescriptor success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        success(mappingResult.firstObject);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

+ (void)getObjectsAtPage:(RestPage *)page success:(RestSuccessBlock)success failure:(RestFailureBlock)failure
{
    NSString *path = [self pathWithObject:nil];
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[self objectMapping] method:RKRequestMethodGET pathPattern:path keyPath:[NSString stringWithFormat:@"_embedded.%@", [self pathPattern]] statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [[RestClient sharedInstence] operationWithObject:nil path:path parameters:[page dictionary] method:RKRequestMethodGET responseDescriptor:responseDescriptor success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        success(mappingResult.array);
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

+ (void)searchObjectsWithSearch:(NSString *)search parameters:(NSDictionary *)parameters atPage:(RestPage *)page success:(RestSuccessBlock)success failure:(RestFailureBlock)failure;
{
    assert(search&&parameters);
    NSString *path = [self pathWithObject:[NSString stringWithFormat:@"search/%@", search]];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:[page dictionary]];
    for (NSString *key in parameters.allKeys) {
        [param setObject:[parameters objectForKey:key] forKey:key];
    }
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[self objectMapping] method:RKRequestMethodGET pathPattern:path keyPath:[NSString stringWithFormat:@"_embedded.%@", [self pathPattern]] statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [[RestClient sharedInstence] operationWithObject:nil path:path parameters:param method:RKRequestMethodGET responseDescriptor:responseDescriptor success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        success(mappingResult.array);
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

+ (void)getObjectDetailWithObjectId:(NSString *)objectId parameters:(NSDictionary *)parameters success:(RestSuccessBlock)success failure:(RestFailureBlock)failure{
    NSString *path = [self pathWithObject:objectId];
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[self objectMapping] method:RKRequestMethodGET pathPattern:path keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [[RestClient sharedInstence] operationWithObject:nil path:path parameters:parameters method:RKRequestMethodGET responseDescriptor:responseDescriptor success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        success(mappingResult.array);
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        failure(error);
    }];
    
}

+ (void)postObject:(id)object success:(RestSuccessBlock)success failure:(RestFailureBlock)failure
{
    NSString *path = [NSString stringWithFormat:@"api/%@", [self pathPattern]];
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[self objectMapping] method:RKRequestMethodPOST pathPattern:path keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    responseDescriptor.baseURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@api", KMRestClientBaseUrl]];
    
    [[RestClient sharedInstence] operationWithObject:object path:path parameters:nil method:RKRequestMethodPOST responseDescriptor:responseDescriptor success:^(RKObjectRequestOperation *operation, RKMappingResult *result) {
        success(result.firstObject);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

+ (void)putObject:(id)object success:(RestSuccessBlock)success failure:(RestFailureBlock)failure
{
    NSString *path = [self pathWithObject:object];
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[self objectMapping] method:RKRequestMethodPUT pathPattern:path keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];;
    
    [[RestClient sharedInstence] operationWithObject:object path:path parameters:nil method:RKRequestMethodPUT responseDescriptor:responseDescriptor success:^(RKObjectRequestOperation *operation, RKMappingResult *result) {
        success(result.firstObject);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}
+ (void)patchObject:(id)object success:(RestSuccessBlock)success failure:(RestFailureBlock)failure
{
    NSString *path = [self pathWithObject:object];
    NSDictionary *dic = [self getDictionaryFromObject_Ext:object];
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[self objectMapping] method:RKRequestMethodPATCH pathPattern:path keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];;
    
    [[RestClient sharedInstence] operationWithObject:nil path:path parameters:dic method:RKRequestMethodPATCH responseDescriptor:responseDescriptor success:^(RKObjectRequestOperation *operation, RKMappingResult *result) {
        success(result.firstObject);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

+ (void)deleteObject:(id)object success:(RestSuccessBlock)success failure:(RestFailureBlock)failure
{
    NSString *path = [NSString stringWithFormat:@"api/%@/deleteBy", [self pathPattern]];
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[self objectMapping] method:RKRequestMethodDELETE pathPattern:path keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [[RestClient sharedInstence] operationWithObject:object path:path parameters:nil method:RKRequestMethodDELETE responseDescriptor:responseDescriptor success:^(RKObjectRequestOperation *operation, RKMappingResult *result) {
        success(result.firstObject);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

+ (void)cancelRequest
{
    [[RestClient sharedInstence] cancelAllObjectRequestOperationsWithMethod:RKRequestMethodAny matchingPathPattern:[self pathPattern]];
}
#endif

@end
