function su --description "Update GCP Secret Manager secret from a JSON file" --argument-names secret_name file_path
    if test -z "$secret_name"; or test -z "$file_path"
        echo "Usage: gcp-secret-update <secret-name> <file.json>"
        return 1
    end

    if not test -f "$file_path"
        echo "File not found: $file_path"
        return 1
    end

    echo ""
    echo "── Current value ──────────────────────────────────────────"
    echo ""
    gcloud secrets versions access latest --secret="$secret_name" 2>/dev/null | jq . 2>/dev/null; or gcloud secrets versions access latest --secret="$secret_name"
    echo ""
    echo "── New value ─────────────────────────────────────────────"
    echo ""
    jq . "$file_path" 2>/dev/null; or cat "$file_path"
    echo ""
    echo "──────────────────────────────────────────────────────────"
    echo "  Secret: $secret_name"
    echo "  File:   $file_path"
    echo ""

    read -P "Push this version? [y/N]: " confirm
    if test "$confirm" != "y"; and test "$confirm" != "Y"
        echo "Cancelled."
        return 0
    end

    echo ""
    gcloud secrets versions add "$secret_name" --data-file="$file_path"
end
