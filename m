Return-Path: <virtio-dev-return-8219-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DC2339863D7
	for <virtio-dev@lists.oasis-open.org>; Thu,  1 Jul 2021 08:43:02 +0000 (UTC)
From: Peter Hilber <peter.hilber@opensynergy.com>
References: <20210611165937.701-1-cristian.marussi@arm.com>
 <20210611165937.701-7-cristian.marussi@arm.com>
Message-ID: <039f1a64-b4b6-5274-1fff-253f1dd6eac8@opensynergy.com>
Date: Thu, 1 Jul 2021 10:42:56 +0200
In-Reply-To: <20210611165937.701-7-cristian.marussi@arm.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v4 06/16] firmware: arm_scmi, smccc, mailbox: Make shmem
 based transports optional
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
To: Cristian Marussi <cristian.marussi@arm.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: sudeep.holla@arm.com, james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com, etienne.carriere@linaro.org, vincent.guittot@linaro.org, souvik.chakravarty@arm.com, igor.skalkin@opensynergy.com, alex.bennee@linaro.org, jean-philippe@linaro.org, mikhail.golubev@opensynergy.com, anton.yakovlev@opensynergy.com, Vasyl.Vavrychuk@opensynergy.com, Andriy.Tryshnivskyy@opensynergy.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 11.06.21 18:59, Cristian Marussi wrote:
> From: Igor Skalkin <igor.skalkin@opensynergy.com>
>=20
> Upon adding the virtio transport in this patch series, SCMI will also
> work without shared memory based transports. Also, the mailbox transport
> may not be needed if the smc transport is used.
>=20
> - Compile shmem.c only if a shmem based transport is available.
>=20
> - Remove hard dependency of SCMI on mailbox.

The hard dependency has now already been removed with

   c05b07963e96 ("firmware: arm_scmi: Add SMCCC discovery dependency in")

>=20
> [ Peter: Adapted patch for submission to upstream. ]
>=20
> Co-developed-by: Peter Hilber <peter.hilber@opensynergy.com>
> Signed-off-by: Igor Skalkin <igor.skalkin@opensynergy.com>
> Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
> ---
>  drivers/firmware/Kconfig           | 8 +++++++-
>  drivers/firmware/arm_scmi/Makefile | 2 +-
>  drivers/firmware/arm_scmi/common.h | 2 ++
>  drivers/firmware/smccc/Kconfig     | 1 +
>  drivers/mailbox/Kconfig            | 1 +
>  5 files changed, 12 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index 1db738d5b301..358f895847b5 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -9,7 +9,7 @@ menu "Firmware Drivers"
>  config ARM_SCMI_PROTOCOL
>  =09tristate "ARM System Control and Management Interface (SCMI) Message =
Protocol"
>  =09depends on ARM || ARM64 || COMPILE_TEST
> -=09depends on MAILBOX || HAVE_ARM_SMCCC_DISCOVERY
> +=09depends on ARM_SCMI_HAVE_SHMEM
>  =09help
>  =09  ARM System Control and Management Interface (SCMI) protocol is a
>  =09  set of operating system-independent software interfaces that are
> @@ -27,6 +27,12 @@ config ARM_SCMI_PROTOCOL
>  =09  This protocol library provides interface for all the client drivers
>  =09  making use of the features offered by the SCMI.
> =20
> +config ARM_SCMI_HAVE_SHMEM
> +=09bool
> +=09help
> +=09  This declares whether a shared memory based transport for SCMI is
> +=09  available.
> +
>  config ARM_SCMI_POWER_DOMAIN
>  =09tristate "SCMI power domain driver"
>  =09depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
> diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_sc=
mi/Makefile
> index 6a2ef63306d6..5a2d4c32e0ae 100644
> --- a/drivers/firmware/arm_scmi/Makefile
> +++ b/drivers/firmware/arm_scmi/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  scmi-bus-y =3D bus.o
>  scmi-driver-y =3D driver.o notify.o
> -scmi-transport-y =3D shmem.o
> +scmi-transport-$(CONFIG_ARM_SCMI_HAVE_SHMEM) =3D shmem.o
>  scmi-transport-$(CONFIG_MAILBOX) +=3D mailbox.o
>  scmi-transport-$(CONFIG_HAVE_ARM_SMCCC_DISCOVERY) +=3D smc.o
>  scmi-protocols-y =3D base.o clock.o perf.o power.o reset.o sensors.o sys=
tem.o voltage.o
> diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_sc=
mi/common.h
> index 0edc04bc434c..4666777019fa 100644
> --- a/drivers/firmware/arm_scmi/common.h
> +++ b/drivers/firmware/arm_scmi/common.h
> @@ -375,7 +375,9 @@ struct scmi_desc {
>  =09bool support_xfers_delegation;
>  };
> =20
> +#ifdef CONFIG_MAILBOX
>  extern const struct scmi_desc scmi_mailbox_desc;
> +#endif
>  #ifdef CONFIG_HAVE_ARM_SMCCC_DISCOVERY
>  extern const struct scmi_desc scmi_smc_desc;
>  #endif
> diff --git a/drivers/firmware/smccc/Kconfig b/drivers/firmware/smccc/Kcon=
fig
> index 15e7466179a6..69c4d6cabf62 100644
> --- a/drivers/firmware/smccc/Kconfig
> +++ b/drivers/firmware/smccc/Kconfig
> @@ -9,6 +9,7 @@ config HAVE_ARM_SMCCC_DISCOVERY
>  =09bool
>  =09depends on ARM_PSCI_FW
>  =09default y
> +=09select ARM_SCMI_HAVE_SHMEM
>  =09help
>  =09 SMCCC v1.0 lacked discoverability and hence PSCI v1.0 was updated
>  =09 to add SMCCC discovery mechanism though the PSCI firmware
> diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
> index 68de2c6af727..fc02c38c0739 100644
> --- a/drivers/mailbox/Kconfig
> +++ b/drivers/mailbox/Kconfig
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  menuconfig MAILBOX
>  =09bool "Mailbox Hardware Support"
> +=09select ARM_SCMI_HAVE_SHMEM
>  =09help
>  =09  Mailbox is a framework to control hardware communication between
>  =09  on-chip processors through queued messages and interrupt driven
>=20




---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

