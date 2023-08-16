Return-Path: <virtio-dev-return-13561-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2149C001B0
	for <virtio-dev@archiver.kernel.org>; Wed, 16 Aug 2023 04:53:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1E02E33590
	for <virtio-dev@archiver.kernel.org>; Wed, 16 Aug 2023 04:53:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0D33F98642C
	for <virtio-dev@archiver.kernel.org>; Wed, 16 Aug 2023 04:53:42 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id F3CEF9863D8; Wed, 16 Aug 2023 04:53:41 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E014B9863D1;
	Wed, 16 Aug 2023 04:53:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="371350133"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="371350133"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="1064685062"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="1064685062"
Message-ID: <7e85c213-2835-4d2b-ec3a-d94f169ccb9b@intel.com>
Date: Wed, 16 Aug 2023 12:53:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, eperezma@redhat.com, cohuck@redhat.com,
 virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
References: <20230814192904.30062-1-lingshan.zhu@intel.com>
 <20230814192904.30062-4-lingshan.zhu@intel.com>
 <CACGkMEuS8xnKi8Nh10T4KCXCYSa-yYmN5X+=ZkCHUrb0jbH-XA@mail.gmail.com>
 <2ddf1100-9230-70e3-d641-d2dcda380694@intel.com>
 <CACGkMEtDqHPDwXKy09fgmhZ2yywF2061W0g-RDZwx7Lv5AtBLg@mail.gmail.com>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <CACGkMEtDqHPDwXKy09fgmhZ2yywF2061W0g-RDZwx7Lv5AtBLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] Re: [RFC PATCH 3/5] virtio: The actions by the
 device upon SUSPEND



On 8/16/2023 10:10 AM, Jason Wang wrote:
> On Tue, Aug 15, 2023 at 7:17 PM Zhu, Lingshan <lingshan.zhu@intel.com> wrote:
>>
>>
>> On 8/15/2023 8:29 AM, Jason Wang wrote:
>>> On Mon, Aug 14, 2023 at 7:29 PM Zhu Lingshan <lingshan.zhu@intel.com> wrote:
>>>> This commit specifies the actions to be taken by the device upon
>>>> SUSPEND.
>>>>
>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>>> Signed-off-by: Eugenio PÃrez <eperezma@redhat.com>
>>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>>>> ---
>>>>    content.tex | 9 +++++++++
>>>>    1 file changed, 9 insertions(+)
>>>>
>>>> diff --git a/content.tex b/content.tex
>>>> index 074f43e..43bd5de 100644
>>>> --- a/content.tex
>>>> +++ b/content.tex
>>>> @@ -96,6 +96,15 @@ \section{\field{Device Status} Field}\label{sec:Basic Facilities of a Virtio Dev
>>>>    If VIRTIO_F_SUSPEND is negotiated and SUSPEND is set, the device MUST clear SUSPEND
>>>>    and resumes operation upon DRIVER_OK.
>>>>
>>>> +If VIRTIO_F_SUSPEND is negotiated, when SUSPEND is set, the device MUST perform the following operations:
>>>> +\begin{itemize}
>>>> +\item Stop comsuming any descriptors
>>> Typo.
>> yes will fix
>>>> +\item Mark all finished descriptors as used and send used buffer notification to the driver
>>> What happens to the unfinished descriptors?
>> still in the descriptors table or considered as in-flight, we will post
>> a patch tracking in-flight descriptors.
> So I think we should either
>
> 1) add in-flight descriptors in this series
>
> or
>
> 2) force a flush
>
> To make sure the new proposed function is complete.
Yes, will fix in the next version: The device must wait for the 
descriptors and flush the buffers.
>
>>>> +\item Record Virtqueue State of each enabled virtqueue, see section \ref{sec:Virtqueues / Virtqueue State}
>>> This basically means those states are only available after suspending
>>> or not? It would be still useful for debugging if we allow it without
>>> suspending.
>> Yes, for now only allow to read/write the virtqueue state after setting
>> SUSPEND, this is to avoid race conditions with the device.
> For debugging, we don't need to care about those races. A lot of
> hardware allow to expose those via e.g ethtool.
How about we allow read vq state without SUSPEND and forbid write vq state?
>
>> Still can suspend then collect the idx for debugging?
> I mean for runtime debugging.
>
>>>> +\item Pause its operation and preserve all configurations in its Device Configuration Space, see \ref{sec:Basic Facilities of a Virtio Device / Device Configuration Space}
>>> We probably need to define the "pause" here (e.g what happens to the
>>> inflight descriptors).
>> Shall we say: freeze both its data-plane and control-plane?
> I mean if we've defined "suspend" we can simply use "suspend" instead
> of "pause"?
This section defines SUSPEND behaviors, so actually SUSPEND is defined here.
so if we use suspend in the inner text, looks like a circular reasoning.

Thanks
>
> Thanks
>
>>> Thanks
>>>
>>>> +\item Present SUSPEND in \field{device status}
>>>> +\end{itemize}
>>>> +
>>>>    \section{Feature Bits}\label{sec:Basic Facilities of a Virtio Device / Feature Bits}
>>>>
>>>>    Each virtio device offers all the features it understands.  During
>>>> --
>>>> 2.35.3
>>>>
>>> ---------------------------------------------------------------------
>>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>>>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

