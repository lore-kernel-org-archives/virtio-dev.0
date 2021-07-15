Return-Path: <virtio-dev-return-8293-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CAFB99864BC
	for <virtio-dev@lists.oasis-open.org>; Thu, 15 Jul 2021 16:35:54 +0000 (UTC)
References: <20210712141833.6628-1-cristian.marussi@arm.com>
From: Peter Hilber <peter.hilber@opensynergy.com>
Message-ID: <314d75d6-ae5c-6aaf-b796-a424c195aee4@opensynergy.com>
Date: Thu, 15 Jul 2021 18:35:38 +0200
In-Reply-To: <20210712141833.6628-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v6 00/17] Introduce SCMI transport based on VirtIO
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
To: Cristian Marussi <cristian.marussi@arm.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: sudeep.holla@arm.com, james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com, etienne.carriere@linaro.org, vincent.guittot@linaro.org, souvik.chakravarty@arm.com, igor.skalkin@opensynergy.com, alex.bennee@linaro.org, jean-philippe@linaro.org, mikhail.golubev@opensynergy.com, anton.yakovlev@opensynergy.com, Vasyl.Vavrychuk@opensynergy.com, Andriy.Tryshnivskyy@opensynergy.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 12.07.21 16:18, Cristian Marussi wrote:
> Hi all,
>=20

Hi Cristian,

thanks for your update. Please find some additional comments in this=20
reply and the following.

Best regards,

Peter

> While reworking this series starting from the work done up to V3 by
> OpenSynergy, I am keeping the original autorship and list distribution
> unchanged.
>=20
> The main aim of this rework, as said, is to simplify where possible the
> SCMI VirtIO support added in V3 by adding at first some new general
> mechanisms in the SCMI Transport layer.
>=20
> Indeed, after some initial small fixes, patches 05/06/07/08 add such new
> additional mechanisms to the SCMI core to ease implementation of more
> complex transports like virtio, while also addressing a few general issue=
s
> already potentially affecting existing transports.
>=20
> In terms of rework I dropped original V3 patches 05/06/07/08/12 as no mor=
e
> needed, and modified where needed the remaining original patches to take
> advantage of the above mentioned new SCMI transport features.
>=20
> DT bindings patch has been ported on top of freshly YAML converted arm,sc=
mi
> bindings.
>=20
> Moreover, since V5 I dropped support for polling mode from the virtio-scm=
i
> transport, since it is an optional general mechanism provided by the core
> to allow transports lacking a completion IRQ to work and it seemed a
> needless addition/complication in the context of virtio transport.
>=20

Just for correctness, in my understanding polling is not completely=20
optional ATM. Polling would be required by scmi_cpufreq_fast_switch().=20
But that requirement might be irrelevant for now.

> Additionally, in V5 I could also simplify a bit the virtio transport
> probing sequence starting from the observation that, by the VirtIO spec,
> in fact, only one single SCMI VirtIO device can possibly exist on a syste=
m.
>=20

I wouldn't say that the virtio spec restricts the # of virtio-scmi=20
devices to one. But I do think the one device limitation in the kernel=20
is acceptable.

> The series has been tested using an emulated fake SCMI device and also a
> proper SCP-fw stack running through QEMU vhost-users, with the SCMI stack
> compiled, in both cases, as builtin and as a loadable module, running tes=
ts
> against mocked SCMI Sensors using HWMON and IIO interfaces to check the
> functionality of notifications and sync/async commands.
>=20
> Virtio-scmi support has been exercised in the following testing scenario
> on a JUNO board:
>=20
>   - normal sync/async command transfers
>   - notifications
>   - concurrent delivery of correlated response and delayed responses
>   - out-of-order delivery of delayed responses before related responses
>   - unexpected delayed response delivery for sync commands
>   - late delivery of timed-out responses and delayed responses
>=20
> Some basic regression testing against mailbox transport has been performe=
d
> for commands and notifications too.
>=20
> No sensible overhead in total handling time of commands and notifications
> has been observed, even though this series do indeed add a considerable
> amount of code to execute on TX path.
> More test and measurements could be needed in these regards.
>=20
> This series is based on top of v5.14-rc1.
>=20
> Any feedback/testing is welcome :D
>=20
> Thanks,
> Cristian
> ---
> V5 --> V6:
>   - removed delegated xfers and its usage
>   - add and use *priv optional parameter in scmi_rx_callback()
>   - made .poll_done and .clear_channel ops optional
>=20
> V4 --> V5:
>   - removed msg raw_payload helpers
>   - reworked msg helpers to use xfer->priv reference
>   - simplified SCMI device probe sequence (one static device)
>   - added new SCMI Kconfig layout
>   - removed SCMI virtio polling support
>=20
> V3 --> V4:
>   - using new delegated xfers support and monotonically increasing tokens
>     in virtio transport
>   - ported SCMI virtio transport DT bindings to YAML format
>   - added virtio-scmi polling support
>   - added delegated xfers support
>=20
> Cristian Marussi (11):
>    firmware: arm_scmi: Avoid padding in sensor message structure
>    firmware: arm_scmi: Fix max pending messages boundary check
>    firmware: arm_scmi: Add support for type handling in common functions
>    firmware: arm_scmi: Remove scmi_dump_header_dbg() helper
>    firmware: arm_scmi: Add transport optional init/exit support
>    firmware: arm_scmi: Introduce monotonically increasing tokens
>    firmware: arm_scmi: Handle concurrent and out-of-order messages
>    firmware: arm_scmi: Add priv parameter to scmi_rx_callback
>    firmware: arm_scmi: Make .clear_channel optional
>    firmware: arm_scmi: Make polling mode optional
>    firmware: arm_scmi: Make SCMI transports configurable
>=20
> Igor Skalkin (4):
>    firmware: arm_scmi: Make shmem support optional for transports
>    firmware: arm_scmi: Add method to override max message number
>    dt-bindings: arm: Add virtio transport for SCMI
>    firmware: arm_scmi: Add virtio transport
>=20
> Peter Hilber (2):
>    firmware: arm_scmi: Add message passing abstractions for transports
>    firmware: arm_scmi: Add optional link_supplier() transport op
>=20
>   .../bindings/firmware/arm,scmi.yaml           |   8 +-
>   MAINTAINERS                                   |   1 +
>   drivers/firmware/Kconfig                      |  34 +-
>   drivers/firmware/arm_scmi/Kconfig             |  97 +++
>   drivers/firmware/arm_scmi/Makefile            |   8 +-
>   drivers/firmware/arm_scmi/common.h            |  94 ++-
>   drivers/firmware/arm_scmi/driver.c            | 651 +++++++++++++++---
>   drivers/firmware/arm_scmi/mailbox.c           |   2 +-
>   drivers/firmware/arm_scmi/msg.c               | 113 +++
>   drivers/firmware/arm_scmi/sensors.c           |   6 +-
>   drivers/firmware/arm_scmi/smc.c               |   3 +-
>   drivers/firmware/arm_scmi/virtio.c            | 491 +++++++++++++
>   include/uapi/linux/virtio_ids.h               |   1 +
>   include/uapi/linux/virtio_scmi.h              |  24 +
>   14 files changed, 1389 insertions(+), 144 deletions(-)
>   create mode 100644 drivers/firmware/arm_scmi/Kconfig
>   create mode 100644 drivers/firmware/arm_scmi/msg.c
>   create mode 100644 drivers/firmware/arm_scmi/virtio.c
>   create mode 100644 include/uapi/linux/virtio_scmi.h
>=20


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

