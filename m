Return-Path: virtio-dev-return-2624-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 6A20B58191B1
	for <virtio-dev@lists.oasis-open.org>; Tue, 24 Oct 2017 15:25:29 -0700 (PDT)
Date: Wed, 25 Oct 2017 01:25:25 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171025012316-mutt-send-email-mst@kernel.org>
References: <B84047ECBD981D4B93EAE5A6245AA361013EF401@FRAEML521-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B84047ECBD981D4B93EAE5A6245AA361013EF401@FRAEML521-MBX.china.huawei.com>
Subject: Re: [virtio-dev] vhost-user to interconnect vm's
To: "Avi Cohen (A)" <avi.cohen@huawei.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Ofer Ben-Yacov <ofer.benyacov@toganetworks.com>, Wei Wang <wei.w.wang@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Oct 24, 2017 at 02:07:21PM +0000, Avi Cohen (A) wrote:
> Hello,
> I wonder if it is possible to directly connect 2  VM's (without host intervention) with  vhost-user interface , so one VM is slave and the 2nd  is the master.
> I can connect the VM's with OVS-DPDK (or VPP)  in the middle - but this requires an extra copy.
> Best Regards
> Avi


This is the vhost-pci set of patches. They are not upstream yet -
last version - v2 - was posted back in May. Cc Wei Wang for an
update on the status. It would be great if you could try them out.

> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

