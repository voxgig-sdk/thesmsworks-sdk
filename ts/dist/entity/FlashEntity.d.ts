import { ThesmsworksEntityBase } from '../ThesmsworksEntityBase';
import type { ThesmsworksSDK } from '../ThesmsworksSDK';
import type { Flash } from '../ThesmsworksTypes';
declare class FlashEntity extends ThesmsworksEntityBase<Flash> {
    constructor(client: ThesmsworksSDK, entopts: any);
    make(this: FlashEntity): FlashEntity;
}
export { FlashEntity };
