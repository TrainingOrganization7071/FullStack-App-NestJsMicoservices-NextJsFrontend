#########################################################################################
#########################################################################################
#########################################################################################
#  discover_services_from_json:
#    name: Find out all the microservies from json file
#    runs-on: ubuntu-latest
#    outputs:
#      environments: ${{ steps.load_services.outputs.services }}
#      changed_microservices: ${{ steps.detect_changes.outputs.changed_microservices }}
#
#    steps:
#      - name: Checkout repository
#        uses: actions/checkout@v4
#        with:
#          fetch-depth: 0  # Fetch full commit history, not a shallow clone
#
#      # Load microservices names from JSON
#      - name: Load microservices from JSON
#        id: load_services
#        run: |
#          services=$(jq -r '.microservices[] | .name' ./.github/workflows/microservices.json | paste -sd "," -)
#          # Output values as single-line strings
#          echo "Services: $services"
#          echo "services=$services" >> $GITHUB_OUTPUT
#
#      # Load microservices names from JSON -> return array
#      # Detect changed microservices
#      - name: Detect changed microservices
#        id: detect_changes
#        run: |
#          services=$(jq -r '.microservices[] | .name' ./.github/workflows/microservices.json)
#          changed_services=()
#          for service in $services; do
#            if git diff --name-only HEAD^ HEAD | grep -q "^services/$service/"; then
#              changed_services+=("\"$service\"")
#            fi
#          done
#          # Format changed_microservices as a JSON array
#          if [ ${#changed_services[@]} -eq 0 ]; then
#            json_output="[]"
#          else
#            json_output=$(IFS=,; echo "[${changed_services[*]}]")
#          fi
#          echo "changed_microservices=$json_output" >> $GITHUB_OUTPUT
#
#      - name: Debug changed_microservices output
#        run: |
#          echo "Changed microservices: ${{ steps.detect_changes.outputs.changed_microservices }}"
#########################################################################################
#########################################################################################
#########################################################################################
