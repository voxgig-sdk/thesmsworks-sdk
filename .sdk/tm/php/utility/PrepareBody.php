<?php
declare(strict_types=1);

// Thesmsworks SDK utility: prepare_body

class ThesmsworksPrepareBody
{
    public static function call(ThesmsworksContext $ctx): mixed
    {
        if ($ctx->op->input === 'data') {
            return ($ctx->utility->transform_request)($ctx);
        }
        return null;
    }
}
