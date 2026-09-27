"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.ThesmsworksError = void 0;
class ThesmsworksError extends Error {
    isThesmsworksError = true;
    sdk = 'Thesmsworks';
    code;
    ctx;
    status = -1;
    // `err.notFound` rather than a magic number at every call site.
    get notFound() { return 404 === this.status; }
    constructor(code, msg, ctx) {
        super(msg);
        this.code = code;
        this.ctx = ctx;
    }
}
exports.ThesmsworksError = ThesmsworksError;
//# sourceMappingURL=ThesmsworksError.js.map