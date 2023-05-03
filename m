Return-Path: <virtio-dev-return-12508-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AEBCC77B7F
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 12:13:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 845AA2CAD4
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 12:13:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 577729866AE
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 12:13:19 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3FF52986586; Wed,  3 May 2023 12:13:19 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2DCB6986587
	for <virtio-dev@lists.oasis-open.org>; Wed,  3 May 2023 12:13:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: HO9t7JVdNvuSnci17By_Bw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683115995; x=1685707995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QoebIRsfYnkRE4a4+0vvaV8EtKm1li2acPw6aTCsw8w=;
        b=SSRynKvZ+aAOqPO4YRGzIw4H1MMmv0j7N+wGcNEcX0t+ICd/wssyPdQxB7pMZxQfT9
         kByErvMsYACf4fgMxOwbBBMyVbGGIg/6rRb+z8TyN3tt049RKjhQbStG0jJFzDxHhjLM
         P3cDzQU3l89izheSm3+H0C4jm4/nwsKxn6meID8C1q/G2YPouZ1oQNhkkLeBeaSePnTo
         O0iObV+4dtJBL18q5T6mE4FsmqoqHY9uVcxZOz2zi4UTsKkI1E9Q7bgEcuB49jl+Spu9
         m3Zvq6Xgg4W/xJcpMPbgA0nhSgF468T+vSZMDyEKLv2pbUQ6GDN/B1ZXIwjsO5OPy/I2
         kkeQ==
X-Gm-Message-State: AC+VfDxedfBdZWUxiWVmyQvZRZ5VvxwA/OlSiDz+lNhECcQaLIPvBfYU
	tkNwFKWkQIJLpvbbhPRfm5g+tgrV5NJC1eoFKGMA3sK06XxO1cXL9aFWpOGDtbhvuHLK3xdpXC7
	DSwUqcJGN+iqhXi43qMimZHdqAf5l
X-Received: by 2002:a7b:c408:0:b0:3f1:75b6:8c7 with SMTP id k8-20020a7bc408000000b003f175b608c7mr14043844wmi.37.1683115995248;
        Wed, 03 May 2023 05:13:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ67lm3NwTO03hE2PmJip283wLLIfqmiPdSnznYPeWJRfBG58fEWJZMqmPER/CfifMqoJCwIlw==
X-Received: by 2002:a7b:c408:0:b0:3f1:75b6:8c7 with SMTP id k8-20020a7bc408000000b003f175b608c7mr14043812wmi.37.1683115994929;
        Wed, 03 May 2023 05:13:14 -0700 (PDT)
Date: Wed, 3 May 2023 14:13:10 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Vishnu Dasa <vdasa@vmware.com>, virtio-dev@lists.oasis-open.org, 
	linux-hyperv@vger.kernel.org, Cong Wang <cong.wang@bytedance.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, netdev@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>, 
	Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	virtualization@lists.linux-foundation.org, Bryan Tan <bryantan@vmware.com>, 
	Eric Dumazet <edumazet@google.com>, Jiang Wang <jiang.wang@bytedance.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	linux-kernel@vger.kernel.org
Message-ID: <4ikawh4kks22iqjdkhbvkak7spoja6zr3g22pke2r3jsqgpddp@bx6purfp4f6a>
References: <20230413-b4-vsock-dgram-v2-0-079cc7cee62e@bytedance.com>
 <ZDk2kOVnUvyLMLKE@bullseye>
 <r6oxanmhwlonb7lcrrowpitlgobivzp7pcwk7snqvfnzudi6pb@4rnio5wef3qu>
 <ZDpOq0ACuMYIUbb1@bullseye>
 <yeu57zqwzcx33sylp565xgw7yv72qyczohkmukyex27rcdh6mr@w4x6t4enx6iu>
 <ZDrI2bBhiamYBKUB@bullseye>
MIME-Version: 1.0
In-Reply-To: <ZDrI2bBhiamYBKUB@bullseye>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH RFC net-next v2 0/4] virtio/vsock: support datagrams

On Sat, Apr 15, 2023 at 03:55:05PM +0000, Bobby Eshleman wrote:
>On Fri, Apr 28, 2023 at 12:43:09PM +0200, Stefano Garzarella wrote:
>> On Sat, Apr 15, 2023 at 07:13:47AM +0000, Bobby Eshleman wrote:
>> > CC'ing virtio-dev@lists.oasis-open.org because this thread is starting
>> > to touch the spec.
>> >
>> > On Wed, Apr 19, 2023 at 12:00:17PM +0200, Stefano Garzarella wrote:
>> > > Hi Bobby,
>> > >
>> > > On Fri, Apr 14, 2023 at 11:18:40AM +0000, Bobby Eshleman wrote:
>> > > > CC'ing Cong.
>> > > >
>> > > > On Fri, Apr 14, 2023 at 12:25:56AM +0000, Bobby Eshleman wrote:
>> > > > > Hey all!
>> > > > >
>> > > > > This series introduces support for datagrams to virtio/vsock.
>> > >
>> > > Great! Thanks for restarting this work!
>> > >
>> >
>> > No problem!
>> >
>> > > > >
>> > > > > It is a spin-off (and smaller version) of this series from the summer:
>> > > > >   https://lore.kernel.org/all/cover.1660362668.git.bobby.eshleman@bytedance.com/
>> > > > >
>> > > > > Please note that this is an RFC and should not be merged until
>> > > > > associated changes are made to the virtio specification, which will
>> > > > > follow after discussion from this series.
>> > > > >
>> > > > > This series first supports datagrams in a basic form for virtio, and
>> > > > > then optimizes the sendpath for all transports.
>> > > > >
>> > > > > The result is a very fast datagram communication protocol that
>> > > > > outperforms even UDP on multi-queue virtio-net w/ vhost on a variety
>> > > > > of multi-threaded workload samples.
>> > > > >
>> > > > > For those that are curious, some summary data comparing UDP and VSOCK
>> > > > > DGRAM (N=5):
>> > > > >
>> > > > > 	vCPUS: 16
>> > > > > 	virtio-net queues: 16
>> > > > > 	payload size: 4KB
>> > > > > 	Setup: bare metal + vm (non-nested)
>> > > > >
>> > > > > 	UDP: 287.59 MB/s
>> > > > > 	VSOCK DGRAM: 509.2 MB/s
>> > > > >
>> > > > > Some notes about the implementation...
>> > > > >
>> > > > > This datagram implementation forces datagrams to self-throttle according
>> > > > > to the threshold set by sk_sndbuf. It behaves similar to the credits
>> > > > > used by streams in its effect on throughput and memory consumption, but
>> > > > > it is not influenced by the receiving socket as credits are.
>> > >
>> > > So, sk_sndbuf influece the sender and sk_rcvbuf the receiver, right?
>> > >
>> >
>> > Correct.
>> >
>> > > We should check if VMCI behaves the same.
>> > >
>> > > > >
>> > > > > The device drops packets silently. There is room for improvement by
>> > > > > building into the device and driver some intelligence around how to
>> > > > > reduce frequency of kicking the virtqueue when packet loss is high. I
>> > > > > think there is a good discussion to be had on this.
>> > >
>> > > Can you elaborate a bit here?
>> > >
>> > > Do you mean some mechanism to report to the sender that a destination
>> > > (cid, port) is full so the packet will be dropped?
>> > >
>> >
>> > Correct. There is also the case of there being no receiver at all for
>> > this address since this case isn't rejected upon connect(). Ideally,
>> > such a socket (which will have 100% packet loss) will be throttled
>> > aggressively.
>> >
>> > Before we go down too far on this path, I also want to clarify that
>> > using UDP over vhost/virtio-net also has this property... this can be
>> > observed by using tcpdump to dump the UDP packets on the bridge network
>> > your VM is using. UDP packets sent to a garbage address can be seen on
>> > the host bridge (this is the nature of UDP, how is the host supposed to
>> > know the address eventually goes nowhere). I mention the above because I
>> > think it is possible for vsock to avoid this cost, given that it
>> > benefits from being point-to-point and g2h/h2g.
>> >
>> > If we're okay with vsock being on par, then the current series does
>> > that. I propose something below that can be added later and maybe
>> > negotiated as a feature bit too.
>>
>> I see and I agree on that, let's do it step by step.
>> If we can do it in the first phase is great, but I think is fine to add
>> this feature later.
>>
>> >
>> > > Can we adapt the credit mechanism?
>> > >
>> >
>> > I've thought about this a lot because the attraction of the approach for
>> > me would be that we could get the wait/buffer-limiting logic for free
>> > and without big changes to the protocol, but the problem is that the
>> > unreliable nature of datagrams means that the source's free-running
>> > tx_cnt will become out-of-sync with the destination's fwd_cnt upon
>> > packet loss.
>>
>> We need to understand where the packet can be lost.
>> If the packet always reaches the destination (vsock driver or device),
>> we can discard it, but also update the counters.
>>
>> >
>> > Imagine a source that initializes and starts sending packets before a
>> > destination socket even is created, the source's self-throttling will be
>> > dysfunctional because its tx_cnt will always far exceed the
>> > destination's fwd_cnt.
>>
>> Right, the other problem I see is that the socket aren't connected, so
>> we have 1-N relationship.
>>
>
>Oh yeah, good point.
>
>> >
>> > We could play tricks with the meaning of the CREDIT_UPDATE message and
>> > fwd_cnt/buf_alloc fields, but I don't think we want to go down that
>> > path.
>> >
>> > I think that the best and simplest approach introduces a congestion
>> > notification (VIRTIO_VSOCK_OP_CN?). When a packet is dropped, the
>> > destination sends this notification. At a given repeated time period T,
>> > the source can check if it has received any notifications in the last T.
>> > If so, it halves its buffer allocation. If not, it doubles its buffer
>> > allocation unless it is already at its max or original value.
>> >
>> > An "invalid" socket which never has any receiver will converge towards a
>> > rate limit of one packet per time T * log2(average pkt size). That is, a
>> > socket with 100% packet loss will only be able to send 16 bytes every
>> > 4T. A default send buffer of MAX_UINT32 and T=5ms would hit zero within
>> > 160ms given at least one packet sent per 5ms. I have no idea if that is
>> > a reasonable default T for vsock, I just pulled it out of a hat for the
>> > sake of the example.
>> >
>> > "Normal" sockets will be responsive to high loss and rebalance during
>> > low loss. The source is trying to guess and converge on the actual
>> > buffer state of the destination.
>> >
>> > This would reuse the already-existing throttling mechanisms that
>> > throttle based upon buffer allocation. The usage of sk_sndbuf would have
>> > to be re-worked. The application using sendmsg() will see EAGAIN when
>> > throttled, or just sleep if !MSG_DONTWAIT.
>>
>> I see, it looks interesting, but I think we need to share that
>> information between multiple sockets, since the same destination
>> (cid, port), can be reached by multiple sockets.
>>
>
>Good point, that is true.
>
>> Another approach could be to have both congestion notification and
>> decongestion, but maybe it produces double traffic.
>>
>
>I think this could simplify things and could reduce noise. It is also
>probably sufficient for the source to simply halt upon congestion
>notification and resume upon decongestion notification, instead of
>scaling up and down like I suggested above. It also avoids the
>burstiness that would occur with a "congestion notification"-only
>approach where the source guesses when to resume and guesses wrong.
>
>The congestion notification may want to have an expiration period after
>which the sender can resume without receiving a decongestion
>notification? If it receives congestion again, then it can halt again.

Yep, I agree.

Anyway the congestion/decongestion messages should be just a hint, 
because the other peer has to keep the state and a malicious host/guest 
could use it for DoS, so the peer could discard these packets if it has 
no more space to save the state.

Thanks,
Stefano


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

