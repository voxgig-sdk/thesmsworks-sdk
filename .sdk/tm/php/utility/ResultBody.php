<?php
declare(strict_types=1);

// Thesmsworks SDK utility: result_body

class ThesmsworksResultBody
{
    public static function call(ThesmsworksContext $ctx): ?ThesmsworksResult
    {
        $response = $ctx->response;
        $result = $ctx->result;
        if ($result && $response && $response->json_func && $response->body) {
            $result->body = ($response->json_func)();
        }
        return $result;
    }
}
