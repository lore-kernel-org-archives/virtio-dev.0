Return-Path: <virtio-dev-return-11429-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA265C61DA4
	for <virtio-dev@archiver.kernel.org>; Sun,  5 Mar 2023 09:52:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id BB2227C386
	for <virtio-dev@archiver.kernel.org>; Sun,  5 Mar 2023 09:52:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9ACBB986467
	for <virtio-dev@archiver.kernel.org>; Sun,  5 Mar 2023 09:52:02 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7B19C98638A; Sun,  5 Mar 2023 09:52:02 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6661698638B
	for <virtio-dev@lists.oasis-open.org>; Sun,  5 Mar 2023 09:52:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: dVUq9JVJMS-3N6RUaNN6_Q-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678009918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wG6/1zGawaKNDlMomaUl0ZeJ4VFpPMtvBYG+dbvPJzw=;
        b=rxZPK1dtgtClACuNt1lJjzXrfRtVbJw6S2DLYppDXPwIwQMaAyOms4u60nt9WPIZb7
         MlNEBCpyvgl/pWZW7W1BkOobXkJcQurP2scATF7731xGjbNLfqaCkCoJBhmeN1ULmrCW
         OtAIPfoLAeEzEKFzZBR3kbW6JatiRUdlvUVn7UrOVPNVXbdcnL2P9DHNjhPn/bk3F3nF
         A+UqrT7PkM056kiKOV6Y3J80XGSrxVxQSmldjB2DPImt9zT+lI6V7l20aUCVP0VCLluJ
         oBjDBjrEOv//GJoOSC4NmI1TF84M9mMFJRAHkurMqkz8SQSelF3tpSW0s+OFQ+EKK20I
         TDJQ==
X-Gm-Message-State: AO0yUKXtlp+qVywDs6BJn1JsBWMeoZM1sOAb2Aq70VvrxHrAIbTJtpc+
	2kgaPQTjYSV7LAhzXEDKhB14DDrCFji2OcwnHCWu4Hr3R/jo1tebXidzSSqyKoLYoogp7Y2bbaU
	cbxAGDsruBXv3TJrMYSwxByTF5eWN
X-Received: by 2002:adf:fc4f:0:b0:2ce:5056:7220 with SMTP id e15-20020adffc4f000000b002ce50567220mr2297928wrs.51.1678009918744;
        Sun, 05 Mar 2023 01:51:58 -0800 (PST)
X-Google-Smtp-Source: AK7set98FUfjhupZTHnFsw4q1KjqwcPXxN3Huadmrz6YldsWgMs5k1rQcfx1U+q7uuOvlVOPbMhCKg==
X-Received: by 2002:adf:fc4f:0:b0:2ce:5056:7220 with SMTP id e15-20020adffc4f000000b002ce50567220mr2297918wrs.51.1678009918419;
        Sun, 05 Mar 2023 01:51:58 -0800 (PST)
Date: Sun, 5 Mar 2023 04:51:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Parav Pandit <parav@nvidia.com>,
	virtio-dev@lists.oasis-open.org,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
Message-ID: <20230305043948-mutt-send-email-mst@kernel.org>
References: <20230223054624.168042-1-parav@nvidia.com>
 <87a60z5wes.fsf@redhat.com>
 <20230301182207.23f995cd.pasic@linux.ibm.com>
 <20230301123044-mutt-send-email-mst@kernel.org>
 <87a60vmbub.fsf@redhat.com>
 <20230303023949-mutt-send-email-mst@kernel.org>
 <20230303224937.62fe64b9.pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20230303224937.62fe64b9.pasic@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] Re: [virtio-comment] Re: [PATCH 0/3] Rename queue
 index to queue number

On Fri, Mar 03, 2023 at 10:49:37PM +0100, Halil Pasic wrote:
> On Fri, 3 Mar 2023 02:42:49 -0500
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > > >
> > > > And then for extra fun, in the RSS section we say "0 based index" where we
> > > > seem to mean "this number in the queue name, but subtract 1 in your head".
> > > > Why subtract 1? I guess we wanted these 5 year olds to practice math ...  
> > > 
> > > Heh :)
> > > 
> > > Yeah, that looks like a mess... I don't think we should use a weird
> > > substraction scheme. I haven't looked at the RSS stuff much, would it be
> > > hard to fix it up?  
> > 
> > We can't change the ABI, I guess we can say that it's bits 1 to 15
> > of the VQ number or equivalently VQ number divided
> > by 2 (it's always an even number for any receiveq).
> 
> I don't think it would require an ABI change. We could just change the
> queue names. AFAIK those are not part of the ABI. I don't think it would
> be hard.

Well at the moment this is the mapping:

RSS index -  queue name - virtio pci vqn

0		receiveq1	0
1		receiveq2	2
2		receiveq3	4
3		receiveq4	6




> BTW what speaks for "VQ number" over "VQ index"?
> 
> Regards,
> Halil

We use "vq index" when referring to queue_select.

But, we use "vq number" when talking about notifications.

For fun MMIO calls the queue size field QueueNum


So both number and index are taken by things other than the number,
changing the meaning can confuse existing users.  Ideally we'd use some
other new term to avoid confusion but I could not come up with one so
far.  I feel there's less of a chance of a confusion between VQ size and
its number. But it's not a strong prefrence, RSS is relatively young
and it's the only incompatible user of index so far.


-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

