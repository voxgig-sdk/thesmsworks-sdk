import { ThesmsworksEntityBase } from '../ThesmsworksEntityBase';
import type { ThesmsworksSDK } from '../ThesmsworksSDK';
import type { Control } from '../types';
import type { Util, UtilLoadMatch } from '../ThesmsworksTypes';
declare class UtilEntity extends ThesmsworksEntityBase<Util> {
    constructor(client: ThesmsworksSDK, entopts: any);
    make(this: UtilEntity): UtilEntity;
    load(this: any, reqmatch?: UtilLoadMatch, ctrl?: Control): Promise<UtilEntity>;
}
export { UtilEntity };
