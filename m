Return-Path: virtio-dev-return-3077-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id B4D9258191C4
	for <virtio-dev@lists.oasis-open.org>; Thu, 25 Jan 2018 19:41:55 -0800 (PST)
References: <20180125040328.22867-1-tiwei.bie@intel.com>
 <20180125040328.22867-7-tiwei.bie@intel.com>
 <20180126015553-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <28ab37d5-6cf6-866d-9167-e14e7441415f@redhat.com>
Date: Fri, 26 Jan 2018 11:41:27 +0800
MIME-Version: 1.0
In-Reply-To: <20180126015553-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [virtio-dev] Re: [PATCH v1 6/6] vhost-user: add VFIO based
 accelerators support
To: "Michael S. Tsirkin" <mst@redhat.com>, Tiwei Bie <tiwei.bie@intel.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, alex.williamson@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, cunming.liang@intel.com, dan.daly@intel.com, jianfeng.tan@intel.com, zhihong.wang@intel.com, xiao.w.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>



On 2018年01月26日 07:59, Michael S. Tsirkin wrote:
>> The virtual IOMMU isn't supported by the accelerators for now.
>> Because vhost-user currently lacks of an efficient way to share
>> the IOMMU table in VM to vhost backend. That's why the software
>> implementation of virtual IOMMU support in vhost-user backend
>> can't support dynamic mapping well.
> What exactly is meant by that? vIOMMU seems to work for people,
> it's not that fast if you change mappings all the time,
> but e.g. dpdk within guest doesn't.

Yes, software implementation support dynamic mapping for sure. I think 
the point is, current vhost-user backend can not program hardware IOMMU. 
So it can not let hardware accelerator to cowork with software vIOMMU. I 
think that's another call to implement the offloaded path inside qemu 
which has complete support for vIOMMU co-operated VFIO.

Thanks

>
>> Once this problem is solved
>> in vhost-user, virtual IOMMU can be supported by accelerators
>> too, and the IOMMU feature bit checking in this patch can be
>> removed.
> Given it works with software backends right now, I suspect
> this will be up to you guys to address.
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

