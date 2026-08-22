import { ThesmsworksEntityBase } from '../ThesmsworksEntityBase';
import type { ThesmsworksSDK } from '../ThesmsworksSDK';
import type { Control } from '../types';
import type { Credit, CreditLoadMatch } from '../ThesmsworksTypes';
declare class CreditEntity extends ThesmsworksEntityBase<Credit> {
    constructor(client: ThesmsworksSDK, entopts: any);
    make(this: CreditEntity): CreditEntity;
    load(this: any, reqmatch?: CreditLoadMatch, ctrl?: Control): Promise<CreditEntity>;
}
export { CreditEntity };
