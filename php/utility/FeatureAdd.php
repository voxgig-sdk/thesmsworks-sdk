<?php
declare(strict_types=1);

// Thesmsworks SDK utility: feature_add

class ThesmsworksFeatureAdd
{
    public static function call(ThesmsworksContext $ctx, mixed $f): void
    {
        $ctx->client->features[] = $f;
    }
}
