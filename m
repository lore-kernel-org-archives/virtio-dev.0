Return-Path: <virtio-dev-return-10858-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A8E04986586
	for <virtio-dev@lists.oasis-open.org>; Thu,  9 Feb 2023 12:13:35 +0000 (UTC)
Date: Thu, 9 Feb 2023 07:13:28 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20230209121221.15118-1-mst@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v10 00/10] Introduce device group and device management
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, mst@redhat.com, cohuck@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>


Thanks to everyone who commented!  Here's v10 after a longish
hiccup - I hope this is close to being ready. I'm especially
interested to hear whether this is in a good enough shape to
serve as basis for vq transport.

Thanks!

Change log:

since v9:
	addressed review comments:
		multiple typo fixes
		made command list array 64 bit - easier future proofing
		clarifications around group type and admin command concepts
		lots of clarifications around structure
			trucation for forwards and backwards compatibility -
			hopefully things are clear now

since v8:
	addressed comments by Cornelia - as we agreed on list
	
since v7:
	make high level error codes match linux, with virtio specific codes
		in a separate field
	renamed _ACCEPT to _USE since that's what it does
	clarified forward compatibility and non pci transports
	support multiple admin vqs
	conformance statements
	lots of changes all over the place to I changed author from Max
	to myself. Don't need to take credit but also don't want
	to blame Max for my mistakes.

since v6:

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

TODO (maybe?) - probably ok to defer until this part is upstream:

	Add "all members" member id.

	Add commands for MSI, feature discovery.

	Add commands for transport vq.


My intent is to try and support both SR-IOV and SIOV
usecases with the same structure and maybe even the same
VQ.

For example, it might make sense to split creating/destroying
SIOV devices from the transport passing data from the guest - the
driver would then not negotiate VIRTIO_F_SR_IOV (which
then means auto-provisioning).

This is out of RFC, since we have two commands which are useful
to discover supported group types (ATM can be none or SR-IOV).


Michael S. Tsirkin (10):
  virtio: document forward compatibility guarantees
  admin: introduce device group and related concepts
  admin: introduce group administration commands
  admin: introduce virtio admin virtqueues
  pci: add admin vq registers to virtio over pci
  mmio: document ADMIN_VQ as reserved
  ccw: document ADMIN_VQ as reserved
  admin: command list discovery
  admin: conformance clauses
  ccw: document more reserved features

 admin.tex   | 501 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 content.tex | 111 +++++++++++-
 2 files changed, 610 insertions(+), 2 deletions(-)
 create mode 100644 admin.tex

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

