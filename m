Return-Path: <virtio-dev-return-10130-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D86659864E5
	for <virtio-dev@lists.oasis-open.org>; Wed,  9 Nov 2022 04:52:36 +0000 (UTC)
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Date: Tue,  8 Nov 2022 23:46:30 -0500
Message-Id: <20221109044632.3121790-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v6 0/2] virtio-blk: support zoned block devices
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
community mentorship initiative. The latest versions of the QEMU
patch series can be found here:

https://lists.gnu.org/archive/html/qemu-devel/2022-10/msg05195.html
https://lists.gnu.org/archive/html/qemu-devel/2022-10/msg05205.html
https://lists.gnu.org/archive/html/qemu-devel/2022-10/msg05896.html

This patch series modifies the virtio block driver code to implement
the above virtio specification extensions. This patch has been tested
to be compatible with the QEMU implementation referred above.

v5 -> v6:

Address review comments from Damien and Stefan:

 - Correctly calculate the size of the runt zone (i.e. the last zone in
   the LBA range that is smaller than others) using the device capacity

 - In virtblk_parse_zone(), make the write pointer invalid for offline
   and read-only zones

 - In virtblk_parse_zone(), return -EIO if the zone type or condition
   is invalid instead of -EINVAL. In this case, the caller's command
   was valid, it is the output data that has the error, hence -EIO

 - Do minor editorial changes - make some comments more clear, rename a
   label, etc.

v4 -> v5:

Address review comments from Stefan:

 - Take vdev_mutex in virtblk_report_zones() to prevent a potential
   race with virtblk_remove()

 - Check the current zoned model in virtblk_revalidate_zones() and
   reset the request queue zoned model to NONE if the reported model
   is not VIRTIO_BLK_Z_HM

 - Add the comment in virtblk_parse_zone() explaining why sanity
   checks are not needed in that function

v3 -> v4:

 - Fix the units in max ZA / write granularity check
 - Remove unneeded dev_info message

v2 -> v3:

 - Change the request in-header layout to always make the status byte
   to be the last byte of the in-header. For all requests except Zone
   Append, the in-header consists only of the status byte. For Zone
   Append, an extended in-header is defined that consists of the zone
   append sector followed by the status byte

 - In zone report handler, validate the zone type/condition values
   that are received from the device and convert them from the values
   defined in the virtio_blk ZBD spec extension to the values defined
   in the block layer

 - During ZBD scan, check that max_append_sectors is not smaller than
   the write granularity

 - Fix sparse warnings

v1 -> v2:

 - Rebase to the current head of development. The second patch in the
   previous version is no longer needed as the secure erase support has
   now been added to virtio_blk driver

 - Fix a couple of bugs in zone report code

 - Clean up ZBD probe code

This version DOESN'T include the additional request layout changes that
are being discussed at the OASIS TC. An updated patch series will be
posted to the list when those changes are finalized.

Dmitry Fomichev (2):
  virtio-blk: use a helper to handle request queuing errors
  virtio-blk: add support for zoned block devices

 drivers/block/virtio_blk.c      | 485 +++++++++++++++++++++++++++++---
 include/uapi/linux/virtio_blk.h | 105 +++++++
 2 files changed, 558 insertions(+), 32 deletions(-)

--=20
2.34.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

