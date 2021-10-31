#!/usr/bin/env bash

# generate all templates and build them

TEST_DIR=$(mktemp -d)
echo Generating projects in "$TEST_DIR"

src_dir=$PWD/..

function run_template() {
	local proj_type=$1
	local proj_name=$2
	local template_path=$3

	(cd "$TEST_DIR" &&
		wash new "$proj_type" --silent --path "$template_path" "$proj_name" &&
		cd "$proj_name" &&
		make &&
		make test)
}

function test_template() {
	local proj_type=$1
	local proj_name=$2
	local template_path=$3

	local log
	log="log_$(date '+%Y%m%d_%H%M%S')_$proj_type"
	printf "%s %s ..." "$proj_type" "$proj_name"
	if run_template "$proj_type" "$proj_name" "$template_path" >"$log" 2>&1; then
		echo "Passed"
	else
		echo "Failed. Log in $log"
	fi
}

test_template actor my-hello "$src_dir/actor/hello"
test_template actor my-echo "$src_dir/actor/echo"
test_template interface my-ifa "$src_dir/interface/converter-actor"
test_template interface my-iff "$src_dir/interface/factorial"
test_template provider my-pr1 "$src_dir/provider/factorial"
