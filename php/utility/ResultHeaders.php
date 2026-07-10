<?php
declare(strict_types=1);

// Thesmsworks SDK utility: result_headers

class ThesmsworksResultHeaders
{
    public static function call(ThesmsworksContext $ctx): ?ThesmsworksResult
    {
        $response = $ctx->response;
        $result = $ctx->result;
        if ($result) {
            if ($response && is_array($response->headers)) {
                $result->headers = $response->headers;
            } else {
                $result->headers = [];
            }
        }
        return $result;
    }
}
