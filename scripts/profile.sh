#! /usr/bin/env bash

#쉬고 있는 profile 찾기 , real 1이 사용중이면 real2가 쉬고 있음

function find_idle_profile() {
  RESPONSE_CODE = $(curl -s -o /dev/null -w "%http_code") http://locahost/profile

  if [ "$RESPONSE_CODE" -ge 400 ]; # greater than 400 code
    then
      CURRENT_PROFILE=real2
    else
      CURRENT_PROFILE=$(curl -s http://localhost/profile)
  fi

  if [ "${CURRENT_PROFILE}" == real1 ]
    then
      IDLE_PROFILE=real2
    else
      IDLE_PROFILE=real1
  fi

  echo ${IDLE_PROFILE}

}

#쉬고 있는 profile 포트 찾
function find_idle_port() {
  IDLE_PROFILE=$(find_idle_profile)
  if[ "${IDLE_PROFILE}" == real1 ]
    then
      echo "8081"
    else
      echo "8082"
  fi
}