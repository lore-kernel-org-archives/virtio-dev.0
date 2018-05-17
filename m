Return-Path: virtio-dev-return-4090-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 35D8C581916B
	for <virtio-dev@lists.oasis-open.org>; Thu, 17 May 2018 06:06:27 -0700 (PDT)
From: Venu Busireddy <venu.busireddy@oracle.com>
Date: Thu, 17 May 2018 09:06:03 -0400
Message-Id: <20180517130604.9036-1-venu.busireddy@oracle.com>
Subject: [virtio-dev] [PATCH 0/1] Allow "Vendor Specific" extension to virtio PCI capabilities.
To: venu.busireddy@oracle.com, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Section 4.1.4 of the virtio specification, while describing the values
for cfg_type field of "virtio PCI capabilities" says, "Any other
value is reserved for future use."  Currently, values 1 through 5 are
defined. Every other value is reserved.

It would be useful if the virtio specification provides a virtio PCI
capability that is reserved for any vendor specific extension, thus
allowing the vendors to define any vendor specific extension to virtio
PCI capabilities.

That will be similar to what the PCI specification has done. While
reserving all Capability IDs from 12h through 0FFh, it also provides a
"Vendor Specific" capability ID (0x09), to allow the device vendors to
use the capability mechanism for vendor specific information.

There are alternative ways to achieve the same objective, but the
implementation is much cleaner with a new virtio PCI capability.


Venu Busireddy (1):
  Allow "Vendor Specific" extension to virtio PCI capabilities.

 content.tex | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

