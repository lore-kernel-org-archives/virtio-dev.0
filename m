Return-Path: <virtio-dev-return-8296-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 550E19864BC
	for <virtio-dev@lists.oasis-open.org>; Thu, 15 Jul 2021 16:36:32 +0000 (UTC)
References: <20210712141833.6628-1-cristian.marussi@arm.com>
 <20210712141833.6628-15-cristian.marussi@arm.com>
From: Peter Hilber <peter.hilber@opensynergy.com>
Message-ID: <853e757b-1048-1528-7f61-63a482e06458@opensynergy.com>
Date: Thu, 15 Jul 2021 18:36:26 +0200
In-Reply-To: <20210712141833.6628-15-cristian.marussi@arm.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v6 14/17] firmware: arm_scmi: Add message passing
 abstractions for transports
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
To: Cristian Marussi <cristian.marussi@arm.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: sudeep.holla@arm.com, james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com, etienne.carriere@linaro.org, vincent.guittot@linaro.org, souvik.chakravarty@arm.com, igor.skalkin@opensynergy.com, alex.bennee@linaro.org, jean-philippe@linaro.org, mikhail.golubev@opensynergy.com, anton.yakovlev@opensynergy.com, Vasyl.Vavrychuk@opensynergy.com, Andriy.Tryshnivskyy@opensynergy.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 12.07.21 16:18, Cristian Marussi wrote:
> From: Peter Hilber <peter.hilber@opensynergy.com>
>=20
> Add abstractions for future transports using message passing, such as
> virtio. Derive the abstractions from the shared memory abstractions.
>=20
> Abstract the transport SDU through the opaque struct scmi_msg_payld.
> Also enable the transport to determine all other required information
> about the transport SDU.
>=20
> Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
> [ Cristian: Adapted to new SCMI Kconfig layout, updated Copyrigths ]
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> v4 --> v5
> - adapted to new SCMI Kconfig
> - removed raw_payload msg helpers
> v3 --> v4
> - added raw_payload msg helpers
> ---
>   drivers/firmware/arm_scmi/Kconfig  |   6 ++
>   drivers/firmware/arm_scmi/Makefile |   1 +
>   drivers/firmware/arm_scmi/common.h |  15 ++++
>   drivers/firmware/arm_scmi/msg.c    | 113 +++++++++++++++++++++++++++++
>   4 files changed, 135 insertions(+)
>   create mode 100644 drivers/firmware/arm_scmi/msg.c
>=20
> diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scm=
i/Kconfig
> index ee6517b24080..1fdaa8ad7d3f 100644
> --- a/drivers/firmware/arm_scmi/Kconfig
> +++ b/drivers/firmware/arm_scmi/Kconfig
> @@ -34,6 +34,12 @@ config ARM_SCMI_HAVE_SHMEM
>   =09  This declares whether a shared memory based transport for SCMI is
>   =09  available.
>  =20
> +config ARM_SCMI_HAVE_MSG
> +=09bool
> +=09help
> +=09  This declares whether a message passing based transport for SCMI is
> +=09  available.
> +
>   config ARM_SCMI_TRANSPORT_MAILBOX
>   =09bool "SCMI transport based on Mailbox"
>   =09depends on ARM_SCMI_PROTOCOL && MAILBOX
> diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_sc=
mi/Makefile
> index e0e6bd3dba9e..aaad9f6589aa 100644
> --- a/drivers/firmware/arm_scmi/Makefile
> +++ b/drivers/firmware/arm_scmi/Makefile
> @@ -4,6 +4,7 @@ scmi-driver-y =3D driver.o notify.o
>   scmi-transport-$(CONFIG_ARM_SCMI_HAVE_SHMEM) =3D shmem.o
>   scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_MAILBOX) +=3D mailbox.o
>   scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_SMC) +=3D smc.o
> +scmi-transport-$(CONFIG_ARM_SCMI_HAVE_MSG) +=3D msg.o
>   scmi-protocols-y =3D base.o clock.o perf.o power.o reset.o sensors.o sy=
stem.o voltage.o
>   scmi-module-objs :=3D $(scmi-bus-y) $(scmi-driver-y) $(scmi-protocols-y=
) \
>   =09=09    $(scmi-transport-y)
> diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_sc=
mi/common.h
> index 14457f0d5dea..7a1e84dc191b 100644
> --- a/drivers/firmware/arm_scmi/common.h
> +++ b/drivers/firmware/arm_scmi/common.h
> @@ -415,6 +415,21 @@ void shmem_clear_channel(struct scmi_shared_mem __io=
mem *shmem);
>   bool shmem_poll_done(struct scmi_shared_mem __iomem *shmem,
>   =09=09     struct scmi_xfer *xfer);
>  =20
> +/* declarations for message passing transports */
> +struct scmi_msg_payld;
> +
> +/* Maximum overhead of message w.r.t. struct scmi_desc.max_msg_size */
> +#define SCMI_MSG_MAX_PROT_OVERHEAD (2 * sizeof(__le32))
> +
> +size_t msg_response_size(struct scmi_xfer *xfer);
> +size_t msg_command_size(struct scmi_xfer *xfer);
> +void msg_tx_prepare(struct scmi_msg_payld *msg, struct scmi_xfer *xfer);
> +u32 msg_read_header(struct scmi_msg_payld *msg);
> +void msg_fetch_response(struct scmi_msg_payld *msg, size_t len,
> +=09=09=09struct scmi_xfer *xfer);
> +void msg_fetch_notification(struct scmi_msg_payld *msg, size_t len,
> +=09=09=09    size_t max_len, struct scmi_xfer *xfer);
> +
>   void scmi_notification_instance_data_set(const struct scmi_handle *hand=
le,
>   =09=09=09=09=09 void *priv);
>   void *scmi_notification_instance_data_get(const struct scmi_handle *han=
dle);
> diff --git a/drivers/firmware/arm_scmi/msg.c b/drivers/firmware/arm_scmi/=
msg.c
> new file mode 100644
> index 000000000000..639969b7dc10
> --- /dev/null
> +++ b/drivers/firmware/arm_scmi/msg.c
> @@ -0,0 +1,113 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * For transports using message passing.
> + *
> + * Derived from shm.c.
> + *
> + * Copyright (C) 2019-2021 ARM Ltd.
> + * Copyright (C) 2020-2021 OpenSynergy GmbH
> + */
> +
> +#include <linux/io.h>
> +#include <linux/processor.h>

The above two includes appear to be unnecessary.

> +#include <linux/types.h>
> +
> +#include "common.h"
> +
> +/*
> + * struct scmi_msg_payld - Transport SDU layout
> + *
> + * The SCMI specification requires all parameters, message headers, retu=
rn
> + * arguments or any protocol data to be expressed in little endian forma=
t only.
> + */
> +struct scmi_msg_payld {
> +=09__le32 msg_header;
> +=09__le32 msg_payload[];
> +};
> +
> +/**
> + * msg_command_size() - Actual size of transport SDU for command.
> + *
> + * @xfer: message which core has prepared for sending
> + *
> + * Return: transport SDU size.
> + */
> +size_t msg_command_size(struct scmi_xfer *xfer)
> +{
> +=09return sizeof(struct scmi_msg_payld) + xfer->tx.len;
> +}
> +
> +/**
> + * msg_response_size() - Maximum size of transport SDU for response.
> + *
> + * @xfer: message which core has prepared for sending
> + *
> + * Return: transport SDU size.
> + */
> +size_t msg_response_size(struct scmi_xfer *xfer)
> +{
> +=09return sizeof(struct scmi_msg_payld) + sizeof(__le32) + xfer->rx.len;
> +}
> +
> +/**
> + * msg_tx_prepare() - Set up transport SDU for command.
> + *
> + * @msg: transport SDU for command
> + * @xfer: message which is being sent
> + */
> +void msg_tx_prepare(struct scmi_msg_payld *msg, struct scmi_xfer *xfer)
> +{
> +=09msg->msg_header =3D cpu_to_le32(pack_scmi_header(&xfer->hdr));
> +=09if (xfer->tx.buf)
> +=09=09memcpy(msg->msg_payload, xfer->tx.buf, xfer->tx.len);
> +}
> +
> +/**
> + * msg_read_header() - Read SCMI header from transport SDU.
> + *
> + * @msg: transport SDU
> + *
> + * Return: SCMI header
> + */
> +u32 msg_read_header(struct scmi_msg_payld *msg)
> +{
> +=09return le32_to_cpu(msg->msg_header);
> +}
> +
> +/**
> + * msg_fetch_response() - Fetch response SCMI payload from transport SDU=
.
> + *
> + * @msg: transport SDU with response
> + * @len: transport SDU size
> + * @xfer: message being responded to
> + */
> +void msg_fetch_response(struct scmi_msg_payld *msg, size_t len,
> +=09=09=09struct scmi_xfer *xfer)
> +{
> +=09size_t prefix_len =3D sizeof(*msg) + sizeof(msg->msg_payload[0]);
> +
> +=09xfer->hdr.status =3D le32_to_cpu(msg->msg_payload[0]);
> +=09xfer->rx.len =3D min_t(size_t, xfer->rx.len,
> +=09=09=09     len >=3D prefix_len ? len - prefix_len : 0);
> +
> +=09/* Take a copy to the rx buffer.. */
> +=09memcpy(xfer->rx.buf, &msg->msg_payload[1], xfer->rx.len);
> +}
> +
> +/**
> + * msg_fetch_notification() - Fetch notification payload from transport =
SDU.
> + *
> + * @msg: transport SDU with notification
> + * @len: transport SDU size
> + * @max_len: maximum SCMI payload size to fetch
> + * @xfer: notification message
> + */
> +void msg_fetch_notification(struct scmi_msg_payld *msg, size_t len,
> +=09=09=09    size_t max_len, struct scmi_xfer *xfer)
> +{
> +=09xfer->rx.len =3D min_t(size_t, max_len,
> +=09=09=09     len >=3D sizeof(*msg) ? len - sizeof(*msg) : 0);
> +
> +=09/* Take a copy to the rx buffer.. */
> +=09memcpy(xfer->rx.buf, msg->msg_payload, xfer->rx.len);
> +}
>=20


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

