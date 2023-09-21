Return-Path: <virtio-dev-return-13892-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DAC0CD4941
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 03:18:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 745382CAE7
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 03:18:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 68B23986689
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 03:18:44 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5CAA3983D6F; Thu, 21 Sep 2023 03:18:44 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4C36598667C
	for <virtio-dev@lists.oasis-open.org>; Thu, 21 Sep 2023 03:18:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: L61ZP_xyM8a7fmxAxF9muQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695266320; x=1695871120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nHC6abbz6vFR7M1quCA+1Zrook1njO/jfk6KqszQYRo=;
        b=e+Y0dlHU6NYaKJumcyqucFciycuq8FwsGwoJVCgbSQ1uigG24YB2N3IHfwryg6e07B
         qyP14nzQ+BAKpUhK+rsPhqfYf3RKIoL5ie3WQmJAzQzL1i0PW19mspLEJl7lgehwujYl
         ujMxMmqv7OHvN7/7dxRg8N8FfPBtd/OBfOVsGxFzRXMDYuAgFrj3bBClnB6CYlXnOolp
         ovr6vcuzCL+1SzGX1MG8QkBPtWBRoreJB8O0y65eVCCguaNk8KI8hpO9AHxPMunaWq3Z
         Dwm6eu0lRej6QR18YwY5/Ad8Er7kvBGQwjE6n9EhFKqSBrr7jSFox8RhnE3T4mshWqi5
         nVFA==
X-Gm-Message-State: AOJu0YxRIpW98Xa/BpYOkXqRkWeUMWujVpNzeSle+AXBxIkvZKi6JpaR
	zHH+2bHzjAmuohh4+hUw0WMlf+XIlpHkY78GLzsHPzONQ5ykclRb9CENZt+ES85RGV8UyXvzE0A
	//erx+jd9/eDWK1OY+FqtU2vM8rXKdyACyqYcz/gN0QlA
X-Received: by 2002:a19:9147:0:b0:500:780b:5bdc with SMTP id y7-20020a199147000000b00500780b5bdcmr3766688lfj.49.1695266320636;
        Wed, 20 Sep 2023 20:18:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFr+cwPtCUSvjNR5vKLa889oXL91S39lH2GMyWW+tfD+VXS2iGeX/rO47ByMIXQ9ItdqhEjy2RcqwikyA8PhIU=
X-Received: by 2002:a19:9147:0:b0:500:780b:5bdc with SMTP id
 y7-20020a199147000000b00500780b5bdcmr3766683lfj.49.1695266320259; Wed, 20 Sep
 2023 20:18:40 -0700 (PDT)
MIME-Version: 1.0
References: <213a0f94-cee2-d8c5-3c5d-d2d7fc920e75@intel.com>
 <PH0PR12MB5481AE8C6E5EAFE9A4ADA6F6DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <f1fe513e-d42d-03a6-348c-5e58aac0a759@intel.com> <PH0PR12MB5481323A3B4D67EB66328476DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5f01772f-eb27-bfe0-7f69-b83fbd90dda0@intel.com> <PH0PR12MB5481ABF4B9BC2082BC54AB1DDCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230918144312-mutt-send-email-mst@kernel.org> <bb402c34-ad07-063a-f4f5-d8c6b3a642c7@intel.com>
 <20230920054836-mutt-send-email-mst@kernel.org> <2f67fb85-2238-9c34-a265-b0f97b7ab7e1@intel.com>
 <20230920075243-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230920075243-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 21 Sep 2023 11:18:29 +0800
Message-ID: <CACGkMEsVtZ19KQt5QmHZV_AbGdoTf0fOx-QQHLeNv6UoMBWJnQ@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Zhu, Lingshan" <lingshan.zhu@intel.com>, Parav Pandit <parav@nvidia.com>, 
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq state

On Wed, Sep 20, 2023 at 8:05=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Sep 20, 2023 at 07:22:32PM +0800, Zhu, Lingshan wrote:
> >
> >
> > On 9/20/2023 6:36 PM, Michael S. Tsirkin wrote:
> > > On Wed, Sep 20, 2023 at 02:06:13PM +0800, Zhu, Lingshan wrote:
> > > >
> > > > On 9/19/2023 2:49 AM, Michael S. Tsirkin wrote:
> > > > > On Mon, Sep 18, 2023 at 06:41:55PM +0000, Parav Pandit wrote:
> > > > > > > Please refer to the code for setting FEATURES_OK.
> > > > > > It wont work when one needs to suspend the device.
> > > > > > There is no point of doing such work over registers as fundamen=
tal framework is over the AQ.
> > > > > Well not really. It's over admin commands. When these were built =
the
> > > > > intent always was that it's possible to use admin commands throug=
h
> > > > > another interface, other than admin queue. Is there a problem
> > > > > implementing admin commands over a memory BAR? For example, I can=
 see
> > > > > an "admin command" capability pointing at a BAR where
> > > > > commands are supplied, and using a new group type referring to
> > > > > device itself.
> > > > I am not sure, if a bar cap would be implemented as a proxy for the=
 admin vq
> > > > based live migration.
> > > Not a proxy for a vq in that there's no vq then.
> > I think if the driver sends admin commands through a VF's bar, then
> > VF forwards the admin commands to the PF, it acts like a proxy,
> > or an agent. Anyway it takes admin commands.
>
> Why send them to the PF? They are controlling the VF anyway.
>
> > So the problems we have discussed still exist.
> > >
> > > > then the problems of admin vq LM that we have
> > > > discussed
> > > > still exist.
> > > I freely admit the finer points of this extended flamewar have been l=
ost
> > > on me, and I wager I'm not the only one. I thought you wanted to migr=
ate
> > > the device just by accessing the device itself (e.g. the VF) without
> > > accessing other devices (e.g. the PF), while Parav wants it in a
> > > separate device so the whole of the device itself can passed through =
to
> > > guest. Isn't this, fundamentally, the issue?
> > we are implementing basic facilities for live migration.
> >
> > We have pointed out lots of issues, there are many discussions with
> > Jason and Parav about the problems in migration by admin vq, for exampl=
e:
> > security, QOS and nested.
>
> /me shrugs
> Thanks for the summary I guess. Same applies to almost any proposal.

So it's something we need to consider in the virtio as well and it is
raised by different people. (Correct me if I was wrong)

Security, Parav.
Nest, me
QOS, LingShan

> What would help make progress is an explanation why this has grown into
> a megathread.  Do you understand Parav's thoughts well enough to
> summarize them?
>
> > >
> > > > the bar is only a proxy, doesn't fix anything. and even larger
> > > > side channel attacking surface: vf-->pf-->vf
> > > In this model there's no pf. BAR belongs to vf itself
> > > and you submit commands for the VF through its BAR.
> > > Just separate from the pci config space.
> > If using the bar to process admin commands,
> > is this solution too heavy compared to my proposal in this series?
>
> somewhat - because it's more comprehensive - you can actually
> migrate a device using it.

But it's not a must. And there will be a lot of duplication where it
will become a transport.

> this series just begins to define how to poke at some
> of the vq state - it's a subset of the necessary functionality.

It defines the minimal set of the functionality. We can have more for sure.

>
> And it will give you a bunch of side benefits, such as
> support for legacy compat commands that were merged.

Legacy has too many corner cases and why do we need to do such
revinenting of wheels? We had already had transitional devices for
years.

>
>
>
> > >
> > > The whole attacking surface discussion is also puzzling.  We either a=
re
> > > or are not discussing confidential computing/TDI.  I couldn't figure
> > > it out. This needs a separate thread I think.
> > I agree confidential computing is out of spec. Parva mentioned TDISP an=
d
> > even
> > in TDISP spec, it explicitly defined some attacking model, and PF is an
> > example.
> >
> > It is out of spec anyway.
>
> OK so we are ignoring TDISP applications for now? Everyone agrees on
> that?

I'm fine. But TDISP is something that needs to be considered. The
earlier we realize the possible issue the better.

Thanks




>
> --
> MST
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

