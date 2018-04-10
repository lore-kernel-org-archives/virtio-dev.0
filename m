Return-Path: virtio-dev-return-3774-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 1A9AF58191AE
	for <virtio-dev@lists.oasis-open.org>; Tue, 10 Apr 2018 00:53:28 -0700 (PDT)
References: <20180402152330.4158-1-tiwei.bie@intel.com>
 <622f4bd7-1249-5545-dc5a-5a92b64f5c26@redhat.com>
 <20180410045723.rftsb7l4l3ip2ioi@debian>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7ee31a12-a370-fc43-82a6-2235f598e970@redhat.com>
Date: Tue, 10 Apr 2018 09:51:43 +0200
MIME-Version: 1.0
In-Reply-To: <20180410045723.rftsb7l4l3ip2ioi@debian>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] Re: [RFC] vhost: introduce mdev based hardware vhost
 backend
To: Tiwei Bie <tiwei.bie@intel.com>, Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, alex.williamson@redhat.com, ddutile@redhat.com, alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com, jianfeng.tan@intel.com, xiao.w.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 10/04/2018 06:57, Tiwei Bie wrote:
>> So you just move the abstraction layer from qemu to kernel, and you still
>> need different drivers in kernel for different device interfaces of
>> accelerators. This looks even more complex than leaving it in qemu. As you
>> said, another idea is to implement userspace vhost backend for accelerators
>> which seems easier and could co-work with other parts of qemu without
>> inventing new type of messages.
> 
> I'm not quite sure. Do you think it's acceptable to
> add various vendor specific hardware drivers in QEMU?

I think so.  We have vendor-specific quirks, and at some point there was
an idea of using quirks to implement (vendor-specific) live migration
support for assigned devices.

Paolo

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

