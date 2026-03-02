BASE_URL="https://zenodo.org/records/10043978/files"
FILE_PREFIX="covid_data.z"
DIR_PATH="/home/ec2-user/COVIDUK-DATASET"

for i in $(seq -w 1 24); do
  FILE="${FILE_PREFIX}${i}"
  URL="${BASE_URL}/${FILE}"

  echo "Downloading ${FILE}..."

  if ! wget -c -P "${DIR_PATH}" --spider "${URL}" 2>/dev/null; then
    echo "No more files found at ${FILE}. Stopping."
    break
  fi

  wget -c -P "${DIR_PATH}" "${URL}"
done