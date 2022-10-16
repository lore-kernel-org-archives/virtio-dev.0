Return-Path: <virtio-dev-return-10020-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 70B38983D8E
	for <virtio-dev@lists.oasis-open.org>; Sun, 16 Oct 2022 03:41:35 +0000 (UTC)
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Date: Sat, 15 Oct 2022 23:41:25 -0400
Message-Id: <20221016034127.330942-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v2 0/2] virtio-blk: support zoned block devices
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"; x-default=true
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, Damien Le Moal <damien.lemoal@opensource.wdc.com>, Stefan Hajnoczi <stefanha@gmail.com>, Hannes Reinecke <hare@suse.de>, Sam Li <faithilikerun@gmail.com>
Cc: virtio-dev@lists.oasis-open.org, Dmitry Fomichev <dmitry.fomichev@wdc.com>
List-ID: <virtio-dev.lists.oasis-open.org>

In its current form, the virtio protocol for block devices (virtio-blk)
is not aware of zoned block devices (ZBDs) but it allows the driver to
successfully scan a host-managed drive provided by the virtio block
device. As the result, the host-managed drive is recognized by the
virtio driver as a regular, non-zoned drive that will operate
erroneously under the most common write workloads. Host-aware ZBDs are
currently usable, but their performance may not be optimal because the
driver can only see them as non-zoned block devices.

To fix this, the virtio-blk protocol needs to be extended to add the
capabilities to convey the zone characteristics of ZBDs at the device
side to the driver and to provide support for ZBD-specific commands -
Report Zones, four zone operations (Open, Close, Finish and Reset) and
(optionally) Zone Append.

The required virtio-blk protocol extensions are currently under review
at OASIS Technical Committee and the specification patch is linked at

https://github.com/oasis-tcs/virtio-spec/issues/143 .

The QEMU zoned device code that implements these protocol extensions
has been developed by Sam Li, an intern, as a part of Outreachy
community mentorship initiative. The latest version of the QEMU
patchset can be found here:

https://lists.gnu.org/archive/html/qemu-devel/2022-09/msg01469.html

This patch series modifies the virtio block driver code to implement
the above virtio specification extensions. This patch has been tested
to be compatible with the QEMU implementation referred above.

v1 -> v2:

 - Rebase to the current head of development. The second patch in the
   previous version is no longer needed as the secure erse support has
   now been added to virtio_blk driver

 - Fix a couple of bugs in zone report code

 - Clean up ZBD probe code

This version DOESN'T include the additional request layout changes that
are being discussed at the OASIS TC. An updated patch series will be
posted to the list when those changes are finalized.

Dmitry Fomichev (2):
  virtio-blk: use a helper to handle request queuing errors
  virtio-blk: add support for zoned block devices

 drivers/block/virtio_blk.c      | 406 +++++++++++++++++++++++++++++---
 include/uapi/linux/virtio_blk.h | 105 +++++++++
 2 files changed, 480 insertions(+), 31 deletions(-)

--=20
2.34.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

