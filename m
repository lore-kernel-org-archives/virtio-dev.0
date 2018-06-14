Return-Path: virtio-dev-return-4381-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 1163358191F2
	for <virtio-dev@lists.oasis-open.org>; Wed, 13 Jun 2018 20:30:25 -0700 (PDT)
References: <20180510154126.4062-1-tiwei.bie@intel.com>
 <20180515153751-mutt-send-email-mst@kernel.org>
 <20180516011944.GA2495@debian>
 <20180614032256-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <428675c0-a46b-4313-396c-feff80ecb9b1@redhat.com>
Date: Thu, 14 Jun 2018 11:30:02 +0800
MIME-Version: 1.0
In-Reply-To: <20180614032256-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [virtio-dev] Re: [PATCH v3] VIRTIO_F_IO_BARRIER: use I/O barriers
 in driver
To: "Michael S. Tsirkin" <mst@redhat.com>, Tiwei Bie <tiwei.bie@intel.com>
Cc: pbonzini@redhat.com, stefanha@redhat.com, virtio-dev@lists.oasis-open.org, dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>



On 2018年06月14日 08:24, Michael S. Tsirkin wrote:
> On Wed, May 16, 2018 at 09:19:44AM +0800, Tiwei Bie wrote:
>> On Tue, May 15, 2018 at 03:39:02PM +0300, Michael S. Tsirkin wrote:
>>> On Thu, May 10, 2018 at 11:41:26PM +0800, Tiwei Bie wrote:
>>>> There will be hardware virtio devices in the future, which
>>>> require drivers to use the barriers suitable for I/O devices,
>>>> compared with software virtio devices which just require
>>>> drivers to use the barriers suitable for CPU cores.
>>>>
>>>> To fix the ordering issue for hardware virtio devices, add
>>>> a new feature: VIRTIO_F_IO_BARRIER. When negotiated, driver
>>>> will use the barriers suitable for I/O devices.
>>>>
>>>> Signed-off-by: Tiwei Bie<tiwei.bie@intel.com>
>>>> Reviewed-by: Stefan Hajnoczi<stefanha@redhat.com>
>>> When you are ready, please open a github issue, then
>>> send Fixes: tag in a response to this mail, asking
>>> to start voting.
>> Got it! Thank you very much!
>>
>> Best regards,
>> Tiwei Bie
> I have a question: an upstream discussion recently
> touched on the subject of need to use bounce buffers
> in special memory, flush cache, or do other tricks
> for DMA.
>
> Do we want to extend this flag to cover that behaviour
> as well? If yes should we rename it and tweak the
> definition? Or should do something else?

Looks not, will device behave differently if we have it?

So it looks to me it was more a platform or software stuffs that could 
be handled by driver itself.

Thanks

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

