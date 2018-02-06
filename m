Return-Path: virtio-dev-return-3158-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 3C2851CB8080
	for <virtio-dev@lists.oasis-open.org>; Tue,  6 Feb 2018 10:09:37 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Date: Tue,  6 Feb 2018 18:11:06 +0000
Message-Id: <20180206181106.21815-1-jean-philippe.brucker@arm.com>
Subject: [virtio-dev] [RFC] virtio-iommu version 0.6
To: virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org
Cc: eric.auger@redhat.com, bharat.bhushan@nxp.com, eric.auger.pro@gmail.com
List-ID: <virtio-dev.lists.oasis-open.org>

Please find version 0.6 of the virtio-iommu specification at the following
locations.

Document: http://jpbrucker.net/virtio-iommu/spec/virtio-iommu.pdf
          http://jpbrucker.net/virtio-iommu/spec/virtio-iommu.html

Sources: git://linux-arm.org/virtio-iommu.git viommu/v0.6

I didn't receive any comment for v0.5 [1], so this update is fairly light:
* Changed range definition in map and unmap requests
* Use virtio-iommu device ID
* Update IORT node ID and simplify layout

The following document shows the difference between v0.5 and v0.6:
http://jpbrucker.net/virtio-iommu/spec/diffs/virtio-iommu-pdf-diff-v0.5-v0.6.pdf

Next version will hopefully add vSVA (PASID+PRI) and/or architectural
optimizations, but I can't provide a timeline yet. I'll probably send a
small draft first.

I will send the Linux driver soon. In the meantime you can fetch it on my
development branches, based on next-20180206.

git://linux-arm.org/linux-jpb.git virtio-iommu/devel
git://linux-arm.org/kvmtool-jpb.git virtio-iommu/devel

Any comments welcome!

Thanks,
Jean

[1] https://www.spinics.net/lists/kvm/msg157402.html

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

