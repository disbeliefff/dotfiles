function sup --description "Update Google Secret Manager secret from a JSON file" --argument-names secret_name file_path
    if not set -q secret_name[1]; or not set -q file_path[1]
        echo "Usage: sup <secret-name> <file.json>"
        return 1
    end

    if not test -f $file_path
        echo "File not found: $file_path"
        return 1
    end

    set -l current (gcloud secrets versions access latest --secret="$secret_name" 2>/dev/null)

    echo "\n── Current value ──────────────────────────────────────────\n"
    if set -q current[1]
        echo $current | jq . 2>/dev/null; or echo $current
    else
        echo "(no current version)"
    end

    echo "\n── New value ─────────────────────────────────────────────\n"
    jq . $file_path 2>/dev/null; or cat $file_path

    echo "\n──────────────────────────────────────────────────────────"
    echo "  Secret: $secret_name"
    echo "  File:   $file_path"
    echo ""

    read -P "Push this version? [y/N]: " confirm
    if not contains -- $confirm y Y
        echo "Cancelled."
        return 0
    end

    echo ""
    gcloud secrets versions add "$secret_name" --data-file="$file_path"
end
