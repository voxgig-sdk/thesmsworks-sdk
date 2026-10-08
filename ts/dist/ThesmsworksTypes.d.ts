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
export interface Credit {
}
export interface CreditLoadMatch {
    $action?: string;
    [action: string]: any;
}
export interface Message {
}
export interface MessageCreateData {
    $action?: string;
    [action: string]: any;
}
export interface MessageMessage {
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
export interface MessageMessageLoadMatch {
    id: string;
}
export interface MessageMessageCreateData {
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
export interface MessageMessageRemoveMatch {
    id: string;
}
export interface MessageSchedule {
    id?: string;
}
export interface MessageScheduleLoadMatch {
    id: string;
    $action?: string;
    [action: string]: any;
}
export interface MessageScheduleRemoveMatch {
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
    id?: string;
}
export interface ScheduleRemoveMatch {
    id: string;
}
export interface Util {
}
export interface UtilLoadMatch {
    errorcode: string;
    $action?: string;
    [action: string]: any;
}
