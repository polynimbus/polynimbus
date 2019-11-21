<?php

$file = "/var/cache/polynimbus/inventory/projects-aws.list";
$date = date("Y-m-d H:i:s", filemtime($file));

require "include/page.php";
require "include/aws.php";
require "include/raw.php";
require "include/account.php";
page_header("Polynimbus: the future of the cloud");

?>
<div style="font-size:13px;">
<img src="assets/logo.png" alt="Polynimbus" style="max-width:20%;">
<br />
<br />
Available resources:
<br />
<ul>
	<li><a href="instances.php">list of cloud instances (on all providers and configured accounts)</a></li>
	<li><a href="databases.php">AWS - list of RDS databases</a></li>
	<li><a href="object-storage.php">AWS/Azure - list of object storage buckets/shares/blobs/etc.</a></li>
	<li><a href="functions.php">AWS - list of Lambda functions</a></li>
	<li><a href="zones.php">AWS - list of Route53 hosted zones (domains)</a></li>
	<li><a href="trails.php">AWS - list of CloudTrail log trails</a></li>
	<li><a href="aws-raw-matrix.php">AWS - matrix of per-region raw data dumps</a></li>
	<li><a href="google-users.php">Google Cloud - list of users and permissions (in all linked projects)</a></li>
</ul>
<br />
<?php

echo "Configured AWS accounts as of $date:<br /><ul>\n";
$data = file_get_contents($file);
$lines = explode("\n", $data);
sort($lines);

foreach ($lines as $line) {
	$line = trim($line);
	if (empty($line))
		continue;

	$tmp = explode(" ", $line, 2);
	$account = $tmp[0];

	$link = get_account_link("aws", $account);
	echo "<li style=\"margin-bottom: 10px;\"><strong>$link</strong>";
	echo link_aws_global_raw_content($account, "cloudfront");
	echo "</li>\n";
}
echo "</ul>";

$account = "default";
$file = "/var/cache/polynimbus/inventory/users-azure-$account.list";
if (file_exists($file)) {
	echo "Configured Azure accounts:<br /><ul>\n";
	$link = get_account_link("azure", $account);
	echo "<li style=\"margin-bottom: 10px;\"><strong>$link</strong></li>\n";
	echo "</ul>";
}
echo "</div>";
page_end();
