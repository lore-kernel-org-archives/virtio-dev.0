Return-Path: <virtio-dev-return-11679-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC4BAC7619A
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 15:02:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id F1C1DC6253
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 15:02:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E5D22986450
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 15:02:42 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D91A698642A; Tue, 21 Mar 2023 15:02:42 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C65999863AC;
	Tue, 21 Mar 2023 15:02:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VeNTlub_1679410954;
Message-ID: <5d2fc59a-0cb9-6f4f-b853-e221e81c2272@linux.alibaba.com>
Date: Tue, 21 Mar 2023 23:02:33 +0800
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
 <99f20219-931a-7b67-9768-0c2f8f32d16e@linux.alibaba.com>
 <87pm92moz9.fsf@redhat.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <87pm92moz9.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v12] virtio-net: support the virtqueue
 coalescing moderation



在 2023/3/21 下午5:29, Cornelia Huck 写道:
> On Tue, Mar 21 2023, Heng Qi <hengqi@linux.alibaba.com> wrote:
>
>> 在 2023/3/21 上午12:35, Cornelia Huck 写道:
>>> On Sun, Mar 12 2023, Heng Qi <hengqi@linux.alibaba.com> wrote:
>>>>    \item \field{max_usecs} for RX: Maximum number of microseconds to delay a RX notification.
>>>>    \item \field{max_usecs} for TX: Maximum number of microseconds to delay a TX notification.
>>>>    \item \field{max_packets} for RX: Maximum number of packets to receive before a RX notification.
>>>>    \item \field{max_packets} for TX: Maximum number of packets to send before a TX notification.
>>>>    \end{itemize}
>>>>    
>>>> -The class VIRTIO_NET_CTRL_NOTF_COAL has 2 commands:
>>>> +\field{reserved} is reserved and it is ignored by a device.
>>> s/a/the/
>> I think "a" should be used for the first occurrence, and "the" is used
>> to refer to the one that has already appeared, am I correct :) ?
> IMHO, we are talking about a concrete device implementing this, so it
> should be "the" :) Not a native speaker, but "it is ignored by a device"
> sounds like it refers to a random device, and not the concrete one
> which will actually ignore it.

Combined with your explanation of "a/the" queue, I believe I understand! 
Thanks :)

>
>>>> +If coalescing parameters are being set, the device applies the last coalescing parameters set for a
>>>> +virtqueue, regardless of the command used to set the parameters. Use the following command sequence
>>>> +with 2 pairs of virtqueues as an example:
>>> s/2/two/
>> Yes, but I don't understand why this is important, it comes up elsewhere.
> I remember style guidance that you should spell out small numbers,
> instead of using digits. Not really important, but might be worth
> addressing if this needs a respin anyway.

Will fix.

>
>>>> +A driver MUST negotiate the VIRTIO_NET_F_VQ_NOTF_COAL feature before issuing commands VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET and VIRIO_NET_CTRL_NOTF_COAL_VQ_GET.
>>> s/VIRIO/VIRTIO/
>>>
>>> I'm not sure whether we should be expressing this via 'before' -- it's
>>> not like the driver can negotiate the feature bit if it realizes later
>>> that it wants to issue the command. IOW, I'd prefer the 'not negotiated'
>>> -> 'MUST NOT issue' construct, but I'm not dead set on it.
>> The previous version was a double negative, but I think that statement
>> seems clearer now.
>> Because we know that double negation may cause confusion:
>> when A does not happen, B must not happen, but when A happens, does it
>> mean that B can happen? Maybe B can't happen either.
> Maybe make this "MUST have negotiated (...) when issuing"?

Ok, I think it works.

>
>>>> +
>>>> +A driver MUST ignore the values of coalescing parameters received from the VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET command if a device responds with VIRTIO_NET_ERR.
>>> Do we need to mandate here that the driver MUST NOT put anything else
>>> but the number of an enabled transmit or receive virtqueue into the vqn
>>> field?
>> Yes, you are right. I agree.
>>
>>> (Generally, I'd prefer "The driver" instead of "A driver" as well, but
>>> that might be a matter of taste.)
>>>
>>>>    
>>>>    \devicenormative{\subparagraph}{Notifications Coalescing}{Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing}
>>>>    
>>>> -A device SHOULD respond to the VIRTIO_NET_CTRL_NOTF_COAL commands with VIRTIO_NET_ERR if it was not able to change the parameters.
>>>> +A device MUST ignore \field{reserved}.
>>>> +
>>>> +A device SHOULD respond to VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRTIO_NET_CTRL_NOTF_COAL_RX_SET commands with VIRTIO_NET_ERR if it was not able to change the parameters.
>>>> +
>>>> +A device MUST respond to the VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command with VIRTIO_NET_ERR if it was not able to change the parameters.
>>>> +
>>>> +A device MUST respond to VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET and VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET commands with VIRTIO_NET_ERR if the given virtqueue is disabled.
>>> s/given/designated/ ?
>> Ok.
>>
>>> What should the device do if the virtqueue is invalid (i.e. it is the
>>> control vq?) I think we either need to add a statement explicitly
>>> forbidding that to the driver conformance section, or specify that the
>>> device MUST return an error here.
>> Yes, I would prefer to let the driver do this.
> Ok, sounds good.
>
>>>> +
>>>> +Upon disabling and re-enabling the transmit virtqueue, the device MUST set the coalescing parameters of the virtqueue
>>>> +to those configured through the VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command, or, if the driver did not set any TX coalescing parameters, to 0.
>>> "a transmit virtqueue" ?
>> I'm a bit confused, can you explain more? Because in the example below
>> you say "s/a driver/the driver".
>>
>>       +\item For the command VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET, \field{vqn} and \field{reserved} are write-only
>>       +      for a driver, and the structure virtio_net_ctrl_coal is read-only for the driver.
> It is one of the transmit virtqueues (i.e. a random one, not a concrete
> one) that is getting disabled and re-enabled, but then it is that
> concrete virtqueue that needs to be configured correctly.
>
> In the second example, we're talking about a concrete driver
> implementing this, so it should be "the".
>
> (Native or close-to-native speakers, please correct me if I'm wrong! I
> don't want to get into language lawyering, but I stumbled over this
> while reading.)
>
>>> There are a couple of typos and some style issues here which we could
>>> fix with an update on top, but I'd really like some clarity regarding
>>> invalid virtqueues first.
>> Yes, I think you are right. I see that the voting has already started,
>> do I need to wait for the voting to end and repost a new version based
>> on the results?
> If you plan to respin this, you can request to withdraw the vote, and we
> can restart voting on the updated version. If voting were to close with
> the change being approved, we'd need to include it and then vote on an
> incremental change on top. (I'd prefer to go with the first option;
> incremental changes on top are better suited to simple spelling fixes
> that don't need another round of voting.)

Ok, I got it.

May I bother you please to withdraw the vote, I will modify it according 
to your opinion and release a new version!:)

Thank you very much!



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

