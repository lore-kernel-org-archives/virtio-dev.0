Return-Path: virtio-dev-return-4137-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 1215A58191BA
	for <virtio-dev@lists.oasis-open.org>; Wed, 23 May 2018 08:16:35 -0700 (PDT)
From: Venu Busireddy <venu.busireddy@oracle.com>
Date: Wed, 23 May 2018 11:16:12 -0400
Message-Id: <20180523151613.3914-1-venu.busireddy@oracle.com>
Subject: [virtio-dev] [PATCH 0/1] Add "Group Identifier" to virtio PCI capabilities.
To: venu.busireddy@oracle.com, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

During live migration involving passthrough devices, the guest needs
to know which virtio device will be a fail-over device for a given
passthrough device.

Extending the virtio specification with a new "Group Identifier"
capability allows qemu to set up the grouping at the time the guest
is created. The "Group Identifier" can be as simple as a number, or an
UUID. The driver can use the group identifier to pair the virtio device
with the passthrough device. The passthrough device can contain the
group identifier in the PCIe bridge to which it is attached.

Venu Busireddy (1):
  Add "Group Identifier" to virtio PCI capabilities.

 content.tex | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

