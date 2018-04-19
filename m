Return-Path: virtio-dev-return-3881-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 550D458191A0
	for <virtio-dev@lists.oasis-open.org>; Thu, 19 Apr 2018 08:52:45 -0700 (PDT)
References: <20180412151232.17506-1-tiwei.bie@intel.com>
 <20180412151232.17506-7-tiwei.bie@intel.com>
 <20180418192154-mutt-send-email-mst@kernel.org>
 <20180419111439.i6gfhnept6wy7uzp@debian>
 <D0158A423229094DA7ABF71CF2FA0DA34E94E895@SHSMSX104.ccr.corp.intel.com>
 <20180419182035-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f123c3a5-f7a3-a0e3-ffc7-b57e19610a9b@redhat.com>
Date: Thu, 19 Apr 2018 17:52:23 +0200
MIME-Version: 1.0
In-Reply-To: <20180419182035-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v3 6/6] vhost-user: support registering external host
 notifiers
To: "Michael S. Tsirkin" <mst@redhat.com>, "Liang, Cunming" <cunming.liang@intel.com>
Cc: "Bie, Tiwei" <tiwei.bie@intel.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Daly, Dan" <dan.daly@intel.com>, "Tan, Jianfeng" <jianfeng.tan@intel.com>, "Wang, Zhihong" <zhihong.wang@intel.com>, "Wang, Xiao W" <xiao.w.wang@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 19/04/2018 17:42, Michael S. Tsirkin wrote:
>> A compiler barrier is enough on strongly-ordered memory platform.
>> As it doesn't re-order store, PCI device won't see a stale index
>> value. But a weakly-ordered memory needs sfence.
> 
> Oh you are right.
> 
> So it's only needed for non-intel platforms or when packets are in
> WC memory then. And I don't know whether dpdk ever puts packets in WC
> memory.
> 
> I guess we'll cross this bridge when we get to it.

Non-TSO architectures seem important...

Paolo

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

