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
    ai?: boolean;
    content: string;
    credits?: number;
    deliveryreporturl?: string;
    destination: string;
    from?: string;
    id?: string;
    keyword?: string;
    limit?: number;
    metadata?: Record<string, any>;
    responseemail?: any[];
    schedule?: string;
    sender: string;
    skip?: number;
    status?: string;
    tag?: string;
    to?: string;
    ttl?: number;
    unread?: boolean;
    validity?: number;
}
export interface MessageLoadMatch {
    id: string;
    $action?: string;
    [action: string]: any;
}
export interface MessageCreateData {
    ai?: boolean;
    content: string;
    credits?: number;
    deliveryreporturl?: string;
    destination: string;
    from?: string;
    id?: string;
    keyword?: string;
    limit?: number;
    metadata?: Record<string, any>;
    responseemail?: any[];
    schedule?: string;
    sender: string;
    skip?: number;
    status?: string;
    tag?: string;
    to?: string;
    ttl?: number;
    unread?: boolean;
    validity?: number;
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
