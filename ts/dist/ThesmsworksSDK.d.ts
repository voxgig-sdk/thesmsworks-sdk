import { BatchEntity } from './entity/BatchEntity';
import { BatchMessageEntity } from './entity/BatchMessageEntity';
import { CreditEntity } from './entity/CreditEntity';
import { MessageEntity } from './entity/MessageEntity';
import { OneTimePasswordEntity } from './entity/OneTimePasswordEntity';
import { UtilEntity } from './entity/UtilEntity';
export type * from './ThesmsworksTypes';
import { inspect } from 'node:util';
import type { Context, Feature } from './types';
import { config } from './Config';
import { ThesmsworksEntityBase } from './ThesmsworksEntityBase';
import { Utility } from './utility/Utility';
import { BaseFeature } from './feature/base/BaseFeature';
import * as sekreto from './feature/secrets/sekreto';
declare const stdutil: Utility;
declare class ThesmsworksSDK {
    _mode: string;
    _options: any;
    _utility: Utility;
    _features: Feature[];
    _rootctx: Context;
    _secrets?: any;
    constructor(options?: any);
    options(): any;
    utility(): any;
    secrets(): any;
    prepare(fetchargs?: any): Promise<any>;
    direct(fetchargs?: any): Promise<Error | {
        ok: boolean;
        err: any;
        status?: undefined;
        headers?: undefined;
        data?: undefined;
    } | {
        ok: boolean;
        status: number;
        headers: any;
        data: any;
        err?: undefined;
    }>;
    _rawRequest(fetchargs?: any): Promise<Error | {
        ok: boolean;
        err: any;
        status?: undefined;
        headers?: undefined;
        data?: undefined;
    } | {
        ok: boolean;
        status: number;
        headers: any;
        data: any;
        err?: undefined;
    }>;
    graphql(query: string, variables?: any, ctrl?: any): Promise<any>;
    Batch(entopts?: Record<string, any>): BatchEntity;
    BatchMessage(entopts?: Record<string, any>): BatchMessageEntity;
    Credit(entopts?: Record<string, any>): CreditEntity;
    Message(entopts?: Record<string, any>): MessageEntity;
    OneTimePassword(entopts?: Record<string, any>): OneTimePasswordEntity;
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
export { stdutil, config, sekreto, BaseFeature, ThesmsworksEntityBase, ThesmsworksSDK, SDK, };
