Return-Path: <virtio-dev-return-8469-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4E8369863C5
	for <virtio-dev@lists.oasis-open.org>; Tue,  3 Aug 2021 13:11:02 +0000 (UTC)
From: Cristian Marussi <cristian.marussi@arm.com>
Date: Tue,  3 Aug 2021 14:10:09 +0100
Message-Id: <20210803131024.40280-1-cristian.marussi@arm.com>
Subject: [virtio-dev] [PATCH v7 00/15] Introduce SCMI transport based on VirtIO
Content-Type: text/plain; charset="US-ASCII"
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: sudeep.holla@arm.com, james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com, etienne.carriere@linaro.org, vincent.guittot@linaro.org, souvik.chakravarty@arm.com, cristian.marussi@arm.com, igor.skalkin@opensynergy.com, peter.hilber@opensynergy.com, alex.bennee@linaro.org, jean-philippe@linaro.org, mikhail.golubev@opensynergy.com, anton.yakovlev@opensynergy.com, Vasyl.Vavrychuk@opensynergy.com, Andriy.Tryshnivskyy@opensynergy.com
List-ID: <virtio-dev.lists.oasis-open.org>

Hi all,

While reworking this series starting from the work done up to V3 by
OpenSynergy, I am keeping the original autorship and list distribution
unchanged.

The main aim of this rework, as said, is to simplify where possible the
SCMI VirtIO support added in V3 by adding at first some new general
mechanisms in the SCMI Transport layer.

Indeed, after some initial small fixes, patches 03/04/05 add such new
additional mechanisms to the SCMI core to ease implementation of more
complex transports like virtio, while also addressing a few general issues
already potentially affecting existing transports.

In terms of rework I dropped original V3 patches 05/06/07/08/12 as no more
needed, and modified where needed the remaining original patches to take
advantage of the above mentioned new SCMI transport features.

DT bindings patch has been ported on top of freshly YAML converted arm,scmi
bindings.

Moreover, since V5 I dropped support for polling mode from the virtio-scmi
transport, since it is an optional general mechanism provided by the core
to allow transports lacking a completion IRQ to work and it seemed a
needless addition/complication in the context of virtio transport.

Additionally, since V5 I simplified a bit the virtio-scmi transport probing
sequence observing that, as of now, only one single SCMI VirtIO device can
be possibly used, since the SCMI VirtIO devices are not identifiable from
the VirtIO layer and neither they are currently identifiable from the DT
config; as a consequence only one single SCMI transport channel is
currently supported when using virtio-scmi transport.

The series has been tested using an emulated fake SCMI device and also a
proper SCP-fw SCMI stack running through QEMU vhost-users, with the SCMI
stack compiled, in both cases, as builtin and as a loadable module, running
tests against mocked SCMI Sensors using HWMON and IIO interfaces to check
the functionality of notifications and sync/async commands.

Virtio-scmi support has been exercised in the following testing scenario
on a JUNO board:

 - normal sync/async command transfers
 - notifications
 - concurrent delivery of correlated response and delayed responses
 - out-of-order delivery of delayed responses before related responses
 - unexpected delayed response delivery for sync commands
 - late delivery of timed-out responses and delayed responses

Some basic regression testing against mailbox transport has been performed
for commands and notifications too.

No sensible overhead in total handling time of commands and notifications
has been observed, even though this series do indeed add a considerable
amount of code to execute on TX path.

This series is based on sudeep/for-next/scmi [1] on top of

commit bdb8742dc6f7 ("firmware: arm_scmi: Fix range check for the maximum
		     number of pending messages")

Any feedback/testing is welcome :D

Thanks,
Cristian

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/log/?h=for-next/scmi
---
v6 --> v7
 - rebased on sudeep/for-next/scmi (v5.14-rc1)
 - added Cc: for maintainers regarding Virtio SCMI device number addition
   in include/uapi/linux/virtio_ids.h (previously only list was Cc'ed)
 - V6 patches 01 and 02 have been removed from V7 since already queued on
   sudeep/for-next/scmi
 - renamed scmi_desc .init/.exit to .transport_init/.exit
 - moved "firmware: arm_scmi: Add priv parameter to scmi_rx_callback" later
   in the series
 - simplified new SCMI Kconfig layout
 - refactored/simplified  support for non-polling transports
 - moved introduction of xfer refcounting from "firmware: arm_scmi:
   Introduce monotonically increasing tokens" to "firmware: arm_scmi:
   Handle concurrent and out-of-order messages"
 - renamed scmi_xfer_is_free to scmi_xfer_acquired
 - moved scmi_xfer_state_update() call inside scmi_xfer_command_acquire
 - added missing barrier in do_xfer()
 - added proper comment to justify pending_xfers sizing and relocated such
   #define directive
 - removed last_token atomic counter, now generating monotonic seqnums
   based on transfer_id

V5 --> V6:
 - removed delegated xfers and its usage
 - add and use *priv optional parameter in scmi_rx_callback()
 - made .poll_done and .clear_channel ops optional

V4 --> V5:
 - removed msg raw_payload helpers
 - reworked msg helpers to use xfer->priv reference
 - simplified SCMI device probe sequence (one static device)
 - added new SCMI Kconfig layout
 - removed SCMI virtio polling support

V3 --> V4:
 - using new delegated xfers support and monotonically increasing tokens
   in virtio transport
 - ported SCMI virtio transport DT bindings to YAML format
 - added virtio-scmi polling support
 - added delegated xfers support


Cristian Marussi (9):
  firmware: arm_scmi: Add support for type handling in common functions
  firmware: arm_scmi: Remove scmi_dump_header_dbg() helper
  firmware: arm_scmi: Add optional transport_init/exit support
  firmware: arm_scmi: Introduce monotonically increasing tokens
  firmware: arm_scmi: Handle concurrent and out-of-order messages
  firmware: arm_scmi: Make .clear_channel optional
  firmware: arm_scmi: Make polling mode optional
  firmware: arm_scmi: Make SCMI transports configurable
  firmware: arm_scmi: Add priv parameter to scmi_rx_callback

Igor Skalkin (4):
  firmware: arm_scmi: Make shmem support optional for transports
  firmware: arm_scmi: Add method to override max message number
  dt-bindings: arm: Add virtio transport for SCMI
  firmware: arm_scmi: Add virtio transport

Peter Hilber (2):
  firmware: arm_scmi: Add message passing abstractions for transports
  firmware: arm_scmi: Add optional link_supplier() transport op

 .../bindings/firmware/arm,scmi.yaml           |   8 +-
 MAINTAINERS                                   |   1 +
 drivers/firmware/Kconfig                      |  34 +-
 drivers/firmware/arm_scmi/Kconfig             |  95 +++
 drivers/firmware/arm_scmi/Makefile            |   8 +-
 drivers/firmware/arm_scmi/common.h            | 113 ++-
 drivers/firmware/arm_scmi/driver.c            | 649 +++++++++++++++---
 drivers/firmware/arm_scmi/mailbox.c           |   2 +-
 drivers/firmware/arm_scmi/msg.c               | 111 +++
 drivers/firmware/arm_scmi/smc.c               |   3 +-
 drivers/firmware/arm_scmi/virtio.c            | 491 +++++++++++++
 include/uapi/linux/virtio_ids.h               |   1 +
 include/uapi/linux/virtio_scmi.h              |  24 +
 13 files changed, 1403 insertions(+), 137 deletions(-)
 create mode 100644 drivers/firmware/arm_scmi/Kconfig
 create mode 100644 drivers/firmware/arm_scmi/msg.c
 create mode 100644 drivers/firmware/arm_scmi/virtio.c
 create mode 100644 include/uapi/linux/virtio_scmi.h

-- 
2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

