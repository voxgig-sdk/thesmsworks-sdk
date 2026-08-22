import { ThesmsworksEntityBase } from '../ThesmsworksEntityBase';
import type { ThesmsworksSDK } from '../ThesmsworksSDK';
import type { Control } from '../types';
import type { BatchMessage, BatchMessageCreateData, BatchMessageRemoveMatch } from '../ThesmsworksTypes';
declare class BatchMessageEntity extends ThesmsworksEntityBase<BatchMessage> {
    constructor(client: ThesmsworksSDK, entopts: any);
    make(this: BatchMessageEntity): BatchMessageEntity;
    create(this: any, reqdata?: BatchMessageCreateData, ctrl?: Control): Promise<BatchMessageEntity>;
    remove(this: any, reqmatch?: BatchMessageRemoveMatch, ctrl?: Control): Promise<BatchMessageEntity>;
}
export { BatchMessageEntity };
