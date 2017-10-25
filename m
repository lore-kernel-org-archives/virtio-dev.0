Return-Path: virtio-dev-return-2628-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id B1A645819147
	for <virtio-dev@lists.oasis-open.org>; Wed, 25 Oct 2017 04:45:44 -0700 (PDT)
Message-ID: <59F079E5.5000705@intel.com>
Date: Wed, 25 Oct 2017 19:47:49 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <B84047ECBD981D4B93EAE5A6245AA361013EF401@FRAEML521-MBX.china.huawei.com> <20171025012316-mutt-send-email-mst@kernel.org> <59EFDF4F.8050708@intel.com> <B84047ECBD981D4B93EAE5A6245AA361013EF47B@FRAEML521-MBX.china.huawei.com>
In-Reply-To: <B84047ECBD981D4B93EAE5A6245AA361013EF47B@FRAEML521-MBX.china.huawei.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] vhost-user to interconnect vm's
To: "Avi Cohen (A)" <avi.cohen@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Ofer Ben-Yacov <ofer.benyacov@toganetworks.com>, "zhiyong.yang@intel.com" <zhiyong.yang@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 10/25/2017 03:34 PM, Avi Cohen (A) wrote:
> Thank you Michael and Wei
> What is the estimated time for kernel-driver implementation ?
> Best Regards
> Avi
>

We have some initial draft kernel driver code for the old design:
driver: https://github.com/wei-w-wang/vhost-pci-driver
device: https://github.com/wei-w-wang/vhost-pci-device

But don't have a plan to continue to work on the kernel driver until the
QEMU part gets upstreammed with dpdk pmd.

Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

