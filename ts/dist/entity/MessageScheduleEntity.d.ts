import { ThesmsworksEntityBase } from '../ThesmsworksEntityBase';
import type { ThesmsworksSDK } from '../ThesmsworksSDK';
import type { Control } from '../types';
import type { MessageSchedule, MessageScheduleLoadMatch, MessageScheduleRemoveMatch } from '../ThesmsworksTypes';
declare class MessageScheduleEntity extends ThesmsworksEntityBase<MessageSchedule> {
    constructor(client: ThesmsworksSDK, entopts: any);
    make(this: MessageScheduleEntity): MessageScheduleEntity;
    load(this: any, reqmatch?: MessageScheduleLoadMatch, ctrl?: Control): Promise<MessageScheduleEntity>;
    remove(this: any, reqmatch?: MessageScheduleRemoveMatch, ctrl?: Control): Promise<MessageScheduleEntity>;
}
export { MessageScheduleEntity };
