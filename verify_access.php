<?php
// verify_access.php
// Validates user_id, market_id and api_token sent via GET or POST (FormData)
// Include this file at the top of endpoint scripts (e.g. products.php)

// Prevent direct access to this file when requested directly
if (realpath(__FILE__) === realpath($_SERVER['SCRIPT_FILENAME'])) {
    http_response_code(404);
    exit;
}

$enable_token_api = true;
header('Content-Type: application/json; charset=utf-8');

// include DB / helper functions (adjust path if needed)
$baseInclude = __DIR__ . '/include/connect.php';
if (!file_exists($baseInclude)) {
    // try parent folder (common in some deployments)
    $baseInclude = __DIR__ . '/../include/connect.php';
}
if (!file_exists($baseInclude)) {
    $res = ["success" => false, "message" => "Server misconfiguration: include/connect.php not found", "path_checked" => [$baseInclude]];
    die(json_encode($res, JSON_UNESCAPED_UNICODE));
}
include_once($baseInclude);

$res = ["success" => false];

// Prefer values from POST (FormData). Fall back to REQUEST (GET/POST).
$user_id   = isset($_POST['user_id']) ? intval($_POST['user_id']) : intval($_REQUEST['user_id'] ?? 0);
$market_id = isset($_POST['market_id']) ? intval($_POST['market_id']) : intval($_REQUEST['market_id'] ?? 0);
$api_token = isset($_POST['api_token']) ? trim($_POST['api_token']) : trim($_REQUEST['api_token'] ?? '');

if ($user_id <= 0 || $market_id <= 0 || ($enable_token_api && empty($api_token))) {
    $res["message"] = "FORBIDDEN - Missing parameters (user_id, market_id, or api_token)";
    $res["received"] = [
        'method' => $_SERVER['REQUEST_METHOD'] ?? 'unknown',
        'post' => $_POST,
        'get' => $_GET,
        'request' => $_REQUEST,
    ];
    die(json_encode($res, JSON_UNESCAPED_UNICODE));
}

// Validate that the user is linked to the market and fetch stored token
$q = "SELECT u.api_token FROM `markets` m
      INNER JOIN `user_markets` um ON um.market_id = m.id
      INNER JOIN `users` u ON u.id = um.user_id
      WHERE u.id = $user_id AND m.id = $market_id LIMIT 1;";

$market = sql_query($q);

if (!isset($market[0]) || count($market[0]) == 0) {
    $res["message"] = "market or user_of_market not found";
    $res["query"] = $q;
    die(json_encode($res, JSON_UNESCAPED_UNICODE));
}

$stored_token = $market[0][0]['api_token'] ?? '';
if ($enable_token_api && ($stored_token !== $api_token)) {
    $res["message"] = "user is not logged in (invalid api_token)";
    $res["provided_token"] = $api_token;
    $res["expected_token_present"] = !empty($stored_token);
    die(json_encode($res, JSON_UNESCAPED_UNICODE));
}

// If we reach here, verification succeeded. Make $user_id and $market_id available
// to including scripts (products.php expects $market_id variable to exist).
$GLOBALS['verified_user_id'] = $user_id;
$GLOBALS['verified_market_id'] = $market_id;

// Also expose them as plain variables for legacy scripts
$user_id = $user_id;
$market_id = $market_id;

// Successful validation: simply return and let the including script continue.
return;

?>
