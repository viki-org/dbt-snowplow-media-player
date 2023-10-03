#!/bin/bash

# Expected input:
# -d (database) target database for dbt

while getopts 'd:' opt
do
  case $opt in
    d) DATABASE=$OPTARG
  esac
done

declare -a SUPPORTED_DATABASES=("bigquery" "databricks" "postgres" "redshift" "snowflake")

# set to lower case
DATABASE="$(echo $DATABASE | tr '[:upper:]' '[:lower:]')"

if [[ $DATABASE == "all" ]]; then
  DATABASES=( "${SUPPORTED_DATABASES[@]}" )
else
  DATABASES=$DATABASE
fi

for db in ${DATABASES[@]}; do

  echo "Snowplow media player integration tests: Seeding data"

  eval "dbt seed --target $db --full-refresh" || exit 1;

  # This run and the subsequent incremental ones exist just to make sure that the models work with the newer contexts disabled
  echo "Snowplow media player integration tests (v1 only): Execute models - run 1/6"

  eval "dbt run --target $db --full-refresh --vars '{snowplow__allow_refresh: true, snowplow__enable_media_player_v2: false, snowplow__enable_media_session: false, snowplow__enable_media_ad: false, snowplow__enable_media_ad_break: false, snowplow__enable_ad_quartile_event: false, snowplow__enable_mobile_events: false}'" || exit 1;
  
  echo "Snowplow media player integration tests (v1 only): Execute models - run 2/2"

  eval "dbt run --target $db --vars '{snowplow__allow_refresh: true, snowplow__enable_media_player_v2: false, snowplow__enable_media_session: false, snowplow__enable_media_ad: false, snowplow__enable_media_ad_break: false, snowplow__enable_ad_quartile_event: false, snowplow__enable_mobile_events: false}'" || exit 1;



  echo "Snowplow media player integration tests: Execute models - run 1/6"

  eval "dbt run --target $db --full-refresh --vars '{snowplow__allow_refresh: true}'" || exit 1;

  for i in {2..3}
  do
    echo "Snowplow media player integration tests: Execute models - run $i/6"

    eval "dbt run --target $db" || exit 1;
  done

  for i in {4..6}
  do
    echo "Snowplow media player integration tests: Execute models - run $i/6"

    eval "dbt run --target $db --vars '{snowplow__backfill_limit_days: 300}'" || exit 1;
  done

  echo "Snowplow media player integration tests: Test models"

  eval "dbt test --target $db" || exit 1;

  echo "Snowplow media player integration tests: All tests passed"

done
