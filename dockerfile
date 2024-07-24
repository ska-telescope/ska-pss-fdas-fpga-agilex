FROM ubuntu:22.04 as init

RUN apt-get -y update

WORKDIR /quartus/22.4

RUN cd /mnt/synvol1/gitlab-runner/quartus/22.4/components/ && ls

COPY //mnt/synvol1/gitlab-runner/quartus/22.4/components/QuartusProSetup-22.4.0.94-linux.run .
COPY //mnt/synvol1/gitlab-runner/quartus/22.4/components/quartus_part2-22.4.0.94-linux.qdz .
COPY //mnt/synvol1/gitlab-runner/quartus/22.4/components/agilex-22.4.0.94.qdz .

RUN ./QuartusProSetup-22.4.0.94-linux.run --mode unattended --installdir . --accept_eula 1

FROM ubuntu:22.04

RUN apt-get -y update

WORKDIR /quartus/22.4

RUN mkdir quartus && mkdir trialLicense

COPY --from=init quartus/22.4/devdata devdata
COPY --from=init quartus/22.4/ip ip
COPY --from=init quartus/22.4/qsys qsys
COPY --from=init quartus/22.4/quartus/adm quartus/adm
COPY --from=init quartus/22.4/quartus/bin quartus/bin
COPY --from=init quartus/22.4/quartus/common quartus/common
COPY --from=init quartus/22.4/quartus/dspba quartus/dspba
COPY --from=init quartus/22.4/quartus/extlibs32 quartus/extlibs32
COPY --from=init quartus/22.4/quartus/libraries quartus/libraries
COPY --from=init quartus/22.4/quartus/linux64 quartus/linux64
COPY --from=init quartus/22.4/quartus/lmf quartus/lmf
COPY --from=init quartus/22.4/quartus/../qsys qsys
COPY --from=init quartus/22.4/quartus/readme.txt quartus
COPY --from=init quartus/22.4/quartus/sopc_builder quartus/sopc_builder
COPY --from=init quartus/22.4/quartus/version.txt quartus
COPY /trialLicense trialLicense

RUN apt-get install -y libglib2.0-0 libncurses5

ENV PATH=/quartus/22.4/quartus/bin:$PATH

ENV LM_LICENSE_FILE=/quartus/22.4/trialLicense/LR-173882_License.dat