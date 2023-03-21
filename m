Return-Path: <virtio-dev-return-11657-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD37C6FD1D
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 02:42:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 59A523250
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 02:42:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4A2A598644C
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 02:42:09 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3D0D5986385; Tue, 21 Mar 2023 02:42:09 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 23BCA986393;
	Tue, 21 Mar 2023 02:42:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VeLARzF_1679366517;
Message-ID: <99f20219-931a-7b67-9768-0c2f8f32d16e@linux.alibaba.com>
Date: Tue, 21 Mar 2023 10:41:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
To: Cornelia Huck <cohuck@redhat.com>, virtio-dev@lists.oasis-open.org,
 virtio-comment@lists.oasis-open.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>,
 Alvaro Karsz <alvaro.karsz@solid-run.com>,
 David Edmondson <david.edmondson@oracle.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20230312124628.8527-1-hengqi@linux.alibaba.com>
 <87cz53js85.fsf@redhat.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <87cz53js85.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v12] virtio-net: support the virtqueue
 coalescing moderation



在 2023/3/21 上午12:35, Cornelia Huck 写道:
> On Sun, Mar 12 2023, Heng Qi <hengqi@linux.alibaba.com> wrote:
>
>> Currently, coalescing parameters are grouped for all transmit and receive
>> virtqueues. This patch supports setting or getting the parameters for a
>> specified virtqueue, and a typical application of this function is netdim[1].
>>
>> When the traffic between virtqueues is unbalanced, for example, one virtqueue
>> is busy and another virtqueue is idle, then it will be very useful to
>> control coalescing parameters at the virtqueue granularity.
>>
>> [1] https://docs.kernel.org/networking/net_dim.html
>>
>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
>> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>> Reviewed-by: Parav Pandit <parav@nvidia.com>
> [Apologies for only reviewing this right now]
>
>> @@ -1519,25 +1522,63 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>>       le32 max_usecs;
>>   };
>>   
>> +struct virtio_net_ctrl_coal_vq {
>> +    le16 vqn;
>> +    le16 reserved;
>> +    struct virtio_net_ctrl_coal coal;
>> +};
>> +
>>   #define VIRTIO_NET_CTRL_NOTF_COAL 6
>>    #define VIRTIO_NET_CTRL_NOTF_COAL_TX_SET  0
>>    #define VIRTIO_NET_CTRL_NOTF_COAL_RX_SET 1
>> + #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET 2
>> + #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET 3
>>   \end{lstlisting}
>>   
>>   Coalescing parameters:
>>   \begin{itemize}
>> +\item \field{vqn}: The virtqueue number of an enabled transmit or receive virtqueue.
> As the commands obviously cannot target a control vq, I think we need a
> statement on what the device is supposed to be doing if the driver puts
> the number of the control q (or indeed an invalid number) here?

"of an enabled transmit or receive virtqueue" has clearly ruled out 
control vq.
As you said, we should make it clear in the normative statement that the 
driver must not send vq numbers other transmit vqs and receive vqs.

>
>>   \item \field{max_usecs} for RX: Maximum number of microseconds to delay a RX notification.
>>   \item \field{max_usecs} for TX: Maximum number of microseconds to delay a TX notification.
>>   \item \field{max_packets} for RX: Maximum number of packets to receive before a RX notification.
>>   \item \field{max_packets} for TX: Maximum number of packets to send before a TX notification.
>>   \end{itemize}
>>   
>> -The class VIRTIO_NET_CTRL_NOTF_COAL has 2 commands:
>> +\field{reserved} is reserved and it is ignored by a device.
> s/a/the/

I think "a" should be used for the first occurrence, and "the" is used 
to refer to the one that has already appeared, am I correct :) ?

>
>> +
>> +Read/Write attributes for coalescing parameters:
>> +\begin{itemize}
>> +\item For commands VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRTIO_NET_CTRL_NOTF_COAL_RX_SET, the structure virtio_net_ctrl_coal is write-only for a driver.
> s/a/the/
>
>> +\item For the command VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET, the structure virtio_net_ctrl_coal_vq is write-only for a driver.
> s/a/the/
>
>> +\item For the command VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET, \field{vqn} and \field{reserved} are write-only
>> +      for a driver, and the structure virtio_net_ctrl_coal is read-only for the driver.
> s/a/the/ (otherwise, this is kind of inconsistent)
>
>> +\end{itemize}
>> +
>> +The class VIRTIO_NET_CTRL_NOTF_COAL has 4 commands:
> Instead of giving the exact number of commands, maybe use "the following
> commands" instead?

Sure.

>
>>   \begin{enumerate}
>> -\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{max_usecs} and \field{max_packets} parameters for all transmit virtqueues.
>> -\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{max_usecs} and \field{max_packets} parameters for all receive virtqueues.
>> +\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: use the structure virtio_net_ctrl_coal to set the \field{max_usecs} and \field{max_packets} parameters for all transmit virtqueues.
>> +\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: use the structure virtio_net_ctrl_coal to set the \field{max_usecs} and \field{max_packets} parameters for all receive virtqueues.
>> +\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET: use the structure virtio_net_ctrl_coal_vq to set the \field{max_usecs} and \field{max_packets} parameters
>> +                                        for an enabled transmit/receive virtqueue whose number is \field{vqn}.
>> +\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET: use the structure virtio_net_ctrl_coal_vq to get the \field{max_usecs} and \field{max_packets} parameters
>> +                                        for an enabled transmit/receive virtqueue whose number is \field{vqn}.
>>   \end{enumerate}
>>   
>> +The device may generate notifications more or less frequently than specified by set commands of the VIRTIO_NET_CTRL_NOTF_COAL class.
>> +
>> +If coalescing parameters are being set, the device applies the last coalescing parameters set for a
>> +virtqueue, regardless of the command used to set the parameters. Use the following command sequence
>> +with 2 pairs of virtqueues as an example:
> s/2/two/

Yes, but I don't understand why this is important, it comes up elsewhere.

>
>> +Each of the following commands sets \field{max_usecs} and \field{max_packets} parameters for virtqueues.
>> +\begin{itemize}
>> +\item Command1: VIRTIO_NET_CTRL_NOTF_COAL_RX_SET sets coalescing parameters for virtqueues having vqn 0 and vqn 2. Virtqueues having vqn 1 and vqn 3 retain their previous parameters.
>> +\item Command2: VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET with \field{vqn} = 0 sets coalescing parameters for virtqueue having vqn 0. Virtqueue having vqn 2 retains the parameters from command1.
>> +\item Command3: VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET with \field{vqn} = 0, the device responds with coalescing parameters of vqn 0 set by command2.
>> +\item Command4: VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET with \field{vqn} = 1 sets coalescing parameters for virtqueue having vqn 1. Virtqueue having vqn 3 retains its previous parameters.
>> +\item Command5: VIRTIO_NET_CTRL_NOTF_COAL_TX_SET sets coalescing parameters for virtqueues having vqn 1 and vqn 3, and overrides the parameters set by command4.
>> +\item Command6: VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET with \field{vqn} = 1, the device responds with coalescing parameters of vqn 1 set by command5.
>> +\end{itemize}
>> +
>>   \subparagraph{Operation}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing / Operation}
>>   
>>   The device sends a used buffer notification once the notification conditions are met and if the notifications are not suppressed as explained in \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Used Buffer Notification Suppression}.
>> @@ -1585,14 +1626,33 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>>   
>>   \drivernormative{\subparagraph}{Notifications Coalescing}{Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing}
>>   
>> -If the VIRTIO_NET_F_NOTF_COAL feature has not been negotiated, the driver MUST NOT issue VIRTIO_NET_CTRL_NOTF_COAL commands.
>> +A driver MUST negotiate the VIRTIO_NET_F_NOTF_COAL feature before issuing commands VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRIO_NET_CTRL_NOTF_COAL_RX_SET.
> s/VIRIO/VIRTIO/

I will fix it.

>
>> +
>> +A driver MUST negotiate the VIRTIO_NET_F_VQ_NOTF_COAL feature before issuing commands VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET and VIRIO_NET_CTRL_NOTF_COAL_VQ_GET.
> s/VIRIO/VIRTIO/
>
> I'm not sure whether we should be expressing this via 'before' -- it's
> not like the driver can negotiate the feature bit if it realizes later
> that it wants to issue the command. IOW, I'd prefer the 'not negotiated'
> -> 'MUST NOT issue' construct, but I'm not dead set on it.

The previous version was a double negative, but I think that statement 
seems clearer now.
Because we know that double negation may cause confusion:
when A does not happen, B must not happen, but when A happens, does it 
mean that B can happen? Maybe B can't happen either.

>
>> +
>> +A driver MUST ignore the values of coalescing parameters received from the VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET command if a device responds with VIRTIO_NET_ERR.
> Do we need to mandate here that the driver MUST NOT put anything else
> but the number of an enabled transmit or receive virtqueue into the vqn
> field?

Yes, you are right. I agree.

>
> (Generally, I'd prefer "The driver" instead of "A driver" as well, but
> that might be a matter of taste.)
>
>>   
>>   \devicenormative{\subparagraph}{Notifications Coalescing}{Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing}
>>   
>> -A device SHOULD respond to the VIRTIO_NET_CTRL_NOTF_COAL commands with VIRTIO_NET_ERR if it was not able to change the parameters.
>> +A device MUST ignore \field{reserved}.
>> +
>> +A device SHOULD respond to VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRTIO_NET_CTRL_NOTF_COAL_RX_SET commands with VIRTIO_NET_ERR if it was not able to change the parameters.
>> +
>> +A device MUST respond to the VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command with VIRTIO_NET_ERR if it was not able to change the parameters.
>> +
>> +A device MUST respond to VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET and VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET commands with VIRTIO_NET_ERR if the given virtqueue is disabled.
> s/given/designated/ ?

Ok.

>
> What should the device do if the virtqueue is invalid (i.e. it is the
> control vq?) I think we either need to add a statement explicitly
> forbidding that to the driver conformance section, or specify that the
> device MUST return an error here.

Yes, I would prefer to let the driver do this.

>
>> +
>> +Upon disabling and re-enabling the transmit virtqueue, the device MUST set the coalescing parameters of the virtqueue
>> +to those configured through the VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command, or, if the driver did not set any TX coalescing parameters, to 0.
> "a transmit virtqueue" ?

I'm a bit confused, can you explain more? Because in the example below 
you say "s/a driver/the driver".

     +\item For the command VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET, \field{vqn} and \field{reserved} are write-only
     +      for a driver, and the structure virtio_net_ctrl_coal is read-only for the driver.


>
>> +
>> +Upon disabling and re-enabling the receive virtqueue, the device MUST set the coalescing parameters of the virtqueue
>> +to those configured through the VIRTIO_NET_CTRL_NOTF_COAL_RX_SET command, or, if the driver did not set any RX coalescing parameters, to 0.
> "a receive virtqueue" ?
>
>>   
>>   A device SHOULD NOT send used buffer notifications to the driver if the notifications are suppressed, even if the notification conditions are met.
> Generally, I'd prefer "The device" here as well.
>
>>   
>> +The behavior of the device in response to set commands of the VIRTIO_NET_CTRL_NOTF_COAL class is best-effort:
>> +the device MAY generate notifications more or less frequently than specified.
>> +
>>   Upon reset, a device MUST initialize all coalescing parameters to 0.
>>   
>>   \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
> There are a couple of typos and some style issues here which we could
> fix with an update on top, but I'd really like some clarity regarding
> invalid virtqueues first.

Yes, I think you are right. I see that the voting has already started, 
do I need to wait for the voting to end and repost a new version based 
on the results?

Thanks.



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

