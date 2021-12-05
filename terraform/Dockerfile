FROM alpine:3.14

Maintainer lmgsaenz
  


ENV ARCH="darwin_arm64"                                                                                                           \
  TERRAFORM_URL="https://releases.hashicorp.com/terraform"                                                                        \
  TERRAFORM_VER="1.0."

RUN apk add --no-cache --virtual .build-deps curl jq unzip outils-sha256                                                          \
  && TERRAFORM_VERSION=$(                                                                                                         \
    curl -H 'accept: Application/json' https://api.github.com/repos/hashicorp/terraform/tags |                                    \
    jq '.[].name | select ( . | contains("'${TERRAFORM_VERSION}'"))' | grep -ve alpha -ve beta -ve rc | awk 'FNR==1' | tr -d '"v' \
  )                                                                                                                               \
  && curl -sO ${TERRAFORM_URL}/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_${ARCH}.zip                                    \
  && curl -s ${TERRAFORM_URL}/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_SHA256SUMS -o terraform_sha256                  \
  && TERRAFORM_SHA256=$(cat terraform_sha256 | grep terraform_${TERRAFORM_VERSION}_${ARCH} | cut -d " " -f 1)                     \
  && echo "$TERRAFORM_SHA256  terraform_${TERRAFORM_VERSION}_${ARCH}.zip" | sha256sum -c -                                        \
  && unzip terraform_${TERRAFORM_VERSION}_${ARCH}.zip -d /usr/bin                                                                 \
  && rm -rf terraform_${TERRAFORM_VERSION}_${ARCH}.zip terraform_sha256 /var/cache/apk/*                                          \
  && apk del .build-deps
