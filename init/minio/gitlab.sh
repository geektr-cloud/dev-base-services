#!/usr/bin/env bash

host=minio_geektr_co
ak=gitlab
sk=$1

mc mb "$host/gitlab-runner"
mc mb "$host/gitlab-lfs"
mc mb "$host/gitlab-uploads"
mc mb "$host/gitlab-artifacts"
mc mb "$host/gitlab-extdiffs"
mc mb "$host/gitlab-registry"


mc admin user add "$host" "$ak" "$sk"

mc admin policy add "$host" gitlab-policy gitlab-policy.json
mc admin policy set "$host" gitlab-policy "user=$ak"
