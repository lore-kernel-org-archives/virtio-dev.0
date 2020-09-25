Return-Path: virtio-dev-return-7814-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0B018985DC3
	for <virtio-dev@lists.oasis-open.org>; Fri, 25 Sep 2020 14:15:01 +0000 (UTC)
Date: Fri, 25 Sep 2020 16:14:46 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20200925141446.63iwheqdrqxl3puo@sirius.home.kraxel.org>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
 <20200925084806.GB490533@myrica>
 <20200925062230-mutt-send-email-mst@kernel.org>
 <20200925112629.GA1337555@myrica>
 <20200925094405-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20200925094405-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-dev] Re: [PATCH v3 0/6] Add virtio-iommu built-in
 topology
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org, joro@8bytes.org, bhelgaas@google.com, jasowang@redhat.com, kevin.tian@intel.com, sebastien.boeuf@intel.com, eric.auger@redhat.com, lorenzo.pieralisi@arm.com
List-ID: <virtio-dev.lists.oasis-open.org>

  Hi,

> Many power platforms are OF based, thus without ACPI or DT support.

pseries has lots of stuff below /proc/device-tree.  Dunno whenever that
is the same kind of device tree we have on arm ...

take care,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

