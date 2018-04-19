Return-Path: virtio-dev-return-3890-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 1FDF358191A2
	for <virtio-dev@lists.oasis-open.org>; Thu, 19 Apr 2018 09:59:59 -0700 (PDT)
References: <20180412151232.17506-1-tiwei.bie@intel.com>
 <20180412151232.17506-7-tiwei.bie@intel.com>
 <20180418192154-mutt-send-email-mst@kernel.org>
 <20180419111439.i6gfhnept6wy7uzp@debian>
 <D0158A423229094DA7ABF71CF2FA0DA34E94E895@SHSMSX104.ccr.corp.intel.com>
 <20180419182035-mutt-send-email-mst@kernel.org>
 <f123c3a5-f7a3-a0e3-ffc7-b57e19610a9b@redhat.com>
 <D0158A423229094DA7ABF71CF2FA0DA34E950C67@SHSMSX104.ccr.corp.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <28ab1675-15ae-dab4-fd71-7632666f57fc@redhat.com>
Date: Thu, 19 Apr 2018 18:59:39 +0200
MIME-Version: 1.0
In-Reply-To: <D0158A423229094DA7ABF71CF2FA0DA34E950C67@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] RE: [PATCH v3 6/6] vhost-user: support registering
 external host notifiers
To: "Liang, Cunming" <cunming.liang@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Bie, Tiwei" <tiwei.bie@intel.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Daly, Dan" <dan.daly@intel.com>, "Tan, Jianfeng" <jianfeng.tan@intel.com>, "Wang, Zhihong" <zhihong.wang@intel.com>, "Wang, Xiao W" <xiao.w.wang@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 19/04/2018 18:52, Liang, Cunming wrote:
>>> Oh you are right.
>>> 
>>> So it's only needed for non-intel platforms or when packets are
>>> in WC memory then. And I don't know whether dpdk ever puts
>>> packets in WC memory.
>>> 
>>> I guess we'll cross this bridge when we get to it.
>> Non-TSO architectures seem important...
>
> I'm not familiar with Non-TSO, trying to understand the difference
> according to the feature set. Let's say non-TSO architectures do not
> set 'weak_barriers'. Then mandatory barrier is used for software. HW
> offload on that platform would choose different feature set against
> software? If it's not, essentially we're worried about live migration
> from a TSO to a non-TSO architectures platform?

I'm worried about live migration from software virtio to hardware virtio
on non-TSO architectures.  For example, on ARM you would have a "dmb
ishst" (smp_wmb) for software virtio and a "dsb st" (wmb) or "dmb oshst"
(dma_wmb) for hardware virtio.

For this to work, you would have to set up the VM so that it uses the
heavier barriers from the beginning, even when backed by software virtio.

Paolo

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

