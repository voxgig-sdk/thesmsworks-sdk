"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.SwaggerEntity = void 0;
const ThesmsworksEntityBase_1 = require("../ThesmsworksEntityBase");
// TODO: needs Entity superclass
class SwaggerEntity extends ThesmsworksEntityBase_1.ThesmsworksEntityBase {
    constructor(client, entopts) {
        super(client, entopts);
        this.name = 'swagger';
        this.name_ = 'swagger';
        this.Name = 'Swagger';
    }
    make() {
        return new SwaggerEntity(this._client, this.entopts());
    }
}
exports.SwaggerEntity = SwaggerEntity;
//# sourceMappingURL=SwaggerEntity.js.map