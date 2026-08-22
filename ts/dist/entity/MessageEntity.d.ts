import { ThesmsworksEntityBase } from '../ThesmsworksEntityBase';
import type { ThesmsworksSDK } from '../ThesmsworksSDK';
import type { Control } from '../types';
import type { Message, MessageLoadMatch, MessageCreateData, MessageRemoveMatch } from '../ThesmsworksTypes';
declare class MessageEntity extends ThesmsworksEntityBase<Message> {
    constructor(client: ThesmsworksSDK, entopts: any);
    make(this: MessageEntity): MessageEntity;
    load(this: any, reqmatch?: MessageLoadMatch, ctrl?: Control): Promise<MessageEntity>;
    create(this: any, reqdata?: MessageCreateData, ctrl?: Control): Promise<MessageEntity>;
    remove(this: any, reqmatch?: MessageRemoveMatch, ctrl?: Control): Promise<MessageEntity>;
}
export { MessageEntity };
