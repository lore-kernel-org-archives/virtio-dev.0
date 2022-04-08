Return-Path: <virtio-dev-return-9406-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CF487986522
	for <virtio-dev@lists.oasis-open.org>; Fri,  8 Apr 2022 17:51:17 +0000 (UTC)
Message-ID: <58a4e70c-a0a8-d52c-4bc6-dd4037da1ce0@bytedance.com>
Date: Fri, 8 Apr 2022 18:51:15 +0100
MIME-Version: 1.0
References: <20220330152659.3780600-1-usama.arif@bytedance.com>
 <20220330152659.3780600-4-usama.arif@bytedance.com>
 <YkrmU/w46Fz9EVqT@stefanha-x1.localdomain>
From: Usama Arif <usama.arif@bytedance.com>
In-Reply-To: <YkrmU/w46Fz9EVqT@stefanha-x1.localdomain>
Subject: [virtio-dev] Re: [PATCH 3/4] content: Introduce driver/device auxiliary
 notifications for MMIO
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, mst@redhat.com, ndragazis@arrikto.com, fam.zheng@bytedance.com, liangma@liangbit.com
List-ID: <virtio-dev.lists.oasis-open.org>



On 04/04/2022 13:36, Stefan Hajnoczi wrote:
> On Wed, Mar 30, 2022 at 04:26:58PM +0100, Usama Arif wrote:
>> @@ -2074,6 +2077,16 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
>>       apply to the queue selected by writing to \field{QueueSel}.
>>     }
>>     \hline
>> +  \mmioreg{DeviceAuxiliaryNotification}{Device Auxiliary Notifier}{0xd0}{W}{
>> +    Writing a value to this register triggers a
>> +    notification to the device. The value written to this register is
>> +    interpreted as a device auxiliary notification index. The mapping of device auxiliary notifications to
>> +    device auxiliary notification indices is device-specific. One possible mapping would be
>> +    to use the integers 0 to N-1 as the device auxiliary notification indices for a total of
>> +    N device auxiliary notifications. The total number of device auxiliary notifications exposed by the device is
>> +    also device-specific.
>> +  }
> 
> Hmm...this is slightly different from the PCI transport's approach.
> There each dev aux notification has its own hardware register. That has
> advantages:
> 1. The notification may carry a value with it because the driver writes
>     a value to the register and the device can interpret that value. That
>     can be used as a performance optimization to reduce the number of
>     hardware register writes performed by the driver or DMA transfers
>     initiated by the device.
> 2. The dev aux notification registers can be laid out on separate memory
>     pages. This is useful in passthrough scenarios like nested
>     virtualization or slicing up a device in software and passing a
>     subset to an untrusted process. The MMU only offers page-level
>     protection, so MMIO registers that are colocated within the same
>     memory page cannot be selectively passed through to untrusted
>     software.
> 
> It would be nice if PCI and MMIO exposed dev aux notifications in a
> similar way.
> 
> I haven't followed the history of virtio-mmio closely, so I'm not sure
> if the same approach that was used for PCI is feasible here. Maybe
> someone else can comment?
> 
> Stefan


Agree with the points above. I have split the mmio implementation into 2 
registers in v2. DeviceAuxNotificationIndex to indicate the device 
auxiliary notification index and DeviceAuxNotificationData writing to 
which actually does the notification and carries the data which is 
device specific.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

