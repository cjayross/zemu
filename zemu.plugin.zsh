typeset -gx QEMU_CONFIG=${QEMU_CONFIG:-$HOME/.config/qemu}

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
    fi

    local config=$QEMU_CONFIG'/'$1'.conf'
    local filtered_config=`mktemp /tmp/$1.XXXXXX`
    shift
    cat $config | sed 's/$QEMU/'${QEMU//\//\\\/}'/g' > $filtered_config
    qemu-system-x86_64 -readconfig $filtered_config $*
    rm $filtered_config
}

compdef _zemu zemu
