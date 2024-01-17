Return-Path: <virtio-dev-return-14256-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 607C3C47258
	for <virtio-dev@archiver.kernel.org>; Wed, 17 Jan 2024 08:53:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C67E060F40
	for <virtio-dev@archiver.kernel.org>; Wed, 17 Jan 2024 08:53:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C25BD98672A
	for <virtio-dev@archiver.kernel.org>; Wed, 17 Jan 2024 08:53:54 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B68BE986703; Wed, 17 Jan 2024 08:53:54 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A43A69866F7;
	Wed, 17 Jan 2024 08:53:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W-oo5.3_1705481625;
Message-ID: <64f90cbb-0e87-4953-926f-d61f5cadac45@linux.alibaba.com>
Date: Wed, 17 Jan 2024 16:53:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <1705323962-96063-1-git-send-email-hengqi@linux.alibaba.com>
 <20240115173401-mutt-send-email-mst@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20240115173401-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] Re: [PATCH v2] virtio-net: support setting
 coalescing params for multiple vqs



在 2024/1/16 上午6:58, Michael S. Tsirkin 写道:
> On Mon, Jan 15, 2024 at 09:06:02PM +0800, Heng Qi wrote:
>> Currently, when each time the driver attempts to update the coalescing parameters
>> for a vq, it needs to kick the device and wait for the ctrlq response to return.
>> The following path is observed: 1. Driver kicks the device; 2. After the device
>> receives the kick, CPU scheduling occurs and DMA multiple buffers multiple times;
>> 3. The device completes processing and replies with a response.
>>
>> When large-queue devices issue multiple requests and kick the device frequently,
>> this often interrupt the work of the device-side CPU. In addition, each vq request
>> is processed separately, causing more delays for the CPU to wait for the DMA
>> request to complete.
>>
>> These interruptions and overhead will strain the CPU responsible for controlling
>> the path of the DPU, especially in multi-device and large-queue scenarios.
>>
>> To solve the above problems, we internally tried batch request, which merges
>> requests from multiple queues and sends them at once. We conservatively tested
>> 8 queue commands and sent them together. The DPU processing efficiency can be
>> improved by 8 times, which greatly eases the DPU's support for multi-device
>> and multi-queue DIM.
>>
>> Maintainers may be concerned about whether the batch command method can optimize
>> the above problems: accumulate multiple request commands to kick the device once,
>> and obtain the processing results of the corresponding commands asynchronously.
>> The batch command method is used by us to optimize the CPU overhead of the DIM
>> worker caused by the guest being busy waiting for the command response result.
>> This is a different focus than batch request to solve the problem.
>
> Hmm. Could the issue be actually that
> 1. you are using split vqs so processing is complex

This is part of the problem.

> 2. Linux driver uses indirect to pass coalescing commands around
>     so even more complex
> ?

Theoretically, when ctrlq cmd is sent,
the number of indirect DMA times will be 3 times less than
the number of chain DMA times. After the actual test, the indirect 
method of ctrlq
is about 10% more efficient than the chain method.

Merging requests can both reduce the number of kicks and greatly reduce 
the number of DMAs.
For example, after 8 queues requests are merged, only 1 kick + 8 DMAs 
are required.
Without merging, 8 kicks + 64 DMAs are required.

>
> Is packed an option for you at all?

On our existing hardware, migrating from splitq to packedq would take a 
long time.

Thanks.

>   Guest should also be changed to
> avoid indirect with ctrl vq. As a quick test, disable indirect maybe
> that is fast enough?
>



>
>
>> Suggested-by: Xiaoming Zhao <zxm377917@alibaba-inc.com>
>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
>> ---
>> v1->v2: Updated commit log. Due to sensitivity, sorry that can not give the
>>      absolute value directly. @Michael
>>
>>   device-types/net/description.tex | 26 ++++++++++++++++++++------
>>   1 file changed, 20 insertions(+), 6 deletions(-)
>>
>> diff --git a/device-types/net/description.tex b/device-types/net/description.tex
>> index aff5e08..b3766c4 100644
>> --- a/device-types/net/description.tex
>> +++ b/device-types/net/description.tex
>> @@ -1667,8 +1667,8 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>>   for notification coalescing.
>>   
>>   If the VIRTIO_NET_F_VQ_NOTF_COAL feature is negotiated, the driver can
>> -send commands VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET and VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET
>> -for virtqueue notification coalescing.
>> +send commands VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET, VIRTIO_NET_CTRL_NOTF_COAL_VQS_SET and
>> +VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET for virtqueue notification coalescing.
>>   
>>   \begin{lstlisting}
>>   struct virtio_net_ctrl_coal {
>> @@ -1682,11 +1682,17 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>>       struct virtio_net_ctrl_coal coal;
>>   };
>>   
>> +struct virtio_net_ctrl_mrg_coal_vq {
>> +        le16 num_entries; /* indicates number of valid entries */
>> +        struct virtio_net_ctrl_coal_vq entries[];
>> +};
>> +
>>   #define VIRTIO_NET_CTRL_NOTF_COAL 6
>>    #define VIRTIO_NET_CTRL_NOTF_COAL_TX_SET  0
>>    #define VIRTIO_NET_CTRL_NOTF_COAL_RX_SET 1
>>    #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET 2
>>    #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET 3
>> + #define VIRTIO_NET_CTRL_NOTF_COAL_VQS_SET 4
>>   \end{lstlisting}
>>   
>>   Coalescing parameters:
>> @@ -1706,6 +1712,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>>   \item For the command VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET, the structure virtio_net_ctrl_coal_vq is write-only for the driver.
>>   \item For the command VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET, \field{vq_index} and \field{reserved} are write-only
>>         for the driver, and the structure virtio_net_ctrl_coal is read-only for the driver.
>> +\item For the command VIRTIO_NET_CTRL_NOTF_COAL_VQS_SET, the structure virtio_net_ctrl_mrg_coal_vq is write-only for the driver.
>>   \end{itemize}
>>   
>>   The class VIRTIO_NET_CTRL_NOTF_COAL has the following commands:
>> @@ -1716,6 +1723,9 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>>                                           for an enabled transmit/receive virtqueue whose index is \field{vq_index}.
>>   \item VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET: use the structure virtio_net_ctrl_coal_vq to get the \field{max_usecs} and \field{max_packets} parameters
>>                                           for an enabled transmit/receive virtqueue whose index is \field{vq_index}.
>> +\item VIRTIO_NET_CTRL_NOTF_COAL_VQS_SET: use the structure virtio_net_ctrl_mrg_coal_vq to set the \field{max_usecs} and \field{max_packets} parameters
>> +                                         for \field{num_entries} enabled transmit/receive virtqueues. The corresponding index value
>> +                                         of each configured virtqueue is \field{vq_index}.
>>   \end{enumerate}
>>   
>>   The device may generate notifications more or less frequently than specified by set commands of the VIRTIO_NET_CTRL_NOTF_COAL class.
>> @@ -1782,9 +1792,13 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>>   
>>   The driver MUST set \field{vq_index} to the virtqueue index of an enabled transmit or receive virtqueue.
>>   
>> +The driver MUST set \field{num_entries} to a non-zero value and MUST NOT set \field{num_entries} to
>> +a value greater than the number of enabled transmit and receive virtqueues.
>> +
>>   The driver MUST have negotiated the VIRTIO_NET_F_NOTF_COAL feature when issuing commands VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRTIO_NET_CTRL_NOTF_COAL_RX_SET.
>>   
>> -The driver MUST have negotiated the VIRTIO_NET_F_VQ_NOTF_COAL feature when issuing commands VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET and VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET.
>> +The driver MUST have negotiated the VIRTIO_NET_F_VQ_NOTF_COAL feature when issuing commands
>> +VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET, VIRTIO_NET_CTRL_NOTF_COAL_VQS_SET and VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET.
>>   
>>   The driver MUST ignore the values of coalescing parameters received from the VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET command if the device responds with VIRTIO_NET_ERR.
>>   
>> @@ -1794,10 +1808,10 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>>   
>>   The device SHOULD respond to VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRTIO_NET_CTRL_NOTF_COAL_RX_SET commands with VIRTIO_NET_ERR if it was not able to change the parameters.
>>   
>> -The device MUST respond to the VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command with VIRTIO_NET_ERR if it was not able to change the parameters.
>> +The device MUST respond to VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET and VIRTIO_NET_CTRL_NOTF_COAL_VQS_SET commands with VIRTIO_NET_ERR if it was not able to change the parameters.
>>   
>> -The device MUST respond to VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET and VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET commands with
>> -VIRTIO_NET_ERR if the designated virtqueue is not an enabled transmit or receive virtqueue.
>> +The device MUST respond to VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET, VIRTIO_NET_CTRL_NOTF_COAL_VQS_SET and VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET
>> +commands with VIRTIO_NET_ERR if the designated virtqueue is not an enabled transmit or receive virtqueue.
>>   
>>   Upon disabling and re-enabling a transmit virtqueue, the device MUST set the coalescing parameters of the virtqueue
>>   to those configured through the VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command, or, if the driver did not set any TX coalescing parameters, to 0.
>> -- 
>> 1.8.3.1
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

