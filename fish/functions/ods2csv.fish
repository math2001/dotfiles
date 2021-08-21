function ods2csv
    libreoffice --convert-to-csv --outdir . "$1"
end
