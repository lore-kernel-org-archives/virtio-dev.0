Return-Path: virtio-dev-return-7794-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4C04398602C
	for <virtio-dev@lists.oasis-open.org>; Fri, 18 Sep 2020 16:26:31 +0000 (UTC)
From: Peter Hilber <peter.hilber@opensynergy.com>
Date: Fri, 18 Sep 2020 18:23:09 +0200
Message-ID: <20200918162311.254564-1-peter.hilber@opensynergy.com>
MIME-Version: 1.0
Subject: [virtio-dev] [RFC PATCH 0/7] firmware: arm_scmi: Add virtio transport
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, sudeep.holla@arm.com, souvik.chakravarty@arm.com, alex.bennee@linaro.org, jean-philippe@linaro.org, igor.skalkin@opensynergy.com, mikhail.golubev@opensynergy.com, anton.yakovlev@opensynergy.com, Peter Hilber <peter.hilber@opensynergy.com>, Jason Wang <jasowang@redhat.com>, Jassi Brar <jassisinghbrar@gmail.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

This series implements an SCMI virtio driver according to the virtio
SCMI device spec patch v5 [1], after simple preparatory changes to the
existing arm-scmi driver.

The virtio transport differs in some respects from the existing
shared-memory based SCMI transports.

Message timeouts can be a problem if the virtio device (SCMI platform)
does not have real-time properties. I set a high message rx timeout
value which should work for non real-time virtio devices as well. There
are other timeouts for delayed response and polling which were not
addressed yet. Delayed responses are not really needed since, with the
virtio transport, message responses may be transmitted out of order.
Polling doesn't make sense at least for virtio devices without real-time
behavior, in my understanding.

There are some known issues which will be resolved before removing the
RFC tag:

- Further work is needed on the scmi_xfer management. Unlike shmem based
  transports, the virtio transport is actually exchanging messages with
  the SCMI agent through the scmi_xfer tx and rx buffers. In case of a
  message rx timeout, the arm-scmi driver could try to re-use the
  scmi_xfer, while that might still be used by the virtio device. I
  think part of the scmi_xfers_info bookkeeping could be optionally
  outsourced to the transport to remediate this.

- After arm-scmi driver probe failure, or after remove, the scmi-virtio
  driver may still try to process and forward message responses from the
  virtio device.

- We must be sure that the virtio transport option (such as virtio over
  MMIO) is available when the virtio SCMI device is probed.

The series is based on for-next/scmi [2], on top of

commit 66d90f6ecee7 ("firmware: arm_scmi: Enable building as a single modul=
e")

The series was actually tested with a v5.4 based kernel, with the Base
protocol and Sensor management protocol. The virtio SCMI device used was
a proprietary implementation by OpenSynergy. Delayed responses were not
tested.

Any comments are very welcome.

[1] https://lists.oasis-open.org/archives/virtio-comment/202005/msg00096.ht=
ml
[2] https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git


Igor Skalkin (7):
  firmware: arm_scmi, smccc, mailbox: Make shmem based transports
    optional
  firmware: arm_scmi: Document that max_msg is a per channel type limit
  firmware: arm_scmi: Add op to override max message #
  firmware: arm_scmi: Add per message transport data
  firmware: arm_scmi: Add xfer_init_buffers transport op
  dt-bindings: arm: Add virtio transport for SCMI
  firmware: arm_scmi: Add virtio transport

 .../devicetree/bindings/arm/arm,scmi.txt      |  38 +-
 MAINTAINERS                                   |   1 +
 drivers/firmware/Kconfig                      |  19 +-
 drivers/firmware/arm_scmi/Makefile            |   3 +-
 drivers/firmware/arm_scmi/common.h            |  31 +-
 drivers/firmware/arm_scmi/driver.c            |  83 +++-
 drivers/firmware/arm_scmi/virtio.c            | 470 ++++++++++++++++++
 drivers/firmware/smccc/Kconfig                |   1 +
 drivers/mailbox/Kconfig                       |   1 +
 include/uapi/linux/virtio_ids.h               |   1 +
 include/uapi/linux/virtio_scmi.h              |  41 ++
 11 files changed, 664 insertions(+), 25 deletions(-)
 create mode 100644 drivers/firmware/arm_scmi/virtio.c
 create mode 100644 include/uapi/linux/virtio_scmi.h


base-commit: 66d90f6ecee755e9c19a119c9255e80091165498
--=20
2.25.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

