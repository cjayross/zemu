QEMU_CONFIG=${QEMU_CONFIG:-$HOME/.config/qemu}
if [[ ! -d $QEMU_CONFIG ]]; then
    mkdir -p $QEMU_CONFIG
fi

_zemu() {
    local -a args
    args=(`ls -1 $QEMU_CONFIG | sed 's/\.conf//'`)
    compadd -a - args
}

zemu() {
    print_help() {
        echo 'usage: zemu [config]'
    }

    while [[ $1 =~ ^- && ! $1 == '--' ]]; do
        case $1 in
            --help | -h)
                print_help
                return 0
                ;;
            *)
                echo 'zemu: '$1': unknown option.'
                print_help
                return 1
                ;;
        esac
        shift
    done

    if (( $# == 0 )); then
        echo 'zemu: missing configuration.'
        exit 1
    elif (( $# > 1 )); then
        echo 'zemu: trailing arguments.'
        exit 1
    fi

    qemu-system-x86_64 -readconfig $QEMU_CONFIG'/'$1'.conf'
}

compdef _zemu zemu
