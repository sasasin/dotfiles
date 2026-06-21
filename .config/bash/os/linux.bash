
if grep -qiE "microsoft|wsl" /proc/sys/kernel/osrelease 2>/dev/null; then
    # WSL2 の場合
    :
else
    # WSL2 以外（ネイティブ Linux）の場合
    :
fi
