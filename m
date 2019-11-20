Return-Path: virtio-dev-return-6355-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 55376985E73
	for <virtio-dev@lists.oasis-open.org>; Wed, 20 Nov 2019 15:21:16 +0000 (UTC)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Date: Wed, 20 Nov 2019 16:19:02 +0100
Message-Id: <20191120151903.175110-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH RESEND v4 0/1] Add virtio-iommu specification
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: virtio-dev@lists.oasis-open.org
Cc: joro@8bytes.org, tnowicki@marvell.com, eric.auger@redhat.com, kevin.tian@intel.com, lorenzo.pieralisi@arm.com, mst@redhat.com, bauerman@linux.ibm.com
List-ID: <virtio-dev.lists.oasis-open.org>

Hi,

This is the base virtio-iommu specification. There wasn't any comment on
v4, but I have been away for a while so I'm resending the patch rebased
onto the current master.

The driver implementation has been merged in Linux, and the QEMU device
should follow soon. The next step is proper multiplatform support, for
which I'll send a proposal shortly. Then I'll work more on PASID and PRI
support, and some much needed optimizations.

I would like to request a vote for
https://github.com/oasis-tcs/virtio-spec/issues/37

Thanks,
Jean

Jean-Philippe Brucker (1):
  Add virtio-iommu device specification

 conformance.tex  |  40 ++-
 content.tex      |   1 +
 virtio-iommu.tex | 816 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 855 insertions(+), 2 deletions(-)
 create mode 100644 virtio-iommu.tex

--=20
2.24.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

