Return-Path: <mst@redhat.com>
Date: Fri, 13 Jan 2023 06:44:11 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-comment] [PATCH v4 00/20] Split device spec to its
 individual files
Message-ID: <20230113064248-mutt-send-email-mst@kernel.org>
References: <20230112212254.763783-1-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230112212254.763783-1-parav@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com, virtio-comment@lists.oasis-open.org, david@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Jan 12, 2023 at 11:22:34PM +0200, Parav Pandit wrote:
> Relatively several of the recent device specifications are maintained
> in their own specification file. Such separate files enables better
> maintenance of the specification overall.
> However, several of the initial virtio device specifications
> are located in single file.
> 
> Hence, split them into their individual files.
> 
> Additionally, each device's driver and device conformance is
> present in one giant conformance file all together.
> 
> As Michael suggest's move this device and driver conformance
> section adjacent to device specification in each device specific
> directory. This further makes device specification self-contained.
> 
> Added patch to fix spelling errors in network device
> specification which was inherited from its previous file
> location.
> 
> Patches do not change any part of the specification outcome
> except fixing the spelling errors.
> It only changes how the specification is maintained.


Don't see any problems here.
Acked-by: Michael S. Tsirkin <mst@redhat.com>

Let's give people a bit of time to review and then start voting.

> patch summary:
> -------------
> patch 1 to 7 creates new files for moving devices spec out of
> content and conformance files.
> patch 8 to 20 move existing dedicated file spec to new directory
> and creates per device,driver conformance file for each device.
> 
> changelog:
> ----------
> v3->v4:
> - renamed mem-balloon directory to just balloon
> - renamed network to net, block to blk
> - fixed several hunks placed in wrong patches
> - dropped virtio- prefix from the directories
> v2->v3:
> - file name changed from device.tex to description.tex
> - use input instead of import to insert a file
> v1->v2:
> - removed extra blank lines in network and block device files
> - added missing device conformance link for rpmb, sound, i2c and
>   gpio devices
> v0->v1:
> - move device spec to their own directory
> - added split files for conformance and placed them adjacent to
>   device spec
> - added patch to fix spelling errors in network device
> 
> 
> Parav Pandit (20):
>   virtio-net: Maintain network device spec in separate directory
>   virtio-net: Fix spelling errors
>   virtio-blk: Maintain block device spec in separate directory
>   virtio-console: Maintain console device spec in separate directory
>   virtio-entropy: Maintain entropy device spec in separate directory
>   virtio-mem-balloon: Maintain mem balloon device spec in separate
>     directory
>   virtio-scsi: Maintain scsi host device spec in separate directory
>   virtio-gpu: Maintain gpu device spec in separate directory
>   virtio-input: Maintain input device spec in separate directory
>   virtio-crypto: Maintain crypto device spec in separate directory
>   virtio-vsock: Maintain socket device spec in separate directory
>   virtio-fs: Maintain file system device spec in separate directory
>   virtio-rpmb: Maintain rpmb device spec in separate directory
>   virtio-iommu: Maintain iommu device spec in separate directory
>   virtio-sound: Maintain sound device spec in separate directory
>   virtio-mem: Maintain memory device spec in separate directory
>   virtio-i2c: Maintain i2c device spec in separate directory
>   virtio-scmi: Maintain scmi device spec in separate directory
>   virtio-gpio: Maintain gpio device spec in separate directory
>   virtio-pmem: Maintain pmem device spec in separate directory
> 
>  conformance.tex                               |  456 +-
>  content.tex                                   | 4561 +----------------
>  device-types/balloon/description.tex          |  634 +++
>  device-types/balloon/device-conformance.tex   |   12 +
>  device-types/balloon/driver-conformance.tex   |   12 +
>  device-types/blk/description.tex              | 1313 +++++
>  device-types/blk/device-conformance.tex       |    8 +
>  device-types/blk/driver-conformance.tex       |    8 +
>  device-types/console/description.tex          |  231 +
>  device-types/console/device-conformance.tex   |    8 +
>  device-types/console/driver-conformance.tex   |    8 +
>  .../crypto/description.tex                    |    0
>  device-types/crypto/device-conformance.tex    |   13 +
>  device-types/crypto/driver-conformance.tex    |   14 +
>  device-types/entropy/description.tex          |   42 +
>  device-types/entropy/device-conformance.tex   |    7 +
>  device-types/entropy/driver-conformance.tex   |    7 +
>  .../fs/description.tex                        |    0
>  device-types/fs/device-conformance.tex        |    9 +
>  device-types/fs/driver-conformance.tex        |   10 +
>  .../gpio/description.tex                      |    0
>  device-types/gpio/device-conformance.tex      |    9 +
>  device-types/gpio/driver-conformance.tex      |    9 +
>  .../gpu/description.tex                       |    0
>  device-types/gpu/device-conformance.tex       |    8 +
>  .../i2c/description.tex                       |    0
>  device-types/i2c/device-conformance.tex       |    7 +
>  device-types/i2c/driver-conformance.tex       |    7 +
>  .../input/description.tex                     |    0
>  device-types/input/device-conformance.tex     |    8 +
>  device-types/input/driver-conformance.tex     |    8 +
>  .../iommu/description.tex                     |    0
>  device-types/iommu/device-conformance.tex     |   16 +
>  device-types/iommu/driver-conformance.tex     |   17 +
>  .../mem/description.tex                       |    0
>  device-types/mem/device-conformance.tex       |   13 +
>  device-types/mem/driver-conformance.tex       |   13 +
>  device-types/net/description.tex              | 1594 ++++++
>  device-types/net/device-conformance.tex       |   16 +
>  device-types/net/driver-conformance.tex       |   17 +
>  .../pmem/description.tex                      |    0
>  device-types/pmem/device-conformance.tex      |    9 +
>  device-types/pmem/driver-conformance.tex      |    7 +
>  .../rpmb/description.tex                      |    0
>  device-types/rpmb/device-conformance.tex      |   13 +
>  device-types/rpmb/driver-conformance.tex      |    7 +
>  .../scmi/description.tex                      |    0
>  device-types/scmi/device-conformance.tex      |   10 +
>  device-types/scmi/driver-conformance.tex      |    8 +
>  device-types/scsi/description.tex             |  709 +++
>  device-types/scsi/device-conformance.tex      |   10 +
>  device-types/scsi/driver-conformance.tex      |    9 +
>  .../sound/description.tex                     |    0
>  device-types/sound/device-conformance.tex     |   16 +
>  device-types/sound/driver-conformance.tex     |   13 +
>  .../vsock/description.tex                     |    0
>  device-types/vsock/device-conformance.tex     |    9 +
>  device-types/vsock/driver-conformance.tex     |   10 +
>  58 files changed, 4964 insertions(+), 4961 deletions(-)
>  create mode 100644 device-types/balloon/description.tex
>  create mode 100644 device-types/balloon/device-conformance.tex
>  create mode 100644 device-types/balloon/driver-conformance.tex
>  create mode 100644 device-types/blk/description.tex
>  create mode 100644 device-types/blk/device-conformance.tex
>  create mode 100644 device-types/blk/driver-conformance.tex
>  create mode 100644 device-types/console/description.tex
>  create mode 100644 device-types/console/device-conformance.tex
>  create mode 100644 device-types/console/driver-conformance.tex
>  rename virtio-crypto.tex => device-types/crypto/description.tex (100%)
>  create mode 100644 device-types/crypto/device-conformance.tex
>  create mode 100644 device-types/crypto/driver-conformance.tex
>  create mode 100644 device-types/entropy/description.tex
>  create mode 100644 device-types/entropy/device-conformance.tex
>  create mode 100644 device-types/entropy/driver-conformance.tex
>  rename virtio-fs.tex => device-types/fs/description.tex (100%)
>  create mode 100644 device-types/fs/device-conformance.tex
>  create mode 100644 device-types/fs/driver-conformance.tex
>  rename virtio-gpio.tex => device-types/gpio/description.tex (100%)
>  create mode 100644 device-types/gpio/device-conformance.tex
>  create mode 100644 device-types/gpio/driver-conformance.tex
>  rename virtio-gpu.tex => device-types/gpu/description.tex (100%)
>  create mode 100644 device-types/gpu/device-conformance.tex
>  rename virtio-i2c.tex => device-types/i2c/description.tex (100%)
>  create mode 100644 device-types/i2c/device-conformance.tex
>  create mode 100644 device-types/i2c/driver-conformance.tex
>  rename virtio-input.tex => device-types/input/description.tex (100%)
>  create mode 100644 device-types/input/device-conformance.tex
>  create mode 100644 device-types/input/driver-conformance.tex
>  rename virtio-iommu.tex => device-types/iommu/description.tex (100%)
>  create mode 100644 device-types/iommu/device-conformance.tex
>  create mode 100644 device-types/iommu/driver-conformance.tex
>  rename virtio-mem.tex => device-types/mem/description.tex (100%)
>  create mode 100644 device-types/mem/device-conformance.tex
>  create mode 100644 device-types/mem/driver-conformance.tex
>  create mode 100644 device-types/net/description.tex
>  create mode 100644 device-types/net/device-conformance.tex
>  create mode 100644 device-types/net/driver-conformance.tex
>  rename virtio-pmem.tex => device-types/pmem/description.tex (100%)
>  create mode 100644 device-types/pmem/device-conformance.tex
>  create mode 100644 device-types/pmem/driver-conformance.tex
>  rename virtio-rpmb.tex => device-types/rpmb/description.tex (100%)
>  create mode 100644 device-types/rpmb/device-conformance.tex
>  create mode 100644 device-types/rpmb/driver-conformance.tex
>  rename virtio-scmi.tex => device-types/scmi/description.tex (100%)
>  create mode 100644 device-types/scmi/device-conformance.tex
>  create mode 100644 device-types/scmi/driver-conformance.tex
>  create mode 100644 device-types/scsi/description.tex
>  create mode 100644 device-types/scsi/device-conformance.tex
>  create mode 100644 device-types/scsi/driver-conformance.tex
>  rename virtio-sound.tex => device-types/sound/description.tex (100%)
>  create mode 100644 device-types/sound/device-conformance.tex
>  create mode 100644 device-types/sound/driver-conformance.tex
>  rename virtio-vsock.tex => device-types/vsock/description.tex (100%)
>  create mode 100644 device-types/vsock/device-conformance.tex
>  create mode 100644 device-types/vsock/driver-conformance.tex
> 
> -- 
> 2.26.2
> 
> 
> This publicly archived list offers a means to provide input to the
> OASIS Virtual I/O Device (VIRTIO) TC.
> 
> In order to verify user consent to the Feedback License terms and
> to minimize spam in the list archive, subscription is required
> before posting.
> 
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> List help: virtio-comment-help@lists.oasis-open.org
> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> Committee: https://www.oasis-open.org/committees/virtio/
> Join OASIS: https://www.oasis-open.org/join/

