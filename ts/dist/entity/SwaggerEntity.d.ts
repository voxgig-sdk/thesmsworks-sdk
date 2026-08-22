import { ThesmsworksEntityBase } from '../ThesmsworksEntityBase';
import type { ThesmsworksSDK } from '../ThesmsworksSDK';
import type { Swagger } from '../ThesmsworksTypes';
declare class SwaggerEntity extends ThesmsworksEntityBase<Swagger> {
    constructor(client: ThesmsworksSDK, entopts: any);
    make(this: SwaggerEntity): SwaggerEntity;
}
export { SwaggerEntity };
