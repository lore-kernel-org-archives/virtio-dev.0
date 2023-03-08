Return-Path: <virtio-dev-return-11544-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F27EC64EC4
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 17:21:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 56E272AEE2
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 17:21:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3FCB99866F7
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 17:21:54 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2B5259866F0; Wed,  8 Mar 2023 17:21:54 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 19DE49866F1
	for <virtio-dev@lists.oasis-open.org>; Wed,  8 Mar 2023 17:21:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: hKeS_u98O7Cb_0-qdg2now-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678296111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VW0JMB/9Hm6Z06xB7u2xQqU64HWqETYFjaslbTvoEDQ=;
        b=75IEH4omtsTYKTmUgMI3ZOmbNlpXMQcAHjW3wfheNHdPLfm7Ih7mospBRiA0tffcLF
         dWwBC+nm+O8fmLzHUjT8aZnQHL1OVSXgW8YHOSqfj/ii+1d5NUraLoyRjlTOv2t289M3
         bCupf4xOm99r7Qo12EMDFyQp+sbloh3lHxmxcO+oifmHKyV6szozFjxr7U70X1Ggmn38
         BVD5NPl7ys2eb5i9SN3tEW2fLK0q5Eq/1ToIoiEQN4xQ58Uja/ocepOwZlTI3Hu1hqN+
         1VEx0pwojA+LT6vje0pVq1OwVK4y6qQZMAi98LATWdERP9O4tM7iaeMoJ8hVgFH4E3h7
         0HhQ==
X-Gm-Message-State: AO0yUKUxF2K90EKwqkI1YBVuepFX7SvbJY/73s45TDKk5J2T77/Y5ktG
	I9uioruuLu6oO5k+L91aCYSdHxFyX9/Qzq8KmUrrjOJZJ7f6+CKKlw8fyNGIIPDGVJCvdLQKhSi
	T70m4UqHW9f2d2+dY4UW/kaiXuthW
X-Received: by 2002:adf:fe44:0:b0:2c7:bbe:456c with SMTP id m4-20020adffe44000000b002c70bbe456cmr10542879wrs.63.1678296110878;
        Wed, 08 Mar 2023 09:21:50 -0800 (PST)
X-Google-Smtp-Source: AK7set91xLR4bbekx9AFtaMKjB+75s1Dt3aw+hQVndApF+BS4cWk6fAvfbEbE2qKNPlXx4yf+MLYxw==
X-Received: by 2002:adf:fe44:0:b0:2c7:bbe:456c with SMTP id m4-20020adffe44000000b002c70bbe456cmr10542868wrs.63.1678296110534;
        Wed, 08 Mar 2023 09:21:50 -0800 (PST)
Date: Wed, 8 Mar 2023 12:21:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, Jason Wang <jasowang@redhat.com>,
	Zhu Lingshan <lingshan.zhu@intel.com>,
	virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
	sgarzare@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com,
	hang.yuan@intel.com, virtio@lists.oasis-open.org,
	pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
	Parav Pandit <parav@nvidia.com>
Message-ID: <20230308122017-mutt-send-email-mst@kernel.org>
References: <20230305043419-mutt-send-email-mst@kernel.org>
 <20230306000302.GA244754@fedora>
 <7f63fa0a-7deb-5875-6c6b-bfc651681653@redhat.com>
 <20230306112030.GB35392@fedora>
 <853c78d0-f752-05e9-d79d-811e82801627@nvidia.com>
 <20230306162538.GA56760@fedora>
 <e74483a4-38fa-99b5-86b8-785f0b98d029@nvidia.com>
 <20230308141317.GC299426@fedora>
 <18ddbf69-19a6-3c6b-9e42-aaae66e20bcf@nvidia.com>
 <20230308171523.GA320810@fedora>
MIME-Version: 1.0
In-Reply-To: <20230308171523.GA320810@fedora>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio] Re: [PATCH v10 04/10] admin:
 introduce virtio admin virtqueues

On Wed, Mar 08, 2023 at 12:15:23PM -0500, Stefan Hajnoczi wrote:
> > > > > Or we could say that admin commands must complete within bounded time,
> > > > > but I'm not sure that is implementable for some device types like
> > > > > virtio-blk, virtio-scsi, and virtiofs.
> > > > 
> > > > No we can't.
> > > > Some commands, for example FW upgrade can take 10 minutes and it's perfectly
> > > > fine. Other commands like setting feature bit will take 1 millisec.
> > > > Each device implements commands in a different internal logic so we can't
> > > > expect to complete after X time.
> > > 
> > > When I say bounded time, I mean that it finishes in a finite amount of
> > > time. I'm not saying there is a specific time X that all device
> > > implementations must satisfy. Unbounded means it might never finish.
> > 
> > There might be a chance that any command for any virtio device type will
> > never finish. Nothing new here in the adminq.
> > 
> > what one can do is to set a timeout for himself and if this timeout expire -
> > check the device status. If it needs_reset - do a reset. if status is ok,
> > then wait some more time.
> > After X retries, unmap buffers or reset the adminq.
> 
> Michael: What effect does resetting the group owner device have on group
> member devices?

virtio level reset? It's a good question. I'd expect them all to be
reset no?

> I'm concerned that this approach disrupts all group member devices. For
> example, you try to add a new device but the command hangs. In order to
> recover you now have to reset the group owner device and this breaks all
> the group member devices.


I agree. How about a VQ level reset though? Seems like exactly
what's needed here?


> > > 
> > > > Device can go to so FATAL state in case a command is stuck and causing
> > > > internal errors in it.
> > > > 
> > > > > 
> > > > > > For your example, stopping a member is possible even it there are some
> > > > > > errors in the network. You can for example destroy all the connections to
> > > > > > the remote target and complete all the BIOS with some error.
> > > > > 
> > > > > Forgetting about in-flight requests doesn't necessarily make them go
> > > > > away. It creates a race between forgotten requests and reconnection. In
> > > > > the worst case a forgotten write request takes effect after
> > > > > reconnection, causing data corruption.
> > > > 
> > > > For making it work without data corruption we need a cooperation of the
> > > > target side for sure. But this is fine since the target in that case is part
> > > > of the "virtio-blk backend".
> > > > One solution is that the target can decide it will flush all the requests to
> > > > the storage device before accepting new connections.
> > > 
> > > This solution shifts the unbounded time from disconnection to
> > > connection. The Group Member Delete command will complete quickly but a
> > > subsequent Group Member Create command for the same underlying storage
> > > device would need to wait until the requests are done.
> > > 
> > > Therefore I think the admin queue must be designed under the assumption
> > > that some commands take a very long time.
> > 
> > For sure an admin command may take long time. FW upgrade can take 10 minutes
> > for example.
> > But each device is free to implement internal logic as he choose.
> > 
> > Same for live migration, when we stop/quiesce a device we must make sure it
> > doesn't master any DMA operations. Thus, in some implementations we need to
> > wait for all inflights to end fast. In others, we can invalidate the access
> > to host/guest memory and wait for completions until the freeze state.
> > 
> > Bottom line, this is device implementation specific consideration.
> 
> What I'm asking is that the spec clarifies the command completion order
> semantics (in-order or out-of-order), whether there is a mechanism to
> abort commands, etc.
> 
> Device implementers can then take advantage of those aspects to
> implement devices that don't hang (e.g. health monitoring becomes
> unavailable when there is a long running command).
> 
> If the spec doesn't cover this, then device implementers will not be
> able to work around it when implementing standard commands like
> create/delete group member.
> 
> Does that make sense?
> 
> Stefan

It does, to me.



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

