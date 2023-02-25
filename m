Return-Path: <virtio-dev-return-11276-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14051C64EC7
	for <virtio-dev@archiver.kernel.org>; Sat, 25 Feb 2023 15:39:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4453C2CAE1
	for <virtio-dev@archiver.kernel.org>; Sat, 25 Feb 2023 15:39:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 371F4986792
	for <virtio-dev@archiver.kernel.org>; Sat, 25 Feb 2023 15:39:47 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 28ED3983F7F; Sat, 25 Feb 2023 15:39:47 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 15AB39866A9;
	Sat, 25 Feb 2023 15:39:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VcRhEv2_1677339578;
Message-ID: <ead164c7-7883-ad23-c5ae-fff53a2242e7@linux.alibaba.com>
Date: Sat, 25 Feb 2023 23:39:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org,
 "Michael S . Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>,
 David Edmondson <david.edmondson@oracle.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Cornelia Huck <cohuck@redhat.com>
References: <20230224142602.657-1-hengqi@linux.alibaba.com>
 <CAJs=3_C_NATOMyLJs1G7cmewpSasW67UBpoa53ZHayw+Uw5+-g@mail.gmail.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <CAJs=3_C_NATOMyLJs1G7cmewpSasW67UBpoa53ZHayw+Uw5+-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] Re: [PATCH v8] virtio-net: support the virtqueue
 coalescing moderation
Message-ID: <20230225153926.ujxiag8ghKGELDwWs0FoSIlO_AsCwuT1HfPLlIEcOvs@z>

Hi, Alvaro.

在 2023/2/25 下午10:18, Alvaro Karsz 写道:
> Hi Heng,
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
>> ---
>> This patch is on top of Alvaro's latest v7 patch: https://lists.oasis-open.org/archives/virtio-dev/202302/msg00431.html .
>>
>> v7->v8:
>>         1. Use "best-effort" in Alvaro's patch instead of "the device may set the parameter to a value close to 2". @Michael S . Tsirkin, @David Edmondson
>>
>> v6->v7:
>>         1. Clarify the relationship of VIRTIO_NET_CTRL_NOTF_COAL_TX/RX_SET and VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET. @Alvaro Karsz, @Michael S. Tsirkin
>>         2. Remove the formula for vqn range. @Parav Pandit
>>         3. Some expressions are clearer. @Parav Pandit, @Michael S. Tsirkin
>>
>> v5->v6:
>>         1. Explain that the device may set a different value than the one passed in by the driver. @David Edmondson
>>
>> v4->v5:
>>         1. Add the correspondence between virtio_net_ctrl_coal and virtio_net_ctrl_coal_vq and control commands. @Michael S. Tsirkin
>>         2. Add read and write attributes for each field. @Michael S. Tsirkin
>>         3. A clearer description of how to set coalescing parameters for vq reset. @Michael S. Tsirkin
>>         4. Fix some syntax errors. @Michael S. Tsirkin, @David Edmondson
>>
>> v3->v4:
>>         1. Include virtio_net_ctrl_coal in the virtio_net_ctrl_coal_vq structure. @Alvaro Karsz
>>         2. Add consideration of vq reset. @Michael S. Tsirkin, @Parav Pandit, @Alvaro Karsz
>>         3. Avoid too many examples by giving a comprehensive example. @Michael S. Tsirkin
>>         4. Fix typos and streamline clarifications. @Michael S. Tsirkin, @Parav Pandit, @Alvaro Karsz
>>
>> v2->v3:
>>         1. Add the netdim link. @Parav Pandit
>>         2. VIRTIO_NET_F_VQ_NOTF_COAL no longer depends on VIRTIO_NET_F_NOTF_COAL. @Michael S. Tsirkin, @Alvaro Karsz
>>         3. _VQ_GET is explained more. @Michael S. Tsirkin
>>         4. Add more examples to avoid misunderstandings. @Michael S. Tsirkin
>>         5. Clarify some statements. @Michael S. Tsirkin, @Parav Pandit, @Alvaro Karsz
>>         6. Adjust the virtio_net_ctrl_coal_vq structure. @Michael S. Tsirkin
>>         7. Fix some typos. @Michael S. Tsirkin
>>
>> v1->v2:
>>         1. Rename VIRTIO_NET_F_PERQUEUE_NOTF_COAL to VIRTIO_NET_F_VQ_NOTF_COAL. @Michael S. Tsirkin
>>         2. Use the \field{vqn} instead of the qid. @Michael S. Tsirkin
>>         3. Unify tx and rx control structures into one structure virtio_net_ctrl_coal_vq. @Michael S. Tsirkin
>>         4. Add a new control command VIRTIO_NET_CTRL_NOTF_COAL_VQ. @Michael S. Tsirkin, @Parav Pandit, @Alvaro Karsz
>>         5. The special value 0xFFF is removed because VIRTIO_NET_CTRL_NOTF_COAL can be used. @Alvaro Karsz
>>         6. Clarify some special scenarios. @Michael S. Tsirkin, @Parav Pandit, @Alvaro Karsz
>>
>>   device-types/net/description.tex | 93 ++++++++++++++++++++++++++++++--
>>   1 file changed, 88 insertions(+), 5 deletions(-)
>>
>> diff --git a/device-types/net/description.tex b/device-types/net/description.tex
>> index e71e33b..573e1af 100644
>> --- a/device-types/net/description.tex
>> +++ b/device-types/net/description.tex
>> @@ -83,6 +83,8 @@ \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits
>>   \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
>>       channel.
>>
>> +\item[VIRTIO_NET_F_VQ_NOTF_COAL(52)] Device supports virtqueue notification coalescing.
>> +
>>   \item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notifications coalescing.
>>
>>   \item[VIRTIO_NET_F_GUEST_USO4 (54)] Driver can receive USOv4 packets.
>> @@ -139,6 +141,7 @@ \subsubsection{Feature bit requirements}\label{sec:Device Types / Network Device
>>   \item[VIRTIO_NET_F_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
>>   \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_NET_F_HOST_TSO6.
>>   \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
>> +\item[VIRTIO_NET_F_VQ_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
>>   \end{description}
>>
>>   \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Network Device / Feature bits / Legacy Interface: Feature bits}
>> @@ -1508,6 +1511,14 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>>   If the VIRTIO_NET_F_NOTF_COAL feature is negotiated, the driver can
>>   send control commands for dynamically changing the coalescing parameters.
> Maybe we should mention in here the VIRTIO_NET_F_VQ_NOTF_COAL feature as well?
> This part is no longer true, a driver can send the notification
> coalescing command if VIRTIO_NET_F_NOTF_COAL wasn't negotiated.
>

I think we clearly indicate something like the following?
"
If the VIRTIO_NET_F_NOTF_COAL feature is negotiated, the driver can send 
VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRTIO_NET_CTRL_NOTF_COAL_RX_SET 
commands
for dynamically changing the coalescing parameters.
"
This aligns with VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET and 
VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET described below,
and also addresses what you mentioned in your "general note".

What do you think? :)

>> +If the VIRTIO_NET_F_VQ_NOTF_COAL feature is negotiated:
>> +\begin{itemize}
>> +\item a driver can send a VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command to set coalescing parameters of a given
>> +      enabled transmit/receive virtqueue.
>> +\item a driver can send a VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET command to a device, and the device responds with
>> +      coalescing parameters of a given enabled transmit/receive virtqueue.
>> +\end{itemize}
>> +
>>   \begin{note}
>>   The behavior of the device in response to these commands is best-effort:
>>   the device may generate notifications more or less frequently than specified.
>> @@ -1519,25 +1530,76 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
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
>> +The VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRTIO_NET_CTRL_NOTF_COAL_RX_SET commands use the
>> +virtio_net_ctrl_coal structure to set \field{max_usecs} and \field{max_packets} for all
>> +transmit/receive virtqueues.
>> +
>> +The VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command uses the virtio_net_ctrl_coal_vq structure
>> +to set \field{max_usecs} and \field{max_packets} for the supplied virtqueue number \field{vqn}.
>> +
>> +The VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET command gets the values of \field{max_usecs} and
>> +\field{max_packets} of the specified virtqueue from the device by setting \field{vqn}
>> +in the virtio_net_ctrl_coal_vq structure.
>> +
>> +# Read/Write attributes for coalescing parameters
>> +\begin{itemize}
>> +\item For commands VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRTIO_NET_CTRL_NOTF_COAL_RX_SET, \field{max_usecs}
>> +      and \field{max_packets} are write-only for a driver.
>> +\item For the command VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET, \field{vqn}, \field{reserved}, \field{max_usecs}
>> +      and \field{max_packets} are write-only for a driver.
>> +\item For the command VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET, \field{vqn} and \field{reserved} are write-only
>> +      for a driver, and, \field{max_usecs} and \field{max_packets} are read-only for the driver.
>> +\end{itemize}
>> +
>>   Coalescing parameters:
>>   \begin{itemize}
>> +\item \field{vqn}: The virtqueue number of an enabled transmit or receive virtqueue.
>>   \item \field{max_usecs} for RX: Maximum number of microseconds to delay a RX notification.
>>   \item \field{max_usecs} for TX: Maximum number of microseconds to delay a TX notification.
>>   \item \field{max_packets} for RX: Maximum number of packets to receive before a RX notification.
>>   \item \field{max_packets} for TX: Maximum number of packets to send before a TX notification.
>>   \end{itemize}
>>
>> -The class VIRTIO_NET_CTRL_NOTF_COAL has 2 commands:
>> +\field{reserved} is reserved and it is ignored by a device.
>> +
>> +The class VIRTIO_NET_CTRL_NOTF_COAL has 4 commands:
>>   \begin{enumerate}
>> -\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{max_usecs} and \field{max_packets} parameters for all transmit virtqueues.
>> -\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{max_usecs} and \field{max_packets} parameters for all receive virtqueues.
>> +\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET: set the \field{max_usecs} and \field{max_packets} parameters for an enabled transmit/receive
>> +                                        virtqueue whose number is \field{vqn}.
>> +\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET: the device returns the \field{max_usecs} and \field{max_packets} parameters for an enabled
>> +                                        transmit/receive virtqueue whose number is \field{vqn}.
>> +\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: have the same effect of setting coalescing parameters as the VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command repeated for
>> +                                        each virtqueue of transmitq1\ldots transmitqN.
>> +\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: have the same effect of setting coalescing parameters as the VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command repeated for
>> +                                        each virtqueue of receiveq1\ldots receiveqN.
>>   \end{enumerate}
>>
> I think it would be simpler to leave the current commands as they are
> at the moment.
> "set the \field{max_usecs} and \field{max_packets} parameters for all
> transmit virtqueues."
> That's just my opinion though..
>
> I wonder if we should mention the global parameters here as well, what
> do you think?
> We are describing the commands in here, so describing just part of it,
> then adding more command functionality in later paragraphs may be a
> little confusing IMO.

Good idea, keep it as it is, and add the "global values" section.

What do you think of the following description?

"
\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{max_usecs} and 
\field{max_packets} parameters for all transmit virtqueues, and values 
of coalescing parameters are recorded as TX global values by a device.

\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{max_usecs} and \field{max_packets} parameters for all receive virtqueues, and values of coalescing parameters are recorded as RX global values by a device
\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET: set the \field{max_usecs} and \field{max_packets} parameters for an enabled transmit/receive
                                         virtqueue whose number is \field{vqn} and do not change the global values.
\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET: the device returns the \field{max_usecs} and \field{max_packets} parameters for an enabled
                                         transmit/receive virtqueue whose number is \field{vqn}.
"

>
>> +If coalescing parameters are being set, the device applies the last coalescing parameters received for a
>> +virtqueue, regardless of the command used to set the parameters. For example with 2 pairs of virtqueues:
>> +# Command sequence
>> +Each of the following commands sets \field{max_usecs} and \field{max_packets} parameters for virtqueues.
>> +\begin{itemize}
>> +\item Command1: VIRTIO_NET_CTRL_NOTF_COAL_RX_SET sets coalescing parameters for virtqueue0 and virtqueue2, and, virtqueue1 and virtqueue3 retain their previous parameter values.
>> +\item Command2: VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET with \field{vqn} = 0 sets coalescing parameters for virtqueue0, and virtqueue2 retains the values from command1.
>> +\item Command3: VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET with \field{vqn} = 0, the device responds with coalescing parameters of virtqueue0 set by command2.
>> +\item Command4: VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET with \field{vqn} = 1 sets coalescing parameters for virtqueue1, and virtqueue3 retains its previous values.
>> +\item Command5: VIRTIO_NET_CTRL_NOTF_COAL_TX_SET sets coalescing parameters for virtqueue1 and virtqueue3, and overrides the values set by command4.
>> +\item Command6: VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET with \field{vqn} = 1, the device responds with coalescing parameters of virtqueue1 set by command5.
>> +\end{itemize}
>> +
>>   \subparagraph{Operation}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing / Operation}
>>
>>   The device sends a used buffer notification once the notification conditions are met and if the notifications are not suppressed as explained in \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Used Buffer Notification Suppression}.
>> @@ -1549,6 +1611,11 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>>
>>   When the device has \field{max_usecs} = 0 or \field{max_packets} = 0, the notification conditions are met after every packet received/sent.
>>
>> +When the device receives the VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRTIO_NET_CTRL_NOTF_COAL_RX_SET commands,
>> +it saves the values of coalescing parameters as global values, and the VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command
>> +does not change the global values. If the device is reset, the global values will be set to 0.
>> +When a virtqueue is enabled after virtqueue reset, its coalescing parameters are set to global values.
>> +
>>   \subparagraph{RX Example}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing / RX Example}
>>
>>   If, for example:
>> @@ -1585,11 +1652,27 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>>
>>   \drivernormative{\subparagraph}{Notifications Coalescing}{Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing}
>>
>> -If the VIRTIO_NET_F_NOTF_COAL feature has not been negotiated, the driver MUST NOT issue VIRTIO_NET_CTRL_NOTF_COAL commands.
>> +If neither the VIRTIO_NET_F_NOTF_COAL nor the VIRTIO_NET_F_VQ_NOTF_COAL feature
>> +has been negotiated, the driver MUST NOT issue VIRTIO_NET_CTRL_NOTF_COAL commands.
>> +
>> +A driver MUST ignore the values of coalescing parameters received from the VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET command if a device responds with VIRTIO_NET_ERR.
>>
>>   \devicenormative{\subparagraph}{Notifications Coalescing}{Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing}
>>
>> -A device SHOULD respond to the VIRTIO_NET_CTRL_NOTF_COAL commands with VIRTIO_NET_ERR if it was not able to change the parameters.
>> +A device SHOULD respond to VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRTIO_NET_CTRL_NOTF_COAL_RX_SET commands with VIRTIO_NET_ERR if it was not able to change the parameters.
>> +
>> +A device MUST respond to the VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command with VIRTIO_NET_ERR if it was not able to change the parameters.
>> +
>> +A device MUST respond to VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET and VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET commands with VIRTIO_NET_ERR if the given virtqueue is disabled.
>> +
>> +The VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRTIO_NET_CTRL_NOTF_COAL_RX_SET commands set coalescing parameters for all transmit/receive
>> +virtqueues respectively and values of coalescing parameters are recorded as global values by a device.
> I'm not sure if this statement belongs to the conformance section.

So let's bring this up front as I replied, and if so, I think the 
following specification constraints can be combined:

"
Upon reset, a device MUST initialize all coalescing parameters to 0 and 
set the global values to 0.
"

>
>> +The device MUST set the global values of coalescing parameters to 0 after being reset.
> Maybe this part can be merged with "Upon reset, a device MUST
> initialize all coalescing parameters to 0."?

>
>> +The VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command sets the coalescing parameters for a given enabled virtqueue without changing the global values.
>> +
> I'm not sure if this statement belongs to the conformance section.
>
>> +After disabling and re-enabling a virtqueue, the device MUST revert coalescing parameters of the virtqueue to the global values.
>> +
>> +A device MUST ignore \field{reserved}.
>>
>>   A device SHOULD NOT send used buffer notifications to the driver if the notifications are suppressed, even if the notification conditions are met.
>>
>> --
> A general note,
>
> Correct my if I'm wrong, but the fact that a driver can't send
> VIRTIO_NET_CTRL_NOTF_COAL_[T/R]X_SET  commands if
> VIRTIO_NET_F_NOTF_COAL is not negotiated isn't explicitly mentioned
> anywhere.

Yes.

> A reader may think that the commands cant be sent if
> VIRTIO_NET_F_VQ_NOTF_COAL is negotiated.
> I'm not talking about the conformance parts, but I think that we
> should write somewhere in the beginning which commands can be used
> with which feature bits.

Good note, let's do this. :)

Thanks.

>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

