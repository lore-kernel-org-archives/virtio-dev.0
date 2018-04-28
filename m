Return-Path: virtio-dev-return-4003-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 56CB21CB80F1
	for <virtio-dev@lists.oasis-open.org>; Fri, 27 Apr 2018 20:50:31 -0700 (PDT)
From: Jason Wang <jasowang@redhat.com>
References: <20180428022356.29355-1-tiwei.bie@intel.com>
 <2cebdb43-e0ca-8d73-1a23-4e88436d01d4@redhat.com>
 <20180428031906.th74iy423bdvj4xd@debian>
 <660383d0-7bab-d8eb-d8e1-61f657787a23@redhat.com>
Message-ID: <d487677d-ca47-895e-9e1e-da4fea890248@redhat.com>
Date: Sat, 28 Apr 2018 11:50:13 +0800
MIME-Version: 1.0
In-Reply-To: <660383d0-7bab-d8eb-d8e1-61f657787a23@redhat.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [virtio-dev] [PATCH v1] VIRTIO_F_IO_BARRIER: use I/O barriers in
 driver
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: mst@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, virtio-dev@lists.oasis-open.org, dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>



On 2018年04月28日 11:22, Jason Wang wrote:
>
>
> On 2018年04月28日 11:19, Tiwei Bie wrote:
>> On Sat, Apr 28, 2018 at 11:01:55AM +0800, Jason Wang wrote:
>>> On 2018年04月28日 10:23, Tiwei Bie wrote:
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
>>>> ---
>>>> RFC -> v1:
>>>> - Use plural (Stefan);
>>>> - Add more details (Stefan);
>>>>
>>>>    content.tex | 14 ++++++++++++++
>>>>    1 file changed, 14 insertions(+)
>>>>
>>>> diff --git a/content.tex b/content.tex
>>>> index ae5fa4c..a1c09c4 100644
>>>> --- a/content.tex
>>>> +++ b/content.tex
>>>> @@ -5445,6 +5445,13 @@ Descriptors} and \ref{sec:Packed Virtqueues 
>>>> / Indirect Flag: Scatter-Gather Supp
>>>>      that drivers pass extra data (besides identifying the Virtqueue)
>>>>      in their device notifications.
>>>>      See \ref{sec:Virtqueues / Driver 
>>>> notifications}~\nameref{sec:Virtqueues / Driver notifications}.
>>>> +  \item[VIRTIO_F_IO_BARRIER(37)] This feature indicates that the 
>>>> device
>>>> +  needs the driver to use the barriers suitable for hardware devices.
>>> Users may ask what the specific kinds of barrier here (e.g mmio 
>>> barrier or
>>> dma barrier). Do we need to clarify that?
>> IMO it's very obvious that we need all types of barriers used
>> in the driver should be able to work with hardware devices.
>>
>> Best regards,
>> Tiwei Bie
>>
>
> Just in case I do not miss anything, is mmio barrier really needed? I 
> believe what we need is on dma barrier here.
>
> Thanks
>

Ok, I think I get your meaning here. Driver should choose to use 
appropriate barriers though mmio barriers is not necessary for current 
virito. So it looks fine to me.

Thanks



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

