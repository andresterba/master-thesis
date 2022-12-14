# master-thesis

## Requirements

A Linux machine with the following tools installed:

- make
- [docker](https://docs.docker.com/engine/install/)
- [containerlab](https://containerlab.dev/install/)
- [gnmic](https://gnmic.kmrd.dev/)
- [postman](https://www.postman.com/)
- [cEOS container](https://containerlab.dev/manual/kinds/ceos/)

Download the cEOS image from Arista and save it in your local registry.
Then replace the used image in `evaluation.yaml` `registry.code.fbi.h-da.de/danet/containers/ceos:4.28.0F`
with the name you gave your local image.
You can follow the excellent [documentation](https://containerlab.dev/manual/kinds/ceos/) from containerlab.


## Getting started

The evaluation for the routing engine can be found [here](./docs/evaluation-1.md).

The evaluation for the hostname checker can be found [here](./docs/evaluation-2.md).

## GoSDN License

All binaries follow the goSDN license provided [here](https://code.fbi.h-da.de/danet/gosdn/-/blob/master/controller/LICENSE).
