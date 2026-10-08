import { ThesmsworksEntityBase } from '../ThesmsworksEntityBase';
import type { ThesmsworksSDK } from '../ThesmsworksSDK';
import type { Control } from '../types';
import type { MessageMessage, MessageMessageLoadMatch, MessageMessageCreateData, MessageMessageRemoveMatch } from '../ThesmsworksTypes';
declare class MessageMessageEntity extends ThesmsworksEntityBase<MessageMessage> {
    constructor(client: ThesmsworksSDK, entopts: any);
    make(this: MessageMessageEntity): MessageMessageEntity;
    load(this: any, reqmatch?: MessageMessageLoadMatch, ctrl?: Control): Promise<MessageMessageEntity>;
    create(this: any, reqdata?: MessageMessageCreateData, ctrl?: Control): Promise<MessageMessageEntity>;
    remove(this: any, reqmatch?: MessageMessageRemoveMatch, ctrl?: Control): Promise<MessageMessageEntity>;
}
export { MessageMessageEntity };
