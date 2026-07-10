<?php
declare(strict_types=1);

// Thesmsworks SDK utility registration

require_once __DIR__ . '/../core/UtilityType.php';
require_once __DIR__ . '/Clean.php';
require_once __DIR__ . '/Done.php';
require_once __DIR__ . '/MakeError.php';
require_once __DIR__ . '/FeatureAdd.php';
require_once __DIR__ . '/FeatureHook.php';
require_once __DIR__ . '/FeatureInit.php';
require_once __DIR__ . '/Fetcher.php';
require_once __DIR__ . '/MakeFetchDef.php';
require_once __DIR__ . '/MakeContext.php';
require_once __DIR__ . '/MakeOptions.php';
require_once __DIR__ . '/MakeRequest.php';
require_once __DIR__ . '/MakeResponse.php';
require_once __DIR__ . '/MakeResult.php';
require_once __DIR__ . '/MakePoint.php';
require_once __DIR__ . '/MakeSpec.php';
require_once __DIR__ . '/MakeUrl.php';
require_once __DIR__ . '/Param.php';
require_once __DIR__ . '/PrepareAuth.php';
require_once __DIR__ . '/PrepareBody.php';
require_once __DIR__ . '/PrepareHeaders.php';
require_once __DIR__ . '/PrepareMethod.php';
require_once __DIR__ . '/PrepareParams.php';
require_once __DIR__ . '/PreparePath.php';
require_once __DIR__ . '/PrepareQuery.php';
require_once __DIR__ . '/ResultBasic.php';
require_once __DIR__ . '/ResultBody.php';
require_once __DIR__ . '/ResultHeaders.php';
require_once __DIR__ . '/TransformRequest.php';
require_once __DIR__ . '/TransformResponse.php';

ThesmsworksUtility::setRegistrar(function (ThesmsworksUtility $u): void {
    $u->clean = [ThesmsworksClean::class, 'call'];
    $u->done = [ThesmsworksDone::class, 'call'];
    $u->make_error = [ThesmsworksMakeError::class, 'call'];
    $u->feature_add = [ThesmsworksFeatureAdd::class, 'call'];
    $u->feature_hook = [ThesmsworksFeatureHook::class, 'call'];
    $u->feature_init = [ThesmsworksFeatureInit::class, 'call'];
    $u->fetcher = [ThesmsworksFetcher::class, 'call'];
    $u->make_fetch_def = [ThesmsworksMakeFetchDef::class, 'call'];
    $u->make_context = [ThesmsworksMakeContext::class, 'call'];
    $u->make_options = [ThesmsworksMakeOptions::class, 'call'];
    $u->make_request = [ThesmsworksMakeRequest::class, 'call'];
    $u->make_response = [ThesmsworksMakeResponse::class, 'call'];
    $u->make_result = [ThesmsworksMakeResult::class, 'call'];
    $u->make_point = [ThesmsworksMakePoint::class, 'call'];
    $u->make_spec = [ThesmsworksMakeSpec::class, 'call'];
    $u->make_url = [ThesmsworksMakeUrl::class, 'call'];
    $u->param = [ThesmsworksParam::class, 'call'];
    $u->prepare_auth = [ThesmsworksPrepareAuth::class, 'call'];
    $u->prepare_body = [ThesmsworksPrepareBody::class, 'call'];
    $u->prepare_headers = [ThesmsworksPrepareHeaders::class, 'call'];
    $u->prepare_method = [ThesmsworksPrepareMethod::class, 'call'];
    $u->prepare_params = [ThesmsworksPrepareParams::class, 'call'];
    $u->prepare_path = [ThesmsworksPreparePath::class, 'call'];
    $u->prepare_query = [ThesmsworksPrepareQuery::class, 'call'];
    $u->result_basic = [ThesmsworksResultBasic::class, 'call'];
    $u->result_body = [ThesmsworksResultBody::class, 'call'];
    $u->result_headers = [ThesmsworksResultHeaders::class, 'call'];
    $u->transform_request = [ThesmsworksTransformRequest::class, 'call'];
    $u->transform_response = [ThesmsworksTransformResponse::class, 'call'];
});
