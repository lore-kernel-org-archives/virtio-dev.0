Return-Path: <virtio-dev-return-13141-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 222FAEB64D7
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 03:32:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 79B3CC6107
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 03:32:12 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5A7B19865AA
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 03:32:12 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 458DA98658B; Thu, 29 Jun 2023 03:32:12 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 32FA8986590
	for <virtio-dev@lists.oasis-open.org>; Thu, 29 Jun 2023 03:32:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: ioxn6_A3PwWVQydj7HoKvA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688009529; x=1690601529;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kI5IOUeZJ/vHqBN7sqfgEDhZdVbaSKz3RpS2au4PPu0=;
        b=Uv5aniIE68l4zgjkdG4KDohJcZTbNtKhRxIIg8jJ9VsAhpJz8k2kiG8VJXIvx9PLg9
         w+iA3TB/MYoQesUeXXYyPYtmMfedJXThoZHanQC2x3zfXYYGFtXcMtlpP8k5eAehheX7
         Qw1gsmkxJCftV+oWC6t4FDknrWIHECRluMG+x2aR5NeqTQQvzJyk9UwVtjtQtQHCgRT1
         fMEC3huM8G8PGCY4XjaNa+0MrlmZ3unZPfBjJw1y5ARs5GJ3SFPUrw/qvIixI7oNvtCO
         qwav0LBUwskkrENNzQs3qDx/jwHtDP6HwGr/scmJ932Qp0OXj4NXVVedJa2TqC04adOU
         5lDQ==
X-Gm-Message-State: AC+VfDz5KQKEghVcqzthjjoESed5DqPE/QUXLeeU9c/HjXPuX7ao7Ay6
	ijcvxCisatdkEqbA1icwZxex58E/2O2aUd/B8aPV9A1yGIw0F2zK+D1hnv677DmQH3WDIVOv6Ux
	ddpQfm0u0q18nhjn1TkTeb1LGjUu9
X-Received: by 2002:a17:90b:4d83:b0:263:4164:dfba with SMTP id oj3-20020a17090b4d8300b002634164dfbamr3149158pjb.6.1688009528926;
        Wed, 28 Jun 2023 20:32:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6q/WyQczcM65401ZAq7i/3V2e/Cybblvzag8eS9cEpcshnrGWvr/siUm0qncI3nezg+HAb+w==
X-Received: by 2002:a17:90b:4d83:b0:263:4164:dfba with SMTP id oj3-20020a17090b4d8300b002634164dfbamr3149150pjb.6.1688009528620;
        Wed, 28 Jun 2023 20:32:08 -0700 (PDT)
Message-ID: <2522ab61-a333-a33b-784c-01ea6b4b42da@redhat.com>
Date: Thu, 29 Jun 2023 11:31:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, virtio-comment@lists.oasis-open.org,
 virtio-dev@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20230627163549.40028-1-hengqi@linux.alibaba.com>
 <CACGkMEvFmAiWDp8w=ytin21Oi+PcTb1X3Eve7Kt2NVr_RkhgmA@mail.gmail.com>
 <20230628060519-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230628060519-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [PATCH v19] virtio-net: support inner header hash


在 2023/6/28 18:10, Michael S. Tsirkin 写道:
> On Wed, Jun 28, 2023 at 11:46:22AM +0800, Jason Wang wrote:
>> On Wed, Jun 28, 2023 at 12:35 AM Heng Qi <hengqi@linux.alibaba.com> wrote:
>>> 1. Currently, a received encapsulated packet has an outer and an inner header, but
>>> the virtio device is unable to calculate the hash for the inner header. The same
>>> flow can traverse through different tunnels, resulting in the encapsulated
>>> packets being spread across multiple receive queues (refer to the figure below).
>>> However, in certain scenarios, we may need to direct these encapsulated packets of
>>> the same flow to a single receive queue. This facilitates the processing
>>> of the flow by the same CPU to improve performance (warm caches, less locking, etc.).
>>>
>>>                 client1                    client2
>>>                    |        +-------+         |
>>>                    +------->|tunnels|<--------+
>>>                             +-------+
>>>                                |  |
>>>                                v  v
>>>                        +-----------------+
>>>                        | monitoring host |
>>>                        +-----------------+
>>>
>>> To achieve this, the device can calculate a symmetric hash based on the inner headers
>>> of the same flow.
>>>
>>> 2. For legacy systems, they may lack entropy fields which modern protocols have in
>>> the outer header, resulting in multiple flows with the same outer header but
>>> different inner headers being directed to the same receive queue. This results in
>>> poor receive performance.
>>>
>>> To address this limitation, inner header hash can be used to enable the device to advertise
>>> the capability to calculate the hash for the inner packet, regaining better receive performance.
>>>
>>> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/173
>>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
>>> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>>> ---
>>> v18->v19:
>>>          1. Have a single structure instead of two. @Michael S . Tsirkin
>>>          2. Some small rewrites. @Michael S . Tsirkin
>>>          3. Rebase to master.
>>>
>>> v17->v18:
>>>          1. Some rewording suggestions from Michael (Thanks!).
>>>          2. Use 0 to disable inner header hash and remove
>>>             VIRTIO_NET_HASH_TUNNEL_TYPE_NONE.
>>> v16->v17:
>>>          1. Some small rewrites. @Parav Pandit
>>>          2. Add Parav's Reviewed-by tag (Thanks!).
>>>
>>> v15->v16:
>>>          1. Remove the hash_option. In order to delimit the inner header hash and RSS
>>>             configuration, the ability to configure the outer src udp port hash is given
>>>             to RSS. This is orthogonal to inner header hash, which will be done in the
>>>             RSS capability extension topic (considered as an RSS extension together
>>>             with the symmetric toeplitz hash algorithm, etc.). @Parav Pandit @Michael S . Tsirkin
>>>          2. Fix a 'field' typo. @Parav Pandit
>>>
>>> v14->v15:
>>>          1. Add tunnel hash option suggested by @Michael S . Tsirkin
>>>          2. Adjust some descriptions.
>>>
>>> v13->v14:
>>>          1. Move supported_hash_tunnel_types from config space into cvq command. @Parav Pandit
>> I may miss some discussions, but this complicates the provisioning a lot.
>>
>> Having it in the config space, then a type agnostic provisioning
>> through config space + feature bits just works fine.
>>
>> If we move it only via cvq, we need device specific provisioning interface.
>>
>> Thanks
> Yea that's what I said too. Debugging too.  I think we should build a
> consistent solution that allows accessing config space through DMA,
> separately from this effort.  Parav do you think you can live with this
> approach so this specific proposal can move forward?


We can probably go another way, invent a new device configuration space 
capability which fixed size like PCI configuration access capability?

struct virtio_pci_cfg_cap {
         struct virtio_pci_cap cap;
         u8 dev_cfg_data[4]; /* Data for device configuration space 
access. */
};

So it won't grow as the size of device configuration space grows.

Thanks


>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

