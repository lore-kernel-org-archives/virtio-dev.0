Return-Path: <virtio-dev-return-13574-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C121C7112B
	for <virtio-dev@archiver.kernel.org>; Fri, 18 Aug 2023 09:55:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9FF87CB150
	for <virtio-dev@archiver.kernel.org>; Fri, 18 Aug 2023 09:55:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 99CA0986547
	for <virtio-dev@archiver.kernel.org>; Fri, 18 Aug 2023 09:55:57 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8D184986449; Fri, 18 Aug 2023 09:55:57 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7AC2B98643F;
	Fri, 18 Aug 2023 09:55:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="436974483"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="436974483"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="805092679"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="805092679"
Message-ID: <cc054fd2-7262-32ef-8512-0b801fbc2334@intel.com>
Date: Fri, 18 Aug 2023 17:55:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, cohuck@redhat.com,
 virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
References: <20230814192904.30062-1-lingshan.zhu@intel.com>
 <20230814192904.30062-2-lingshan.zhu@intel.com>
 <20230814143039.GD3146793@fedora>
 <56c6411d-2ee9-f2c2-4da7-8d708f7729a2@intel.com>
 <20230815122916.GA3235352@fedora>
 <CAJaqyWd4a94FHMxAEKrQ+wpWiFECBLrWRhp24f5uYf=6TDwL+Q@mail.gmail.com>
 <20230817160440.GA3605166@fedora>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <20230817160440.GA3605166@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] [RFC PATCH 1/5] virtio: introduce SUSPEND bit in
 device status



On 8/18/2023 12:04 AM, Stefan Hajnoczi wrote:
> On Thu, Aug 17, 2023 at 05:15:16PM +0200, Eugenio Perez Martin wrote:
>> On Tue, Aug 15, 2023 at 2:29 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>>> On Tue, Aug 15, 2023 at 06:31:23PM +0800, Zhu, Lingshan wrote:
>>>>
>>>> On 8/14/2023 10:30 PM, Stefan Hajnoczi wrote:
>>>>> On Tue, Aug 15, 2023 at 03:29:00AM +0800, Zhu Lingshan wrote:
>>>>>> This patch introudces a new status bit in the device status: SUSPEND.
>>>>>>
>>>>>> This SUSPEND bit can be used by the driver to suspend a device,
>>>>>> in order to stablize the device states and virtqueue states.
>>>>>>
>>>>>> Its main use case is live migration.
>>>>>>
>>>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>>>>> Signed-off-by: Eugenio PÃrez <eperezma@redhat.com>
>>>>> There is an character encoding issue in Eugenio's surname.
>>>> Oh, I copied his SOB form his email, I will copy from git log to fix this,
>>>> thanks for point out it.
>>>>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>>>>>> ---
>>>>>>    content.tex | 18 ++++++++++++++++++
>>>>>>    1 file changed, 18 insertions(+)
>>>>> This patch hints at the asynchronous nature of the SUSPEND bit (the
>>>>> driver must re-read the Device Status Field) but doesn't explain the
>>>>> rationale or any limits.
>>>>>
>>>>> For example, is there a timeout or should the driver re-read the Device
>>>>> Status Field forever?
>>>> It depends on the driver, normally we expect this operation can be done
>>>> successfully
>>>> like how the driver/device handles FEATURES_OK.
>>>>
>>>> Once failed due to:
>>>> 1) driver timeout, the driver can reset the device
>>>> 2) device failure, the device can set NEEDS_RESET.
>>> I mention this because SUSPEND involves quiescing the device so that no
>>> requests are in flight and that can take an unbounded amount of time on
>>> a virtio-blk, virtio-scsi, or virtiofs device. If the driver is busy
>>> waiting for the device to report the SUSPEND bit, then that could take a
>>> long time/forever.
>>>
>>> Imagine a virtiofs PCI device implemented in hardware that forwards I/O
>>> to a distributed storage system. If the distributed storage system has a
>>> request in flight then SUSPEND needs to wait for it to complete. The
>>> device has no control over how long that will take, but if it does not
>>> then corruption could occur later on.
>>>
>>> There are two issues with long SUSPEND times:
>>> 1. Busy wait CPU consumption. Since there is no interrupt that signals
>>>     when the bit is set, the best a driver can do is to back off
>>>     gradually and use timers to avoid hogging the CPU.
>>> 2. Synchronous blocking. If the call stack that led the driver to set
>>>     SUSPEND is blocked until the device reports the SUSPEND bit, then
>>>     other parts of the system could experience blocking. For example, the
>>>     VMM might be blocked in a vhost ioctl() call, which makes the guest
>>>     unresponsive.
>>>
>> I think all of this already happens with ring reset or even a plain
>> device reset, doesn't it?
> Yes, but keep in mind that the driver has typically already drained
> requests when it invokes reset. If SUSPEND is used transparently during
> live migration then there really will be requests in flight because the
> guest driver is unaware.
I agree, and as discussed before, I think in this series we should say:
the device MUST wait untilall descriptors that being processed to finish 
and mark them as used.

Then in the following series, we should implement in-flight IO tracker.
>
>> In my opinion the best thing the device can do here is to fail the
>> request after a certain time, the same way it would fail if the
>> backend distributed storage system gets disconnected or latency gets
>> out of bounds.
> In order to prevent corruption there needs to be a fence in addition to
> a timeout. In other words, the storage backend needs to guarantee that
> any requests sent before the fence will be ignored if they are still
> encountered.
Please correct me if I misunderstand anything.

I am not sure a remote target is aware of SUSPEND, but the device can
fail SUSPEND by setting NEEDS_RESET for sure. IN this series,
maybe it is best to flush and wait for the IO requests.
>
>>> Making SUSPEND asynchronous is more complicated but would allow long
>>> SUSPEND times to be handled gracefully.
>>>
>> Maybe that should be the direction of the transport vq, so transport
>> commands are asynchronous and we get rid of all the similar problems
>> in one shot?
> Yes, a transport virtqueue would make this operation asynchronous.
I agree

Thanks
Zhu Lingshan
>
> Stefan
>
>> Thanks!
>>
>>>>> Does the driver need to re-read the Device Status Field after clearing
>>>>> the SUSPEND bit?
>>>> I think the driver should re-read, I will add this in the next version.
>>>>>> diff --git a/content.tex b/content.tex
>>>>>> index 0a62dce..1bb4401 100644
>>>>>> --- a/content.tex
>>>>>> +++ b/content.tex
>>>>>> @@ -47,6 +47,9 @@ \section{\field{Device Status} Field}\label{sec:Basic Facilities of a Virtio Dev
>>>>>>    \item[DRIVER_OK (4)] Indicates that the driver is set up and ready to
>>>>>>      drive the device.
>>>>>> +\item[SUSPEND (16)] When VIRTIO_F_SUSPEND is negotiated, indicates that the
>>>>>> +  device has been suspended by the driver.
>>>>>> +
>>>>>>    \item[DEVICE_NEEDS_RESET (64)] Indicates that the device has experienced
>>>>>>      an error from which it can't recover.
>>>>>>    \end{description}
>>>>>> @@ -73,6 +76,10 @@ \section{\field{Device Status} Field}\label{sec:Basic Facilities of a Virtio Dev
>>>>>>    recover by issuing a reset.
>>>>>>    \end{note}
>>>>>> +The driver MUST NOT set SUSPEND if FEATURES_OK is not set.
>>>>>> +
>>>>>> +When set SUSPEND, the driver MUST re-read \field{device status} to ensure the SUSPEND bit is set.
>>>>> "When setting SUSPEND, ..." would be grammatically correct. Another
>>>>> option is "After setting the SUSPEND bit, ...".
>>>> Will fix in the next version.
>>>>>> +
>>>>>>    \devicenormative{\subsection}{Device Status Field}{Basic Facilities of a Virtio Device / Device Status Field}
>>>>>>    The device MUST NOT consume buffers or send any used buffer
>>>>>> @@ -82,6 +89,13 @@ \section{\field{Device Status} Field}\label{sec:Basic Facilities of a Virtio Dev
>>>>>>    that a reset is needed.  If DRIVER_OK is set, after it sets DEVICE_NEEDS_RESET, the device
>>>>>>    MUST send a device configuration change notification to the driver.
>>>>>> +The device MUST ignore SUSPEND if FEATURES_OK is not set.
>>>>>> +
>>>>>> +The deivce MUST ignore SUSPEND if VIRTIO_F_SUSPEND is not negotiated.
>>> I noticed a typo:
>>> "device MUST"
>>>
>>>>>> +
>>>>>> +If VIRTIO_F_SUSPEND is negotiated and SUSPEND is set, the device MUST clear SUSPEND
>>>>>> +and resumes operation upon DRIVER_OK.
>>>>> I can't parse this sentence. If the driver writes SUSPEND | DRIVER_OK |
>>>>> ... to the Device Status Field, then the device accepts DRIVER_OK and
>>>>> clears SUSPEND?
>>>>>
>>>>> Why?
>>>> I expect DRIVER_OK can clear SUSPEND, so that the device can resume running
>>>> in case of a failed live migration.
>>>>
>>>> Maybe I should say: DRIVER_OK clears SUSPEND, and if DRIVER_OK is set to
>>>> a suspended device, the device should resume operation
>>> It's confusing because there are other Device Status Field bits aside
>>> from DRIVER_OK. I wasn't sure what you meant.
>>>
>>> I think this is really saying that devices must support the SUSPEND ->
>>> !SUSPEND transition. It's not really about DRIVER_OK because that bit
>>> will be set the entire time (!SUSPEND -> SUSPEND -> !SUSPEND).
>>>
>>> Can you rephrase it? For example:
>>>
>>>    If VIRTIO_F_SUSPEND is negotiated and SUSPEND is set, the device MUST
>>>    resume operation when the driver clears the SUSPEND bit.
>>>
>>> Stefan


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

