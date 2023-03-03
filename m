Return-Path: <virtio-dev-return-11412-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE414C6FA8E
	for <virtio-dev@archiver.kernel.org>; Fri,  3 Mar 2023 03:26:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id CA71F2CAD3
	for <virtio-dev@archiver.kernel.org>; Fri,  3 Mar 2023 03:26:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BDE0698678F
	for <virtio-dev@archiver.kernel.org>; Fri,  3 Mar 2023 03:26:47 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id AB5A69866D8; Fri,  3 Mar 2023 03:26:47 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9602D9866F9;
	Fri,  3 Mar 2023 03:26:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R431e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VczPgjM_1677814000;
Message-ID: <817a8cef-21cf-a010-b21d-050c1328c8a0@linux.alibaba.com>
Date: Fri, 3 Mar 2023 11:26:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
To: Parav Pandit <parav@nvidia.com>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Alvaro Karsz <alvaro.karsz@solid-run.com>,
 David Edmondson <david.edmondson@oracle.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jason Wang <jasowang@redhat.com>
References: <20230301141027.59500-1-hengqi@linux.alibaba.com>
 <PH0PR12MB548192A8443A7F30A70CFE80DCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <PH0PR12MB548192A8443A7F30A70CFE80DCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] RE: [PATCH v10] virtio-net: support the virtqueue
 coalescing moderation



在 2023/3/2 下午10:48, Parav Pandit 写道:
>
>> From: Heng Qi <hengqi@linux.alibaba.com>
>> Sent: Wednesday, March 1, 2023 9:10 AM
>> Currently, coalescing parameters are grouped for all transmit and receive
>> virtqueues. This patch supports setting or getting the parameters for a specified
>> virtqueue, and a typical application of this function is netdim[1].
>>
>> When the traffic between virtqueues is unbalanced, for example, one
>> virtqueue is busy and another virtqueue is idle, then it will be very useful to
>> control coalescing parameters at the virtqueue granularity.
>>
> [..]
>> +Read/Write attributes for coalescing parameters:
>> +\begin{itemize}
>> +\item For commands VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and
>> VIRTIO_NET_CTRL_NOTF_COAL_RX_SET, \field{max_usecs}
>> +      and \field{max_packets} are write-only for a driver.
>> +\item For the command VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET, \field{vqn},
>> \field{reserved}, \field{max_usecs}
>> +      and \field{max_packets} are write-only for a driver.
>> +\item For the command VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET, \field{vqn}
>> and \field{reserved} are write-only
>> +      for a driver, and, \field{max_usecs} and \field{max_packets} are read-only
>> for the driver.
>> +\end{itemize}
>> +
> Maybe I missed the conversation while I was sick.

I hope you'll be all right very soon.

> I remember we discussed that instead of mentioning each individual field, better to describe the whole structure being read-only or write-only.

Consider the following scenarios:
1. A read-only field of the structure virtio_net_ctrl_coal is extended 
for CTRL_NOTF_COAL_RX/TX_SET to get some extra information
2. \field{reserved} of the structure virtio_net_ctrl_coal_vq is reused 
by CTRL_NOTF_COAL_VQ_SET, and changed from write-only to read-only
These cases still need to unpack the structure to describe it with 
fields, and if we now use field descriptions, we can be satisfied with 
minimal changes.

>> +The class VIRTIO_NET_CTRL_NOTF_COAL has 4 commands:
>>   \begin{enumerate}
>> -\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{max_usecs} and
>> \field{max_packets} parameters for all transmit virtqueues.
>> -\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{max_usecs} and
>> \field{max_packets} parameters for all receive virtqueues.
>> +\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: use the structure
>> virtio_net_ctrl_coal to set the \field{max_usecs} and \field{max_packets}
>> parameters for all transmit virtqueues.
>> +\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: use the structure
>> virtio_net_ctrl_coal to set the \field{max_usecs} and \field{max_packets}
>> parameters for all receive virtqueues.
>> +\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET: use the structure
>> virtio_net_ctrl_coal_vq to set the \field{max_usecs} and \field{max_packets}
>> parameters
>> +                                        for an enabled transmit/receive virtqueue whose
>> number is \field{vqn}.
>> +\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET: use the structure
>> virtio_net_ctrl_coal_vq to get the \field{max_usecs} and \field{max_packets}
>> parameters
>> +                                        for an enabled transmit/receive virtqueue whose
>> number is \field{vqn}.
>>   \end{enumerate}
>>
>> +\begin{note}
>> +The behavior of the device in response to these commands is best-effort:
>> +the device may generate notifications more or less frequently than specified.
>> +\end{note}
>> +
> Michael,
> Why this should be a note? Shouldn't it be a normative line in the device requirements?
>
>> +If coalescing parameters are being set, the device applies the last
>> +coalescing parameters received for a virtqueue, regardless of the
> s/received/set to match the if condition wording and regardless sentence after.

Ok. I'll modify it.

>
>> +command used to set the parameters. Use the following command sequence
>> with 2 pairs of virtqueues as an example:
>> +Each of the following commands sets \field{max_usecs} and
>> \field{max_packets} parameters for virtqueues.
>> +\begin{itemize}
>> +\item Command1: VIRTIO_NET_CTRL_NOTF_COAL_RX_SET sets coalescing
>> parameters for virtqueue0 and virtqueue2, and, virtqueue1 and virtqueue3
>> retain their previous parameter values.
>> +\item Command2: VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET with \field{vqn} =
>> 0 sets coalescing parameters for virtqueue0, and virtqueue2 retains the values
>> from command1.
>> +\item Command3: VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET with \field{vqn} =
>> 0, the device responds with coalescing parameters of virtqueue0 set by
>> command2.
>> +\item Command4: VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET with \field{vqn} =
>> 1 sets coalescing parameters for virtqueue1, and virtqueue3 retains its previous
>> values.
>> +\item Command5: VIRTIO_NET_CTRL_NOTF_COAL_TX_SET sets coalescing
>> parameters for virtqueue1 and virtqueue3, and overrides the values set by
>> command4.
>> +\item Command6: VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET with \field{vqn} =
>> 1, the device responds with coalescing parameters of virtqueue1 set by
>> command5.
>> +\end{itemize}
>> +
>> +Upon disabling and re-enabling the transmit virtqueue, the device will
>> +set the coalescing parameters of the virtqueue to those configured through
>> the VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command, or to 0 if the command
>> did not set any TX coalescing parameters.
>> +
>> +Upon disabling and re-enabling the receive virtqueue, the device will
>> +set the coalescing parameters of the virtqueue to those configured through
>> the VIRTIO_NET_CTRL_NOTF_COAL_RX_SET command, or to 0 if the command
>> did not set any RX coalescing parameters.
>> +
> Looks good, however you have well covered in the device normative statements.
> So possibly it can be removed from here.

I tend to keep this, as we have done in the past, we can have normative 
descriptions and the corresponding non-normative descriptions.

Thanks.

>
>>   \subparagraph{Operation}\label{sec:Device Types / Network Device / Device
>> Operation / Control Virtqueue / Notifications Coalescing / Operation}
>>
>>   The device sends a used buffer notification once the notification conditions are
>> met and if the notifications are not suppressed as explained in \ref{sec:Basic
>> Facilities of a Virtio Device / Virtqueues / Used Buffer Notification Suppression}.
>> @@ -1585,11 +1637,25 @@ \subsubsection{Control
>> Virtqueue}\label{sec:Device Types / Network Device / Devi
>>
>>   \drivernormative{\subparagraph}{Notifications Coalescing}{Device Types /
>> Network Device / Device Operation / Control Virtqueue / Notifications
>> Coalescing}
>>
>> -If the VIRTIO_NET_F_NOTF_COAL feature has not been negotiated, the driver
>> MUST NOT issue VIRTIO_NET_CTRL_NOTF_COAL commands.
>> +A driver MUST negotiate the VIRTIO_NET_F_NOTF_COAL feature before
>> issuing commands VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and
>> VIRIO_NET_CTRL_NOTF_COAL_RX_SET.
>> +
>> +A driver MUST negotiate the VIRTIO_NET_F_VQ_NOTF_COAL feature before
>> issuing commands VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET and
>> VIRIO_NET_CTRL_NOTF_COAL_VQ_GET.
>> +
>> +A driver MUST ignore the values of coalescing parameters received from the
>> VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET command if a device responds with
>> VIRTIO_NET_ERR.
>>
>>   \devicenormative{\subparagraph}{Notifications Coalescing}{Device Types /
>> Network Device / Device Operation / Control Virtqueue / Notifications
>> Coalescing}
>>
>> -A device SHOULD respond to the VIRTIO_NET_CTRL_NOTF_COAL commands
>> with VIRTIO_NET_ERR if it was not able to change the parameters.
>> +A device MUST ignore \field{reserved}.
>> +
>> +A device SHOULD respond to VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and
>> VIRTIO_NET_CTRL_NOTF_COAL_RX_SET commands with VIRTIO_NET_ERR if it
>> was not able to change the parameters.
>> +
>> +A device MUST respond to the VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET
>> command with VIRTIO_NET_ERR if it was not able to change the parameters.
>> +
>> +A device MUST respond to VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET and
>> VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET commands with VIRTIO_NET_ERR if
>> the given virtqueue is disabled.
>> +
>> +After disabling and re-enabling a transmit/receive virtqueue, the
>> +device MUST set coalescing parameters of the virtqueue to those
>> +configured using the
>> VIRTIO_NET_CTRL_NOTF_COAL_TX_SET/VIRTIO_NET_CTRL_NOTF_COAL_RX_S
>> ET command, or, if the command did not configure TX/RX coalescing
>> parameters, to 0.
>>
>>   A device SHOULD NOT send used buffer notifications to the driver if the
>> notifications are suppressed, even if the notification conditions are met.
>>
>> --
>> 2.19.1.6.gb485710b
> Rest looks good to me.
>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

