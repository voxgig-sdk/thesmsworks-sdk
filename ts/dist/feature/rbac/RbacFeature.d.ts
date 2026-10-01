import type { Context, FeatureOptions } from '../../types';
import type { ThesmsworksSDK } from '../../ThesmsworksSDK';
import { BaseFeature } from '../base/BaseFeature';
declare class RbacFeature extends BaseFeature {
    version: string;
    name: string;
    active: boolean;
    _client?: ThesmsworksSDK;
    _options: any;
    _granted: Record<string, boolean>;
    init(ctx: Context, options: FeatureOptions): void | Promise<any>;
    PrePoint(this: any, ctx: any): any;
    _required(this: any, ctx: any): string | null;
    _reject(this: any, ctx: any, required: string): any;
    _track(this: any, ctx: any, required: string, allowed: boolean): void;
}
export { RbacFeature };
