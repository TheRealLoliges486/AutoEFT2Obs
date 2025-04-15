# EFT2Obs-Workflow

Clone the repo with the EFT2Obs submodule:
```
git clone --recursive git@github.com:TheRealLoliges486/AutoEFT2Obs.git
```

To create the snakemake environment (if not yet created):
```
mamba env create -n snakemake -f env.yaml
```

To source the environment do:
```
source env.sh
```

I assume that you have apptainer installed on your system. One could now run the snakemake command and it will internally pull the docker (converted by apptainer) container. However, I recommend pulling it with apptainer first
```
apptainer pull docker://charlotteknight/eft2obs:LO
```

To run the workflow first run:
```
 snakemake --sdm apptainer --apptainer-args "--writable-tmpfs -B /afs -B /cvmfs/cms.cern.ch -B /tmp -B /etc/sysconfig/ngbauth-submit -B ${XDG_RUNTIME_DIR} -B /eos --env KRB5CCNAME='FILE:${XDG_RUNTIME_DIR}/krb5cc' " -c 1
```

The `-c 1` tells snakemake to use one core. Specify a greater number if desired (it probably will be).

Run snakemake with `--profile htcondor` and without `-c 1`. 
```
snakemake --sdm apptainer --apptainer-args "--writable-tmpfs -B /afs -B /cvmfs/cms.cern.ch -B /tmp -B /etc/sysconfig/ngbauth-submit -B ${XDG_RUNTIME_DIR} -B /eos --env KRB5CCNAME='FILE:${XDG_RUNTIME_DIR}/krb5cc' " --profile htcondor
```