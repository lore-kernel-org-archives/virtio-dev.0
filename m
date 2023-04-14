Return-Path: <virtio-dev-return-12231-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37621C77B6E
	for <virtio-dev@archiver.kernel.org>; Fri, 14 Apr 2023 04:01:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9CB2529FD8
	for <virtio-dev@archiver.kernel.org>; Fri, 14 Apr 2023 04:01:00 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8DE9498661D
	for <virtio-dev@archiver.kernel.org>; Fri, 14 Apr 2023 04:01:00 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 81C9B986601; Fri, 14 Apr 2023 04:01:00 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6FFFF986600;
	Fri, 14 Apr 2023 04:00:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vg1xOPx_1681444852;
Message-ID: <202ec911-85fb-4afa-1970-652085830fc8@linux.alibaba.com>
Date: Fri, 14 Apr 2023 12:00:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org,
 Parav Pandit <parav@nvidia.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20230403045833.21853-1-hengqi@linux.alibaba.com>
 <1d30d4a0-6bfc-3d58-17a4-645602d3792f@redhat.com>
 <a95ca379-0675-9b33-f649-bd2a19b56190@linux.alibaba.com>
 <20230413174525-mutt-send-email-mst@kernel.org>
 <CACGkMEttCB7J4bd8HoB4z7zQrhZArBHCECWcuuHy2eJVoV7tew@mail.gmail.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <CACGkMEttCB7J4bd8HoB4z7zQrhZArBHCECWcuuHy2eJVoV7tew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] Re: [virtio-comment] Re: [PATCH v12] virtio-net:
 support inner header hash



在 2023/4/14 上午11:10, Jason Wang 写道:
> On Fri, Apr 14, 2023 at 5:46 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>> On Thu, Apr 13, 2023 at 07:03:26PM +0800, Heng Qi wrote:
>>>>>    For example, when the packets of certain
>>>>> +tunnels are spread across multiple receive queues, these receive
>>>>> queues may have an unbalanced
>>>>> +amount of packets. This can cause a specific receive queue to
>>>>> become full, resulting in packet loss.
>>>>
>>>> We have many places that can lead to packet dropping. For example, the
>>>> automatic steering is best effort. I tend to avoid mentioning things
>>>> like this.
>>> Ok. And Michael what do you think about this?
>>
>> I think this text did not do a great job explaining the
>> security aspect. Here's a better, shorter explanation:
>>
>>          It is often an expectation of users that a tunnel isolates the external
>>          network from the internal one. By completely ignoring entropy in the
>>          external header and replacing it with entropy from the internal header,
>>          for hash calculations, this expectation might be violated to a certain
>>          extent, depending on how the hash is used. When the hash use is limited
>>          to RSS queue selection, the effect will likely be limited to ability of
>>          users inside the tunnel to cause packet drops in multiple queues (as
>>          opposed to a single queue without the feature).
> And this is only for GRE-in-UDP? This makes me think if we should add
> GRE support for the outer header like:
>
> https://docs.napatech.com/r/Feature-Set-N-ANL9/Hash-Key-Type-10-3-Tuple-GREv0

I think this is for tunneling protocols with specific flow fields, such 
as GRE:key filed, NVGRE:FLOWID filed.

This requires us to make a requirement when calculating the hash of the 
tunnels when F_TUNNEL_HASH is not negotiated. It's a new work.

Thanks.

>
> Thanks
>
>
>>>>
>>>>> +
>>>>> +Possible mitigations:
>>>>> +\begin{itemize}
>>>>> +\item Use a tool with good forwarding performance to keep the
>>>>> receive queue from filling up.
>>>>> +\item If the QoS is unavailable, the driver can set
>>>>> \field{hash_tunnel_types} to VIRTIO_NET_HASH_TUNNEL_TYPE_NONE
>>>>> +      to disable inner header hash for encapsulated packets.
>>>>> +\item Choose a hash key that can avoid queue collisions.
>>>>> +\item Perform appropriate QoS before packets consume the receive
>>>>> buffers of the receive queues.
>>>>> +\end{itemize}
>>>>> +
>>>>> +The limitations mentioned above exist with/without the inner header
>>>>> hash.
>>>>
>>>> This conflicts with the tile "Tunnel QoS limitation" which readers may
>>>> think it happens only for tunnel.
>>> Perhaps a "QoS Advices" is better?
>> Plural of "advice" is "advice" not "advices".
>>
>> This advice is somewhat bogus though.
>>
>> The point I keep trying to make is that this:
>>
>>          Choose a hash key that can avoid queue collisions.
>>
>> is impossible with the feature and possible without.
>> This was the whole reason I asked for a security
>> considerations sections.
>>
>> --
>> MST
>>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

