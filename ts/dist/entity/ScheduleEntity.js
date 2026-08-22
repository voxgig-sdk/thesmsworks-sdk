"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.ScheduleEntity = void 0;
const ThesmsworksEntityBase_1 = require("../ThesmsworksEntityBase");
// TODO: needs Entity superclass
class ScheduleEntity extends ThesmsworksEntityBase_1.ThesmsworksEntityBase {
    constructor(client, entopts) {
        super(client, entopts);
        this.name = 'schedule';
        this.name_ = 'schedule';
        this.Name = 'Schedule';
    }
    make() {
        return new ScheduleEntity(this._client, this.entopts());
    }
}
exports.ScheduleEntity = ScheduleEntity;
//# sourceMappingURL=ScheduleEntity.js.map