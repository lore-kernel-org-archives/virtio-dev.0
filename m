Return-Path: virtio-dev-return-8155-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 175E99861F0
	for <virtio-dev@lists.oasis-open.org>; Tue, 11 May 2021 00:22:05 +0000 (UTC)
From: Peter Hilber <peter.hilber@opensynergy.com>
Date: Tue, 11 May 2021 02:20:28 +0200
Message-ID: <20210511002040.802226-1-peter.hilber@opensynergy.com>
MIME-Version: 1.0
Subject: [virtio-dev] [RFC PATCH v3 00/12] firmware: arm_scmi: Add virtio transport
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: Peter Hilber <peter.hilber@opensynergy.com>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, sudeep.holla@arm.com, souvik.chakravarty@arm.com, alex.bennee@linaro.org, jean-philippe@linaro.org, igor.skalkin@opensynergy.com, mikhail.golubev@opensynergy.com, anton.yakovlev@opensynergy.com, Vasyl Vavrychuk <Vasyl.Vavrychuk@opensynergy.com>, Andriy Tryshnivskyy <Andriy.Tryshnivskyy@opensynergy.com>
List-ID: <virtio-dev.lists.oasis-open.org>

This series implements an SCMI virtio driver according to the virtio
SCMI device spec [1], after simple preparatory changes to the
existing arm-scmi driver.

This RFC patch series is intended to give others an understanding of the
current development progress.

The virtio transport differs in some respects from the existing
shared-memory based SCMI transports, and therefore some preparatory
steps are necessary.

The series is based on v5.13-rc1.

Changes in RFC v3:

- Fix scmi_xfer buffer management. Use dedicated buffers for actual
  Tx/Rx. Introduce a message handle, and a drop_message() op for message
  passing-based transports.

- Add service data unit abstraction for transports which use message
  passing.

- The virtio transport doesn't call the core once the channel is not
  ready any more.

- Handle races between core and transport.

- Use generic transport init/deinit (Cristian Marussi).

- Don't use vqueue->priv field (Viresh Kumar).

- Numerous small improvements.

The following problems remain:

- Polling is not implemented.

- When handling races between core and transport, a timeout corner case
  can keep an scmi_xfer permanently occupied.

- We must be sure that the virtio transport option (such as virtio over
  MMIO) is available when the virtio SCMI device is probed.

All other known problems should have been addressed.

Test:

The series was smoke tested with a v5.4 based kernel, with the Base
protocol and Sensor management protocol. The virtio SCMI device used was
a proprietary implementation by OpenSynergy.

The following was not tested yet:

- delayed responses

- driver remove

- timeouts

Changes in RFC v2:

- Remove the DT virtio_transport phandle, since the SCMI virtio device
  may not be known in advance. Instead, use the first suitable probed
  device. Change due to Rob Herring's comment.

Any comments are very welcome.

[1] https://github.com/oasis-tcs/virtio-spec/blob/master/virtio-scmi.tex


Cristian Marussi (1):
  firmware: arm_scmi: Add transport init/deinit

Igor Skalkin (4):
  firmware: arm_scmi, smccc, mailbox: Make shmem based transports
    optional
  firmware: arm_scmi: Add op to override max message #
  dt-bindings: arm: Add virtio transport for SCMI
  firmware: arm_scmi: Add virtio transport

Peter Hilber (7):
  firmware: arm_scmi: Add optional link_supplier() transport op
  firmware: arm_scmi: Add per-device transport private info
  firmware: arm_scmi: Add is_scmi_protocol_device()
  firmware: arm_scmi: Add msg_handle to some transport ops
  firmware: arm_scmi: Add optional drop_message() transport op
  firmware: arm_scmi: Add message passing abstractions for transports
  firmware: arm_scmi: Handle races between core and transport

 .../devicetree/bindings/arm/arm,scmi.txt      |  35 +-
 MAINTAINERS                                   |   1 +
 drivers/firmware/Kconfig                      |  26 +-
 drivers/firmware/arm_scmi/Makefile            |   4 +-
 drivers/firmware/arm_scmi/bus.c               |   5 +
 drivers/firmware/arm_scmi/common.h            |  81 ++-
 drivers/firmware/arm_scmi/driver.c            | 310 +++++++++--
 drivers/firmware/arm_scmi/mailbox.c           |   7 +-
 drivers/firmware/arm_scmi/msg.c               | 113 ++++
 drivers/firmware/arm_scmi/smc.c               |   5 +-
 drivers/firmware/arm_scmi/virtio.c            | 524 ++++++++++++++++++
 drivers/firmware/smccc/Kconfig                |   1 +
 drivers/mailbox/Kconfig                       |   1 +
 include/uapi/linux/virtio_ids.h               |   1 +
 include/uapi/linux/virtio_scmi.h              |  25 +
 15 files changed, 1065 insertions(+), 74 deletions(-)
 create mode 100644 drivers/firmware/arm_scmi/msg.c
 create mode 100644 drivers/firmware/arm_scmi/virtio.c
 create mode 100644 include/uapi/linux/virtio_scmi.h


base-commit: 6efb943b8616ec53a5e444193dccf1af9ad627b5
--=20
2.25.1



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

