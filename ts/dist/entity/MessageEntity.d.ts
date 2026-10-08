import { ThesmsworksEntityBase } from '../ThesmsworksEntityBase';
import type { ThesmsworksSDK } from '../ThesmsworksSDK';
import type { Control } from '../types';
import type { Message, MessageCreateData } from '../ThesmsworksTypes';
declare class MessageEntity extends ThesmsworksEntityBase<Message> {
    constructor(client: ThesmsworksSDK, entopts: any);
    make(this: MessageEntity): MessageEntity;
    create(this: any, reqdata?: MessageCreateData, ctrl?: Control): Promise<MessageEntity>;
}
export { MessageEntity };
