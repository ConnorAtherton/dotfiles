#!/usr/bin/env bash

# exec 3> /dev/stdout
# exec 1> /dev/null
# exec 2> /dev/null

# pushd "${PWD}" &&
#   trap 'popd' EXIT HUP INT QUIT TERM

# IFS=':' read -ra files <<< "${REPOS_FILES}"

# _failed() { print_red " ✗ Failed!\n"; }
# _succeed() { print_green " ✓ Succeed!\n"; }

# for file in "${files[@]}"; do
#   while IFS='|' read -r remote path; do
#     [ "${remote}" == "" ] && continue

#     path="${path//\$HOME/$HOME}"

#     if [ -d "${path}" ]; then
#       printc "Running '$*' in '${path}': "
#       pushd ${path}
#       if eval "$*"; then
#         _succeed
#       else
#         _failed
#       fi
#       popd
#     fi
#   done < "${file}"
# done
