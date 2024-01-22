Return-Path: <virtio-dev-return-14258-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72458C47DD3
	for <virtio-dev@archiver.kernel.org>; Mon, 22 Jan 2024 02:57:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C4530429AB
	for <virtio-dev@archiver.kernel.org>; Mon, 22 Jan 2024 02:57:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B391E986688
	for <virtio-dev@archiver.kernel.org>; Mon, 22 Jan 2024 02:57:39 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A4765985F66; Mon, 22 Jan 2024 02:57:39 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4D4E69863B6;
	Mon, 22 Jan 2024 02:57:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W.0LMOS_1705892235;
Message-ID: <db56402e-2432-4902-b58d-6b43a4f1dd0e@linux.alibaba.com>
Date: Mon, 22 Jan 2024 10:57:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Parav Pandit <parav@nvidia.com>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <1705323962-96063-1-git-send-email-hengqi@linux.alibaba.com>
 <PH0PR12MB5481EA21646CEA571FF2D3F9DC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <3977e2c2-f514-4b51-a646-6f729df7403d@linux.alibaba.com>
 <DM8PR12MB5480872B5E7A67D65325485BDC772@DM8PR12MB5480.namprd12.prod.outlook.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <DM8PR12MB5480872B5E7A67D65325485BDC772@DM8PR12MB5480.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] RE: [virtio-dev] RE: [virtio-comment] [PATCH v2]
 virtio-net: support setting coalescing params for multiple vqs



在 2024/1/20 下午5:59, Parav Pandit 写道:
>> From: Heng Qi <hengqi@linux.alibaba.com>
>> Sent: Wednesday, January 17, 2024 10:22 AM
>>
>> 在 2024/1/15 下午9:21, Parav Pandit 写道:
>>>> From: virtio-comment@lists.oasis-open.org
>>>> <virtio-comment@lists.oasis- open.org> On Behalf Of Heng Qi
>>>> Sent: Monday, January 15, 2024 6:36 PM
>>>>
>>>> Currently, when each time the driver attempts to update the
>>>> coalescing parameters for a vq, it needs to kick the device and wait
>>>> for the ctrlq response to return.
>>> It does not need to wait. This is some driver limitation that does not use
>> the queue as "queue".
>>> Such driver limitation should be removed in the driver. It does not qualify
>> as limitation.
>>
>> Yes, we don't have to wait.
>>
>> But in general, for user commands, it is necessary to obtain the final results
>> synchronously.
> Yes. Use initiated command can enqueue the request to cvq. Go to sleep for several micro to milliseconds.
>
>> The user command cannot return before the final result is obtained.
>> And wait is not the problem this patch solves.
>>
> By not holding the rtnl lock, rest of the context that needs to enqueue the request can progress such as that of netdim.

Would like to see the using of rtnl lock changed.

In addition, I have made batching and asynchronousization of the netdim 
command, you can refer to this patch:
https://lore.kernel.org/all/1705410693-118895-4-git-send-email-hengqi@linux.alibaba.com/

>
>>> This will enable driver to enqueue multiple cvq commands without waiting
>> for previous one.
>>> This will also enable device to find natural coalescing done on multiple
>> commands.
>>
>> When batch user commands occur, ensuring synchronization is a concern.
>>
>>>> The following path is observed: 1. Driver kicks the device; 2. After
>>>> the device receives the kick, CPU scheduling occurs and DMA multiple
>>>> buffers multiple times; 3. The device completes processing and replies
>> with a response.
>>>> When large-queue devices issue multiple requests and kick the device
>>>> frequently, this often interrupt the work of the device-side CPU.
>>> When there is large devices and multiple driver notifications by a cpu
>>> that is N times faster than the device side cpu, the device may find natural
>> coalescing on the commands of a given cvq.
>>
>> First we have to solve the ctrlq batch adding user (ethtool) command.
>> Even if processed in a batch way on device side, the number of kicks and the
>> number of backend DMAs has not been reduced.
> Driver notifications are PCI writes so it should not hamper device side, which can ignore them when they do not bother about it.

Driver notifications need to be processed by the DPU, which interferes 
with the CPU on the DPU.

> Backend DMAs should be reduced by avoiding the LIFO pattern followed by the splitq driver.
> Placing the descriptors contiguously like packedq reduces amount of DMA naturally.

splitq is widely used, migrating to packedq is not that easy, especially 
when there are many components and hardware involved.

>
> The second predicable DMA to avoid is having 8Bytes of data inline in the descriptor, instead of 16B indirection and extra dma.

Looking forward to working inline!
But I think this does not conflict with batch work, and combining the 
two will be more beneficial.

>
>>> For multiple DMAs, we need to way to send 8 bytes of data without 16
>> bytes of indirection via a descriptor.
>>> This is what we discussed a while back to do in txq and Stefan suggested to
>> generalize for more queues, which is also a good idea.
>>
>> Yes, this sounds good.
>>
> This the next item to focus as soon as flow filters are stable/merged.

Greate!

>   
>>>> In addition,
>>>> each vq request is processed separately, causing more delays for the
>>>> CPU to wait for the DMA request to complete.
>>>>
>>>> These interruptions and overhead will strain the CPU responsible for
>>>> controlling the path of the DPU, especially in multi-device and
>>>> large-queue scenarios.
>>>>
>>>> To solve the above problems, we internally tried batch request, which
>>>> merges requests from multiple queues and sends them at once. We
>>>> conservatively tested
>>> The batching done may end up modifying the given VQ's parameters
>> multiple times.
>>
>> In practice, we do not try to accumulate multiple parameter modifications for
>> a specific vqn.
> I meant to accumulate parameters of multiple VQs to batch in single command.

Yes, this is what is done now, practical example: 
https://lore.kernel.org/all/1705410693-118895-3-git-send-email-hengqi@linux.alibaba.com/
In our scenario, only benefits are seen, no negative effects.

>
>>> The right test on Linux to do without rtnl lock which is anyway ugly and
>> wrong semantic to use blocking the whole netdev stack.
>>> (in case if you used that).
>> Do you have any good directions and attempts to remove rtnl_lock?
>>
> I think per device lock instead of rtnl is first step that we can start with.

Totally looking forward to it.

Thanks,
Heng

>   
>>>> 8 queue commands and sent them together. The DPU processing
>>>> efficiency can be improved by 8 times, which greatly eases the DPU's
>>>> support for multi- device and multi-queue DIM.
>>>>
>>> This is good.
>> YES. Makes sense for our DPUs.
>>
>>>> Maintainers may be concerned about whether the batch command
>> method
>>>> can optimize the above problems: accumulate multiple request
>> commands
>>>> to kick the device once, and obtain the processing results of the
>>>> corresponding commands asynchronously.
>>> This is unlikely to improve, rather it will have negative impact as it only
>> means that moderation parameters are just delayed by the driver.
>> Why is it delayed by the driver? It is not delayed by the driver, the kick still
>> happens for every command.
> Since the kick is delayed, the driver lost the amount of time and device reaction time is driven by this wait time.
> The guest driver is not aware how much a shared DPU is busy.
> So if it waits too much, the VQs moderation is slow.
>
>> In theory and practice, it will not affect DIM performance, but it will
>> significantly reduce CPU consumption caused by waiting.
>>
> Once the guest driver sleeps after enqueuing the request, it should be fine.
> The DIM calls are in highly parallel worker threads, where/if the thread sleep, a new worker thread is invoked.
>
> But for sure I agree that vq notification moderation should happen quickly enough under < 100usec or so.
> May be now that we bring the aq resources, we can start migrating on it.
>
>>>> The batch command method is used by us to optimize the CPU overhead
>>>> of the DIM worker caused by the guest being busy waiting for the
>>>> command response result.
>>> In that case fixing the guest driver which is not yet written is the right fix.
>>>
>>>> This is a different focus than batch request to solve the problem.
>>>>
>>>> Suggested-by: Xiaoming Zhao <zxm377917@alibaba-inc.com>
>>>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
>>>> ---
>>>> v1->v2: Updated commit log. Due to sensitivity, sorry that can not
>>>> v1->give the
>>>>       absolute value directly. @Michael
>>>>
>>>>    device-types/net/description.tex | 26 ++++++++++++++++++++------
>>>>    1 file changed, 20 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/device-types/net/description.tex b/device-
>>>> types/net/description.tex index aff5e08..b3766c4 100644
>>>> --- a/device-types/net/description.tex
>>>> +++ b/device-types/net/description.tex
>>>> @@ -1667,8 +1667,8 @@ \subsubsection{Control
>>>> Virtqueue}\label{sec:Device Types / Network Device / Devi  for
>>>> notification coalescing.
>>>>
>>>>    If the VIRTIO_NET_F_VQ_NOTF_COAL feature is negotiated, the driver
>>>> can - send commands VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET and
>>>> VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET -for virtqueue notification
>>>> coalescing.
>>>> +send commands VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET,
>>>> +VIRTIO_NET_CTRL_NOTF_COAL_VQS_SET and
>>>> VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET for virtqueue notification
>>>> coalescing.
>>>>
>>> A new feature bit is needed for this extra functionality.
>> I tried to extend it to the command VIRTIO_NET_F_VQ_NOTF_COAL, is it too
>> late?
>>
> For existing command it is not.
> But there may be a device which may not support coalesced command.
> Better to have the feature bit for this coalesce command, instead of random NOSUPP failure.
>
>   
>> Thanks!
>>
>>>>    \begin{lstlisting}
>>>>    struct virtio_net_ctrl_coal {
>>>> @@ -1682,11 +1682,17 @@ \subsubsection{Control
>>>> Virtqueue}\label{sec:Device Types / Network Device / Devi
>>>>        struct virtio_net_ctrl_coal coal;
>>>>    };
>>>>
>>>> +struct virtio_net_ctrl_mrg_coal_vq {
>>>> +        le16 num_entries; /* indicates number of valid entries */
>>>> +        struct virtio_net_ctrl_coal_vq entries[]; };
>>>> +
>>>>    #define VIRTIO_NET_CTRL_NOTF_COAL 6
>>>>     #define VIRTIO_NET_CTRL_NOTF_COAL_TX_SET  0
>>>>     #define VIRTIO_NET_CTRL_NOTF_COAL_RX_SET 1
>>>>     #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET 2
>>>>     #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET 3
>>>> + #define VIRTIO_NET_CTRL_NOTF_COAL_VQS_SET 4
>>>>    \end{lstlisting}
>>>>
>>>>    Coalescing parameters:
>>>> @@ -1706,6 +1712,7 @@ \subsubsection{Control
>>>> Virtqueue}\label{sec:Device Types / Network Device / Devi  \item For
>>>> the command VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET, the structure
>>>> virtio_net_ctrl_coal_vq is write-only for the driver.
>>>>    \item For the command VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET,
>>>> \field{vq_index} and \field{reserved} are write-only
>>>>          for the driver, and the structure virtio_net_ctrl_coal is
>>>> read-only for the driver.
>>>> +\item For the command VIRTIO_NET_CTRL_NOTF_COAL_VQS_SET, the
>>>> structure virtio_net_ctrl_mrg_coal_vq is write-only for the driver.
>>>>    \end{itemize}
>>>>
>>>>    The class VIRTIO_NET_CTRL_NOTF_COAL has the following commands:
>>>> @@ -1716,6 +1723,9 @@ \subsubsection{Control
>>>> Virtqueue}\label{sec:Device Types / Network Device / Devi
>>>>                                            for an enabled
>>>> transmit/receive virtqueue whose index is \field{vq_index}.
>>>>    \item VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET: use the structure
>>>> virtio_net_ctrl_coal_vq to get the \field{max_usecs} and
>>>> \field{max_packets} parameters
>>>>                                            for an enabled
>>>> transmit/receive virtqueue whose index is \field{vq_index}.
>>>> +\item VIRTIO_NET_CTRL_NOTF_COAL_VQS_SET: use the structure
>>>> virtio_net_ctrl_mrg_coal_vq to set the \field{max_usecs} and
>>>> \field{max_packets} parameters
>>>> +                                         for \field{num_entries}
>>>> + enabled transmit/receive
>>>> virtqueues. The corresponding index value
>>>> +                                         of each configured virtqueue is \field{vq_index}.
>>>>    \end{enumerate}
>>>>
>>>>    The device may generate notifications more or less frequently than
>>>> specified by set commands of the VIRTIO_NET_CTRL_NOTF_COAL class.
>>>> @@ -1782,9 +1792,13 @@ \subsubsection{Control
>>>> Virtqueue}\label{sec:Device Types / Network Device / Devi
>>>>
>>>>    The driver MUST set \field{vq_index} to the virtqueue index of an
>>>> enabled transmit or receive virtqueue.
>>>>
>>>> +The driver MUST set \field{num_entries} to a non-zero value and MUST
>>>> +NOT set \field{num_entries} to a value greater than the number of
>>>> +enabled
>>>> transmit and receive virtqueues.
>>>> +
>>>>    The driver MUST have negotiated the VIRTIO_NET_F_NOTF_COAL
>> feature
>>>> when issuing commands VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and
>>>> VIRTIO_NET_CTRL_NOTF_COAL_RX_SET.
>>>>
>>>> -The driver MUST have negotiated the VIRTIO_NET_F_VQ_NOTF_COAL
>>>> feature when issuing commands VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET
>> and
>>>> VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET.
>>>> +The driver MUST have negotiated the VIRTIO_NET_F_VQ_NOTF_COAL
>>>> feature
>>>> +when issuing commands VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET,
>>>> VIRTIO_NET_CTRL_NOTF_COAL_VQS_SET and
>>>> VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET.
>>>>
>>>>    The driver MUST ignore the values of coalescing parameters received
>>>> from the VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET command if the device
>>>> responds with VIRTIO_NET_ERR.
>>>>
>>>> @@ -1794,10 +1808,10 @@ \subsubsection{Control
>>>> Virtqueue}\label{sec:Device Types / Network Device / Devi
>>>>
>>>>    The device SHOULD respond to VIRTIO_NET_CTRL_NOTF_COAL_TX_SET
>> and
>>>> VIRTIO_NET_CTRL_NOTF_COAL_RX_SET commands with
>> VIRTIO_NET_ERR if it
>>>> was not able to change the parameters.
>>>>
>>>> -The device MUST respond to the
>> VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET
>>>> command with VIRTIO_NET_ERR if it was not able to change the
>> parameters.
>>>> +The device MUST respond to VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET
>> and
>>>> VIRTIO_NET_CTRL_NOTF_COAL_VQS_SET commands with
>> VIRTIO_NET_ERR if it
>>>> was not able to change the parameters.
>>>>
>>>> -The device MUST respond to VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET
>> and
>>>> VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET commands with -
>> VIRTIO_NET_ERR if the
>>>> designated virtqueue is not an enabled transmit or receive virtqueue.
>>>> +The device MUST respond to VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET,
>>>> +VIRTIO_NET_CTRL_NOTF_COAL_VQS_SET and
>>>> VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET commands with
>> VIRTIO_NET_ERR if the
>>>> designated virtqueue is not an enabled transmit or receive virtqueue.
>>>>
>>>>    Upon disabling and re-enabling a transmit virtqueue, the device
>>>> MUST set the coalescing parameters of the virtqueue  to those
>>>> configured through the VIRTIO_NET_CTRL_NOTF_COAL_TX_SET
>> command, or,
>>>> if the driver did not set any TX coalescing parameters, to 0.
>>>> --
>>>> 1.8.3.1
>>>>
>>>>
>>>> This publicly archived list offers a means to provide input to the
>>>> OASIS Virtual I/O Device (VIRTIO) TC.
>>>>
>>>> In order to verify user consent to the Feedback License terms and to
>>>> minimize spam in the list archive, subscription is required before
>>>> posting.
>>>>
>>>> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
>>>> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
>>>> List help: virtio-comment-help@lists.oasis-open.org
>>>> List archive: https://lists.oasis-open.org/archives/virtio-comment/
>>>> Feedback License: https://www.oasis-
>>>> open.org/who/ipr/feedback_license.pdf
>>>> List Guidelines:
>>>> https://www.oasis-open.org/policies-guidelines/mailing-lists
>>>> Committee: https://www.oasis-open.org/committees/virtio/
>>>> Join OASIS: https://www.oasis-open.org/join/
>>> ---------------------------------------------------------------------
>>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

