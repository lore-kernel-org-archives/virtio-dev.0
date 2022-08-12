Return-Path: <mst@redhat.com>
Date: Fri, 12 Aug 2022 13:18:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH RFC v7 0/8] Introduce device group and device management
Message-ID: <20220812171841.12183-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, mst@redhat.com, cohuck@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, oren@nvidia.com, parav@nvidia.com, shahafs@nvidia.com, aadam@redhat.com, eperezma@redhat.com, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

This is back to RFC status, in particular because I did not yet
have the time to work on any of the actual commands.

Change log:
	- removed some extentions intended for future use.
	  We'll do them when we get there.

	- brought back command list query from v5 in a simplified form -
	  it's here to address the case where a single parent
	  can address multiple groups, such as PF addressing
	  transport vq and sriov vfs.

	- attempt to make terminology more formal.
	In particular a term for whoever controls the group.
 	I am still going back
	and forth between "parent" and "owner" - owner might
	be better after all since it will work if we ever
	have a self group. For now it's parent.

TODO:
	Conformance statements! This proposal has almost
	none and this won't do.

	Add "all members" member id.

	Add commands for MSI, feature discovery.

	Add commands for transport vq.


My intent is to try and support both SR-IOV and SIOV
usecases with the same structure and maybe even the same
VQ.

For example, it might make sense to split
creating/destroying SIOV devices from the transport
passing data from the guest.


Max Gurtovoy (5):
  Introduce device group
  Introduce group administration commands
  Introduce virtio admin virtqueue
  Add admin_queue_index register to PCI common configuration structure
  admin command list discovery

Michael S. Tsirkin (3):
  MMIO: disallow using admin vq bit
  ccw: disallow ADMIN_VQ
  admin: document that structures can be shorter or longer

 admin.tex       | 221 ++++++++++++++++++++++++++++++++++++++++++++++++
 conformance.tex |   1 +
 content.tex     |  40 ++++++++-
 3 files changed, 260 insertions(+), 2 deletions(-)
 create mode 100644 admin.tex

-- 
MST

