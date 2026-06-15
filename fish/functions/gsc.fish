function gsc --description "Create Google Secret Manager secret, optionally from a JSON file" --argument-names secret_name file_path
    if not set -q secret_name[1]
        echo "Usage: gsc <secret-name> [file.json]"
        echo "Example: gsc dev_App-config ./config.json"
        return 1
    end

    if set -q file_path[1]
        if not test -f "$file_path"
            echo "File not found: $file_path"
            return 1
        end

        if not jq empty "$file_path" 2>/dev/null
            echo "Invalid JSON: $file_path"
            return 1
        end

        echo "\n-- Secret value ------------------------------------------------\n"
        jq . "$file_path"

        echo "\n----------------------------------------------------------------"
        echo "  Secret: $secret_name"
        echo "  File:   $file_path"
        echo ""

        read -P "Create secret with this JSON value? [y/N]: " confirm
        if not contains -- "$confirm" y Y
            echo "Cancelled."
            return 0
        end

        echo ""
        gcloud secrets create "$secret_name" --data-file="$file_path"
        return $status
    end

    read -P "Create empty secret '$secret_name'? [y/N]: " confirm
    if not contains -- "$confirm" y Y
        echo "Cancelled."
        return 0
    end

    gcloud secrets create "$secret_name"
end
