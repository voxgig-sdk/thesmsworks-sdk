"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.FlashEntity = void 0;
const ThesmsworksEntityBase_1 = require("../ThesmsworksEntityBase");
// TODO: needs Entity superclass
class FlashEntity extends ThesmsworksEntityBase_1.ThesmsworksEntityBase {
    constructor(client, entopts) {
        super(client, entopts);
        this.name = 'flash';
        this.name_ = 'flash';
        this.Name = 'Flash';
    }
    make() {
        return new FlashEntity(this._client, this.entopts());
    }
}
exports.FlashEntity = FlashEntity;
//# sourceMappingURL=FlashEntity.js.map