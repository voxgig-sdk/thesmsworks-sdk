import { ThesmsworksEntityBase } from '../ThesmsworksEntityBase';
import type { ThesmsworksSDK } from '../ThesmsworksSDK';
import type { Control } from '../types';
import type { OneTimePassword, OneTimePasswordLoadMatch, OneTimePasswordCreateData } from '../ThesmsworksTypes';
declare class OneTimePasswordEntity extends ThesmsworksEntityBase<OneTimePassword> {
    constructor(client: ThesmsworksSDK, entopts: any);
    make(this: OneTimePasswordEntity): OneTimePasswordEntity;
    load(this: any, reqmatch?: OneTimePasswordLoadMatch, ctrl?: Control): Promise<OneTimePasswordEntity>;
    create(this: any, reqdata?: OneTimePasswordCreateData, ctrl?: Control): Promise<OneTimePasswordEntity>;
}
export { OneTimePasswordEntity };
