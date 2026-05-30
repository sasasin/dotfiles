# https://sasasin.hatenablog.com/entry/2026/05/17/000939
# Windows 11 の Git Bash で、TUI アプリケーションや端末制御を行うプログラムが
# 端末状態を壊したときに、Bash から手動で復旧できるようにするためのものです。
# 特に、通常の Linux/macOS 向けの復旧コマンドでは足りない Windows 固有の問題、
# つまり ENABLE_VIRTUAL_TERMINAL_INPUT が残る問題 まで面倒を見ているのがポイントです。
wincon-clear-vt-input() {
  case "$OSTYPE" in
    msys*|cygwin*|win32*)
      powershell.exe -NoProfile -ExecutionPolicy Bypass -Command '
        Add-Type -Namespace Win32 -Name NativeMethods -MemberDefinition @"
        [System.Runtime.InteropServices.DllImport("kernel32.dll")]
        public static extern System.IntPtr GetStdHandle(int nStdHandle);

        [System.Runtime.InteropServices.DllImport("kernel32.dll")]
        public static extern bool GetConsoleMode(System.IntPtr hConsoleHandle, out uint lpMode);

        [System.Runtime.InteropServices.DllImport("kernel32.dll")]
        public static extern bool SetConsoleMode(System.IntPtr hConsoleHandle, uint dwMode);
        "@

        $h = [Win32.NativeMethods]::GetStdHandle(-10)  # STD_INPUT_HANDLE
        [uint32]$mode = 0

        if ([Win32.NativeMethods]::GetConsoleMode($h, [ref]$mode)) {
          # ENABLE_VIRTUAL_TERMINAL_INPUT = 0x0200 を落とす
          [uint32]$newMode = $mode -band 0xFFFFFDFF
          [Win32.NativeMethods]::SetConsoleMode($h, $newMode) | Out-Null
        }
      ' >/dev/null 2>&1
      ;;
  esac
}
tty-soft-reset() {
  case "$OSTYPE" in
    msys*|cygwin*|win32*)
      stty sane 2>/dev/null
      printf '\033[?1l\033>\033[?25h\033[?1000l\033[?1002l\033[?1003l\033[?1006l\033[0m' > /dev/tty 2>/dev/null
      wincon-clear-vt-input
      ;;
  esac
}
