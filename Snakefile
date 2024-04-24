container:
  "docker://charlotteknight/eft2obs"

rule collect:
  input:
    "gridpack"

rule setup_process:
  output:
    "procs/zh-HEL/index.html"
  shell:
    """
    set +u
    source /eft2obs/env.sh
    export PATH=${{PATH}}:/eft2obs/scripts
    export EFT2OBS_DIR=/eft2obs
    export PROC_DIR=$(pwd)/procs
    export CARDS_DIR=$(pwd)/cards

    setup_process.sh zh-HEL
    """

rule make_config:
  input:
    "procs/zh-HEL/index.html"
  output:
    "config_HEL_STXS.json"
  shell:
    """
    set +u
    source /eft2obs/env.sh
    export PATH=${{PATH}}:/eft2obs/scripts
    export EFT2OBS_DIR=/eft2obs
    export PROC_DIR=$(pwd)/procs
    export CARDS_DIR=$(pwd)/cards

    make_config.py -p zh-HEL -o config_HEL_STXS.json --pars newcoup:4,5,6,7,8,9,10,11,12 --def-val 0.01 --def-sm 0.0 --def-gen 0.0
    """

rule make_param_card:
  input:
    "config_HEL_STXS.json"
  output:
    "cards/zh-HEL/param_card.dat"
  shell:
    """
    set +u
    source /eft2obs/env.sh
    export PATH=${{PATH}}:/eft2obs/scripts
    export EFT2OBS_DIR=/eft2obs
    export PROC_DIR=$(pwd)/procs
    export CARDS_DIR=$(pwd)/cards

    make_param_card.py -p zh-HEL -c config_HEL_STXS.json -o cards/zh-HEL/param_card.dat
    """

rule make_reweight_card:
  input:
    "config_HEL_STXS.json"
  output:
    "cards/zh-HEL/reweight_card.dat"
  shell:
    """
    set +u
    source /eft2obs/env.sh
    export PATH=${{PATH}}:/eft2obs/scripts
    export EFT2OBS_DIR=/eft2obs
    export PROC_DIR=$(pwd)/procs
    export CARDS_DIR=$(pwd)/cards

    make_reweight_card.py config_HEL_STXS.json cards/zh-HEL/reweight_card.dat
    """

rule make_gridpack:
  input:
    "procs/zh-HEL/index.html",
    "cards/zh-HEL/param_card.dat",
    "cards/zh-HEL/reweight_card.dat"
  output:
    "gridpack"
  shell:
    """
    set +u
    source /eft2obs/env.sh
    export PATH=${{PATH}}:/eft2obs/scripts
    export EFT2OBS_DIR=/eft2obs
    export PROC_DIR=$(pwd)/procs
    export CARDS_DIR=$(pwd)/cards

    make_gridpack.sh zh-HEL
    """