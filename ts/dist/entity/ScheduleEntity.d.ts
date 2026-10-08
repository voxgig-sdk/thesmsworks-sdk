import { ThesmsworksEntityBase } from '../ThesmsworksEntityBase';
import type { ThesmsworksSDK } from '../ThesmsworksSDK';
import type { Control } from '../types';
import type { Schedule, ScheduleRemoveMatch } from '../ThesmsworksTypes';
declare class ScheduleEntity extends ThesmsworksEntityBase<Schedule> {
    constructor(client: ThesmsworksSDK, entopts: any);
    make(this: ScheduleEntity): ScheduleEntity;
    remove(this: any, reqmatch?: ScheduleRemoveMatch, ctrl?: Control): Promise<ScheduleEntity>;
}
export { ScheduleEntity };
