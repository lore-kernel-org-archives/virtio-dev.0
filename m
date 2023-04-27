Return-Path: <virtio-dev-return-12446-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96279C77B73
	for <virtio-dev@archiver.kernel.org>; Thu, 27 Apr 2023 08:22:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B97E52AEC2
	for <virtio-dev@archiver.kernel.org>; Thu, 27 Apr 2023 08:22:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A517A986651
	for <virtio-dev@archiver.kernel.org>; Thu, 27 Apr 2023 08:22:34 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8C3B3986641; Thu, 27 Apr 2023 08:22:34 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 75F9D986642
	for <virtio-dev@lists.oasis-open.org>; Thu, 27 Apr 2023 08:22:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682583752; x=1685175752;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1iEFX27gOLKED0gJBOHZ20m6ca7CQKWDk132DtklGDo=;
        b=YnqicNbM8W177JfolzfarI8mbMCeFHj5trTYD6cRZSa53U3VT7JYYMbTOiz7NeXvNx
         8xS54Acc+uMiAnsb778wiC/C2t/cKA7YlUG9pgn7Q0vvapOuFkb+NIEJ1wCzqGFfCDdA
         ihsLmz8OyKSfb9dq+BRuG5S8pel0k1M00hUnwnlrAqYYj/QMqn9UjEOsz9ljSCb3AMCR
         OiJGY1Nr5SsoQKYgF8WOV8bYBwmyq9TuG/cdbz7IqEit5LrbtXKM+MaTpurk1RyLmZxp
         2bpBXpaZCPrRCKWeeeQf1ILONHpIbntAi+hvCwvRXTLLrvqTHyI3vIetPJRF/UlEw2GN
         pXDA==
X-Gm-Message-State: AC+VfDx1j9X+UHWoODoQO+Axi//erFJZhfwSPRBbMmYA+X4n3n6IGC4F
	/5m2sYzNpzCYW2CE0j1igRixzg==
X-Google-Smtp-Source: ACHHUZ5UuI2cDKRy061k/Po+DHCWDcfLjnHjKd1KGUTArNlM5p6Aw6gqHMFHPzZJugVkuE4qbvxX7g==
X-Received: by 2002:a17:902:cec4:b0:19c:f232:21ca with SMTP id d4-20020a170902cec400b0019cf23221camr927289plg.3.1682583752597;
        Thu, 27 Apr 2023 01:22:32 -0700 (PDT)
Message-ID: <5af40945-9f11-93f8-bd2b-3a795d13f06c@bytedance.com>
Date: Thu, 27 Apr 2023 16:20:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Parav Pandit <parav@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>, virtio-dev@lists.oasis-open.org,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 "helei.sig11@bytedance.com" <helei.sig11@bytedance.com>, houp@yusur.tech,
 Jason Wang <jasowang@redhat.com>, jiangzhuo.cs@bytedance.com
References: <1ab0beff-8b18-7a94-1a68-6bf36bcd0394@bytedance.com>
 <CACGkMEvh+G2Tm=WDTOK3K2GO8c2dQ4y=UiKAk_kvsid2MGzbGg@mail.gmail.com>
 <8f65c9aa-c867-0929-151c-21bbe25a0693@bytedance.com>
 <4150bd72-a358-c854-0c64-b149621a1b8d@nvidia.com>
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <4150bd72-a358-c854-0c64-b149621a1b8d@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: Re: [virtio-comment] [PROPOSAL] Virtio Over Fabrics(TCP/RDMA)

On 4/25/23 13:03, Parav Pandit wrote:
> 
> 
[...]
> 
> I briefly see your rdma command descriptor example, which is not aligned 
> to 16B. Perf wise it will be poor than nvme rdma fabrics.
> 

Hi,
I'm confused here, could you please give me more hint?
1, The size of command descriptor(I defined in example) is larger than 
command size of nvme rdma, more overhead leads performance worse than 
nvme over rdma.

2, The command size not aligned to 16B leads performance issue on RDMA 
SEND operation. My colleague Zhuo help me test the performance on 
sending 16/24/32 bytes:
taskset -c 30 ib_send_bw -d mlx5_2 -i 1 -x 3 -s 16 -t 1 xx.xx.xx.xx
taskset -c 30 ib_send_bw -d mlx5_2 -i 1 -x 3 -s 24 -t 1 xx.xx.xx.xx
taskset -c 30 ib_send_bw -d mlx5_2 -i 1 -x 3 -s 32 -t 1 xx.xx.xx.xx
The QPS seems almost same.

> For PCI transport for net, we intent to start the work to improve 
> descriptors, the transport binding for net device. From our research I 
> see that some abstract virtio descriptors are great today, but if you 
> want to get best out of the system (sw, hw, cpu), such abstraction is 
> not the best. Sharing of "id" all the way to target and bring back is an 
> example of such inefficiency in your example.

-- 
zhenwei pi

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

