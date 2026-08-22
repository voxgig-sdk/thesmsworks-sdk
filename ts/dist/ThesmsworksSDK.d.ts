import { BatchEntity } from './entity/BatchEntity';
import { BatchMessageEntity } from './entity/BatchMessageEntity';
import { CreditEntity } from './entity/CreditEntity';
import { FlashEntity } from './entity/FlashEntity';
import { MessageEntity } from './entity/MessageEntity';
import { OneTimePasswordEntity } from './entity/OneTimePasswordEntity';
import { ScheduleEntity } from './entity/ScheduleEntity';
import { SwaggerEntity } from './entity/SwaggerEntity';
import { UtilEntity } from './entity/UtilEntity';
export type * from './ThesmsworksTypes';
import { inspect } from 'node:util';
import type { Context, Feature } from './types';
import { config } from './Config';
import { ThesmsworksEntityBase } from './ThesmsworksEntityBase';
import { Utility } from './utility/Utility';
import { BaseFeature } from './feature/base/BaseFeature';
declare const stdutil: Utility;
declare class ThesmsworksSDK {
    _mode: string;
    _options: any;
    _utility: Utility;
    _features: Feature[];
    _rootctx: Context;
    constructor(options?: any);
    options(): any;
    utility(): any;
    prepare(fetchargs?: any): Promise<any>;
    direct(fetchargs?: any): Promise<Error | {
        ok: boolean;
        status: number;
        headers: any;
        data: any;
        err?: undefined;
    } | {
        ok: boolean;
        err: any;
        status?: undefined;
        headers?: undefined;
        data?: undefined;
    }>;
    _rawRequest(fetchargs?: any): Promise<Error | {
        ok: boolean;
        status: number;
        headers: any;
        data: any;
        err?: undefined;
    } | {
        ok: boolean;
        err: any;
        status?: undefined;
        headers?: undefined;
        data?: undefined;
    }>;
    graphql(query: string, variables?: any, ctrl?: any): Promise<any>;
    Batch(entopts?: Record<string, any>): BatchEntity;
    BatchMessage(entopts?: Record<string, any>): BatchMessageEntity;
    Credit(entopts?: Record<string, any>): CreditEntity;
    Flash(entopts?: Record<string, any>): FlashEntity;
    Message(entopts?: Record<string, any>): MessageEntity;
    OneTimePassword(entopts?: Record<string, any>): OneTimePasswordEntity;
    Schedule(entopts?: Record<string, any>): ScheduleEntity;
    Swagger(entopts?: Record<string, any>): SwaggerEntity;
    Util(entopts?: Record<string, any>): UtilEntity;
    static test(testoptsarg?: any, sdkoptsarg?: any): ThesmsworksSDK;
    tester(testopts?: any, sdkopts?: any): ThesmsworksSDK;
    toJSON(): {
        name: string;
    };
    toString(): string;
    [inspect.custom](): string;
}
declare const SDK: typeof ThesmsworksSDK;
export { stdutil, config, BaseFeature, ThesmsworksEntityBase, ThesmsworksSDK, SDK, };
