Return-Path: <virtio-dev-return-13890-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F6A5CD4941
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 03:14:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B091F26A33
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 03:14:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8933A986687
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 03:14:48 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6A9079864C1; Thu, 21 Sep 2023 03:14:48 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 565C498667C
	for <virtio-dev@lists.oasis-open.org>; Thu, 21 Sep 2023 03:14:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: Gse2vAP2OgKyTEuvQgQj3w-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695266084; x=1695870884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ok3iUmGWbfStzUoxnpQFjhJCZHvVlGIBzWc30MCuabE=;
        b=iLheFeHI3WihFct0TiwSKAAWwHaPoIqqEYLlovblZ2K/An9l2KwHcE95J0pG/PK2LW
         wbfF5o35ys0iKfFdU5z2WOVY3eUa+RP+d4zZpDdy5ZSu7hx41f8voA2sFs0KpVxITD9H
         M/LFUHWvF53DsA4xYMzpgCApZsVyxH6PdzjZU77mmbssnzZa6t1CmghHKkLjI+WOZlwj
         YTT7RmYSgHoMglH307hk+1iYcth+pcOeYJJwy1qqevzf569NFpDXSPVRCUckldhEaQkL
         argivR91pQHA4bxDhoN3cVEX3/lV67pzUtXHSXQyM91IH6miDyMzZAvyeTHhASMGwgJl
         q8xQ==
X-Gm-Message-State: AOJu0YxJFVFXtiG8cejDUsX+OucxaLhklrUWftRFAccTJf3wsCbseVc6
	2WKqMsZUY1pSycTLZFc14LxFnAX7HxBA7EI5QESWPYLxon41Ed750rusebhLp6bbwydIGpHGUSf
	ZC9tn/mm/Z5Gll8xXq3kVVH3PUsbcLsPvjEGilrVtwABU
X-Received: by 2002:ac2:4990:0:b0:503:985:92c4 with SMTP id f16-20020ac24990000000b00503098592c4mr2882254lfl.52.1695266084518;
        Wed, 20 Sep 2023 20:14:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbHkZWztW6O6dR8O6ly9vIGJuy+6yZ7yDb61TvCKWD+y+EZafCurvidtC8tDyZVuYWYE3+88whH0lPDYqFlyE=
X-Received: by 2002:ac2:4990:0:b0:503:985:92c4 with SMTP id
 f16-20020ac24990000000b00503098592c4mr2882243lfl.52.1695266084127; Wed, 20
 Sep 2023 20:14:44 -0700 (PDT)
MIME-Version: 1.0
References: <f1fe513e-d42d-03a6-348c-5e58aac0a759@intel.com>
 <PH0PR12MB5481323A3B4D67EB66328476DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5f01772f-eb27-bfe0-7f69-b83fbd90dda0@intel.com> <PH0PR12MB5481ABF4B9BC2082BC54AB1DDCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230918144312-mutt-send-email-mst@kernel.org> <bb402c34-ad07-063a-f4f5-d8c6b3a642c7@intel.com>
 <20230920054836-mutt-send-email-mst@kernel.org> <2f67fb85-2238-9c34-a265-b0f97b7ab7e1@intel.com>
 <20230920075243-mutt-send-email-mst@kernel.org> <ec70e1c7-ffc3-fb6e-0b0a-6f51d7d9d0a5@intel.com>
 <20230920083057-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230920083057-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 21 Sep 2023 11:14:32 +0800
Message-ID: <CACGkMEuAEOVvrw2SKhP2fpcDjvtVvYOv21BGoA7RU_3S+AFxYw@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Zhu, Lingshan" <lingshan.zhu@intel.com>, Parav Pandit <parav@nvidia.com>, 
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq state

On Wed, Sep 20, 2023 at 8:40=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Sep 20, 2023 at 08:16:13PM +0800, Zhu, Lingshan wrote:
> >
> >
> > On 9/20/2023 8:05 PM, Michael S. Tsirkin wrote:
> > > On Wed, Sep 20, 2023 at 07:22:32PM +0800, Zhu, Lingshan wrote:
> > > >
> > > > On 9/20/2023 6:36 PM, Michael S. Tsirkin wrote:
> > > > > On Wed, Sep 20, 2023 at 02:06:13PM +0800, Zhu, Lingshan wrote:
> > > > > > On 9/19/2023 2:49 AM, Michael S. Tsirkin wrote:
> > > > > > > On Mon, Sep 18, 2023 at 06:41:55PM +0000, Parav Pandit wrote:
> > > > > > > > > Please refer to the code for setting FEATURES_OK.
> > > > > > > > It wont work when one needs to suspend the device.
> > > > > > > > There is no point of doing such work over registers as fund=
amental framework is over the AQ.
> > > > > > > Well not really. It's over admin commands. When these were bu=
ilt the
> > > > > > > intent always was that it's possible to use admin commands th=
rough
> > > > > > > another interface, other than admin queue. Is there a problem
> > > > > > > implementing admin commands over a memory BAR? For example, I=
 can see
> > > > > > > an "admin command" capability pointing at a BAR where
> > > > > > > commands are supplied, and using a new group type referring t=
o
> > > > > > > device itself.
> > > > > > I am not sure, if a bar cap would be implemented as a proxy for=
 the admin vq
> > > > > > based live migration.
> > > > > Not a proxy for a vq in that there's no vq then.
> > > > I think if the driver sends admin commands through a VF's bar, then
> > > > VF forwards the admin commands to the PF, it acts like a proxy,
> > > > or an agent. Anyway it takes admin commands.
> > > Why send them to the PF? They are controlling the VF anyway.
> > I think its still too heavy compared to this series proposal
>
> it will be on you to prove all the complexity is unnecessary though.
>
> > >
> > > > So the problems we have discussed still exist.
> > > > > > then the problems of admin vq LM that we have
> > > > > > discussed
> > > > > > still exist.
> > > > > I freely admit the finer points of this extended flamewar have be=
en lost
> > > > > on me, and I wager I'm not the only one. I thought you wanted to =
migrate
> > > > > the device just by accessing the device itself (e.g. the VF) with=
out
> > > > > accessing other devices (e.g. the PF), while Parav wants it in a
> > > > > separate device so the whole of the device itself can passed thro=
ugh to
> > > > > guest. Isn't this, fundamentally, the issue?
> > > > we are implementing basic facilities for live migration.
> > > >
> > > > We have pointed out lots of issues, there are many discussions with
> > > > Jason and Parav about the problems in migration by admin vq, for ex=
ample:
> > > > security, QOS and nested.
> > > /me shrugs
> > > Thanks for the summary I guess. Same applies to almost any proposal.
> > > What would help make progress is an explanation why this has grown in=
to
> > > a megathread.  Do you understand Parav's thoughts well enough to
> > > summarize them?
> > as far as I see, I don't see admin vq as must for live migration.
> > and it does not serve nested for sure.
> > >
> > > > > > the bar is only a proxy, doesn't fix anything. and even larger
> > > > > > side channel attacking surface: vf-->pf-->vf
> > > > > In this model there's no pf. BAR belongs to vf itself
> > > > > and you submit commands for the VF through its BAR.
> > > > > Just separate from the pci config space.
> > > > If using the bar to process admin commands,
> > > > is this solution too heavy compared to my proposal in this series?
> > > somewhat - because it's more comprehensive - you can actually
> > > migrate a device using it.
> > > this series just begins to define how to poke at some
> > > of the vq state - it's a subset of the necessary functionality.
> > >
> > > And it will give you a bunch of side benefits, such as
> > > support for legacy compat commands that were merged.
> > next version will include in-flight descriptors and dirty page tracking=
.
>
> what we don't need is another version of this megathread.
> which it sounds like you intend to restart?
> nor do I cherish maintaining two independent mechanisms for doing
> the same thing in the spec.

I'm not sure how to define "the same thing" but we had different
transports for accessing basic facilities like virtqueue, device
status, etc. I don't get why live migration is different. Especially
considering migration is actually a combination of several independent
functions.

And we have already had different ways to transport legacy devices as
well. It's really hard to say one mechanism can work for all use
cases.

> all of the above is already in parav's patchset so you guys should find
> a way to work together rather than compete?

There're things that are missed in Parav's series for sure, that is
the migrating for owner and nest.

From my point of view there's no competition. The main issue I see so
far is that you want to couple migration with admin commands but I
don't see much advantages to doing this.

And before the collaboration, I need to first figure out if Parav's
proposal can work. Or what's wrong with this series. If it is just a
missing of any function, it could be added on top for sure, if it
belongs to the basic facility part, it can be reused (that's the
motivation for this series).

Thanks


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

