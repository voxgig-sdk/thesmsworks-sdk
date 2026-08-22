import { ThesmsworksEntityBase } from '../ThesmsworksEntityBase';
import type { ThesmsworksSDK } from '../ThesmsworksSDK';
import type { Control } from '../types';
import type { Batch, BatchLoadMatch } from '../ThesmsworksTypes';
declare class BatchEntity extends ThesmsworksEntityBase<Batch> {
    constructor(client: ThesmsworksSDK, entopts: any);
    make(this: BatchEntity): BatchEntity;
    load(this: any, reqmatch?: BatchLoadMatch, ctrl?: Control): Promise<BatchEntity>;
}
export { BatchEntity };
