export interface Batch {
    id?: string;
}
export interface BatchLoadMatch {
    id: string;
}
export interface BatchMessage {
    ai?: boolean;
    content: string;
    deliveryreporturl?: string;
    destinations: any[];
    schedule?: string;
    sender: string;
    tag?: string;
    ttl?: number;
    validity?: number;
}
export interface BatchMessageCreateData {
    ai?: boolean;
    content: string;
    deliveryreporturl?: string;
    destinations: any[];
    schedule?: string;
    sender: string;
    tag?: string;
    ttl?: number;
    validity?: number;
}
export interface BatchMessageRemoveMatch {
    batchid: string;
}
export interface Credit {
}
export interface CreditLoadMatch {
    $action?: string;
    [action: string]: any;
}
export interface Flash {
}
export interface Message {
    credits?: number;
    destination?: string;
    from?: string;
    id?: string;
    keyword?: string;
    limit?: number;
    metadata?: Record<string, any>;
    sender?: string;
    skip?: number;
    status?: string;
    to?: string;
    unread?: boolean;
}
export interface MessageLoadMatch {
    id: string;
    $action?: string;
    [action: string]: any;
}
export interface MessageCreateData {
    credits?: number;
    destination?: string;
    from?: string;
    id?: string;
    keyword?: string;
    limit?: number;
    metadata?: Record<string, any>;
    sender?: string;
    skip?: number;
    status?: string;
    to?: string;
    unread?: boolean;
    $action?: string;
    [action: string]: any;
}
export interface MessageRemoveMatch {
    id: string;
}
export interface OneTimePassword {
    destination?: string;
    length?: Record<string, any>;
    metadata?: Record<string, any>;
    passcode?: string;
    sender?: string;
    template?: string;
    validity?: number;
}
export interface OneTimePasswordLoadMatch {
    messageid: string;
}
export interface OneTimePasswordCreateData {
    destination?: string;
    length?: Record<string, any>;
    metadata?: Record<string, any>;
    passcode?: string;
    sender?: string;
    template?: string;
    validity?: number;
}
export interface Schedule {
}
export interface Swagger {
}
export interface Util {
}
export interface UtilLoadMatch {
    errorcode: string;
    $action?: string;
    [action: string]: any;
}
