# ****************************************************************************************
# curl -s "https://laravel.build/laravel-sail-app?with=mysql,mailpit" | bash
# で実行すべきものだが、
# 次期によって内容かわるかもしれません
# 2026/02/06時点において
# curl -s "https://laravel.build/laravel-sail-app?with=mysql,mailpit" > laravel-sail-app-init.sh
# をして、laravel-sail-app-init.sh として保存することにしました。
# そうやって保存したのがこのファイルです
# その後、先頭部分に当コメントを追記しました。
# ****************************************************************************************

docker info > /dev/null 2>&1

# Ensure that Docker is running...
if [ $? -ne 0 ]; then
    echo "Docker is not running."

    exit 1
fi

docker run --rm \
    --pull=always \
    -v "$(pwd)":/opt \
    -w /opt \
    laravelsail/php84-composer:latest \
    bash -c "laravel new laravel-sail-app --no-interaction && cd laravel-sail-app && php ./artisan sail:install --with=mysql,mailpit "

cd laravel-sail-app

# Allow build with no additional services..
if [ "mysql mailpit" == "none" ]; then
    ./vendor/bin/sail build
else
    ./vendor/bin/sail pull mysql mailpit
    ./vendor/bin/sail build
fi

CYAN='\033[0;36m'
LIGHT_CYAN='\033[1;36m'
BOLD='\033[1m'
NC='\033[0m'

echo ""

if command -v doas &>/dev/null; then
    SUDO="doas"
elif command -v sudo &>/dev/null; then
    SUDO="sudo"
else
    echo "Neither sudo nor doas is available. Exiting."
    exit 1
fi

if $SUDO -n true 2>/dev/null; then
    $SUDO chown -R $USER: .
    echo -e "${BOLD}Get started with:${NC} cd laravel-sail-app && ./vendor/bin/sail up"
else
    echo -e "${BOLD}Please provide your password so we can make some final adjustments to your application's permissions.${NC}"
    echo ""
    $SUDO chown -R $USER: .
    echo ""
    echo -e "${BOLD}Thank you! We hope you build something incredible. Dive in with:${NC} cd laravel-sail-app && ./vendor/bin/sail up"
fi
