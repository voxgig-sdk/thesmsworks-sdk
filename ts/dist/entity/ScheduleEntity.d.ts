import { ThesmsworksEntityBase } from '../ThesmsworksEntityBase';
import type { ThesmsworksSDK } from '../ThesmsworksSDK';
import type { Schedule } from '../ThesmsworksTypes';
declare class ScheduleEntity extends ThesmsworksEntityBase<Schedule> {
    constructor(client: ThesmsworksSDK, entopts: any);
    make(this: ScheduleEntity): ScheduleEntity;
}
export { ScheduleEntity };
