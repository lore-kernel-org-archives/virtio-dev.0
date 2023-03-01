Return-Path: <virtio-dev-return-11336-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E62C64EC4
	for <virtio-dev@archiver.kernel.org>; Wed,  1 Mar 2023 02:36:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C65F62ACA4
	for <virtio-dev@archiver.kernel.org>; Wed,  1 Mar 2023 02:36:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A9065986667
	for <virtio-dev@archiver.kernel.org>; Wed,  1 Mar 2023 02:36:56 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 921A3981240; Wed,  1 Mar 2023 02:36:56 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7B262986645
	for <virtio-dev@lists.oasis-open.org>; Wed,  1 Mar 2023 02:36:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: luSNqPitNr2ZAD8aQ144Ng-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BqFrmS1ft/KfTRTpe5lKmodb2Q5qcIXVuTBPpiNnc40=;
        b=4K/r4EH547/s8NLJflhELCX9LbWHQLQUXrMKXHErM1RvikC0iWWJr4nsySWkXRea0w
         XpE53pADZoCHL8F7KENcgjiB03KA7fYh9lnFxTxR3MQ3S3uhBrTkGq5gZ5cOeP6K0O6a
         MEc1wi6J8sx6+6yuzGa+t6wHSTlWQuuGQTr8kMKUr0b5ig6WuyLyIzwLELieEl5APhYS
         Eyx3Btt+i+ZPZQcuWxRSlro3gKkMqIXjRcgRblccJWrddkiLKrFYBJplCAmiPOHKCV4D
         6kNrE+/EywWHxzIqUe0FW2E4HVy8QtCiRkZyMXRHmKRM68+zoZkZo2ElQuPaON69oGF1
         xA6A==
X-Gm-Message-State: AO0yUKX/+mjL84Ul3a8sh80dyENp++5HewPZ+6AyFDk3Xfq276NndK27
	zCOICtYwnn6q+dfT1HvBeYhlVWQjeqE9kNSmg5Clu+ObcCeLIZWnnvx5X+X9RBeEgJ3BesNYflj
	WYu+NImyYwGbG42E7puxS7Xx7y4eUqtz0jQSimn8SOSDu
X-Received: by 2002:a05:6870:1a86:b0:16e:3585:dbf2 with SMTP id ef6-20020a0568701a8600b0016e3585dbf2mr1114053oab.9.1677638212310;
        Tue, 28 Feb 2023 18:36:52 -0800 (PST)
X-Google-Smtp-Source: AK7set8tEmYYzn+AX7HbSPt1OqCBvL2wPa9N+ptWLDhN9jtNvA2hBrRwTK/NDM2li1RflHsbG/X3MvEcCZM2sISPhWQ=
X-Received: by 2002:a05:6870:1a86:b0:16e:3585:dbf2 with SMTP id
 ef6-20020a0568701a8600b0016e3585dbf2mr1114043oab.9.1677638212030; Tue, 28 Feb
 2023 18:36:52 -0800 (PST)
MIME-Version: 1.0
References: <0f53212f-a89b-ad3c-73e3-a7a7b5533058@linux.alibaba.com>
 <1047920c-5dd5-8f31-0c4c-a108f36155f8@redhat.com> <20230223075934-mutt-send-email-mst@kernel.org>
 <CACGkMEvc2Px_Zz11R5QYwMXYm_j5rsYV2LrZt5yf8tZQxuT_Bg@mail.gmail.com>
 <20230224030509-mutt-send-email-mst@kernel.org> <CACGkMEuOu=6qKQO2TJ0B6ZLRH_-rGtZMYVtw7gn+BFbnJgWkrw@mail.gmail.com>
 <20230227023657-mutt-send-email-mst@kernel.org> <CACGkMEtOFC-xygzgECi82j4Q6PacpjVnyPMs1Q6c9PN0RfX5bw@mail.gmail.com>
 <20230227124800-mutt-send-email-mst@kernel.org> <CACGkMEvUaQuzMx4iwkaYg9t9Bz2Ev0eHAwgrWbNEwtQHZOkkvQ@mail.gmail.com>
 <20230228060352-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230228060352-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 1 Mar 2023 10:36:41 +0800
Message-ID: <CACGkMEvAGABhk6JX7+F-sDtRM7t1oONEz9wrgKM7iShmyYV34A@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, virtio-comment@lists.oasis-open.org, 
	virtio-dev@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Cornelia Huck <cohuck@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [PATCH v9] virtio-net: support inner header hash
Message-ID: <20230301023641.eWqKBahVTskEJ_Q0yXO1_hmvqykm7lat1jOAucuX6Dc@z>

On Tue, Feb 28, 2023 at 7:05=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Feb 28, 2023 at 11:04:26AM +0800, Jason Wang wrote:
> > On Tue, Feb 28, 2023 at 1:49=E2=80=AFAM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Mon, Feb 27, 2023 at 04:35:09PM +0800, Jason Wang wrote:
> > > > On Mon, Feb 27, 2023 at 3:39=E2=80=AFPM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> > > > >
> > > > > On Mon, Feb 27, 2023 at 12:07:17PM +0800, Jason Wang wrote:
> > > > > > Btw, this kind of 1:1 hash features seems not scalable and flex=
ible.
> > > > > > It requires an endless extension on bits/fields. Modern NICs al=
low the
> > > > > > user to customize the hash calculation, for virtio-net we can a=
llow to
> > > > > > use eBPF program to classify the packets. It seems to be more f=
lexible
> > > > > > and scalable and there's almost no maintain burden in the spec =
(only
> > > > > > bytecode is required, no need any fancy features/interactions l=
ike
> > > > > > maps), easy to be migrated etc.
> > > > > >
> > > > > > Prototype is also easy, tun/tap had an eBPF classifier for year=
s.
> > > > > >
> > > > > > Thanks
> > > > >
> > > > > Yea BPF offload would be great to have. We have been discussing i=
t for
> > > > > years though - security issues keep blocking it. *Maybe* it's fin=
ally
> > > > > going to be there but I'm not going to block this work waiting fo=
r BPF
> > > > > offload.  And easily migrated is what BPF is not.
> > > >
> > > > Just to make sure we're at the same page. I meant to find a way to
> > > > allow the driver/user to fully customize what it wants to
> > > > hash/classify. Similar technologies which is based on private solut=
ion
> > > > has been used by some vendors, which allow user to customize the
> > > > classifier[1]
> > > >
> > > > ePBF looks like a good open-source solution candidate for this (the=
re
> > > > could be others). But there could be many kinds of eBPF programs th=
at
> > > > could be offloaded. One famous one is XDP which requires many featu=
res
> > > > other than the bytecode/VM like map access, tailcall. Starting from
> > > > such a complicated type is hard. Instead, we can start from a simpl=
e
> > > > type, that is the eBPF classifier. All it needs is to pass the
> > > > bytecode to the device, the device can choose to run it or compile =
it
> > > > to what it can understand for classifying. We don't need maps, tail
> > > > calls and other features.
> > >
> > > Until people start asking exactly for maps because they want
> > > state for their classifier?
> >
> > Yes, but let's compare the eBPF without maps with the static feature
> > proposed here. It is much more scalable and flexible.
>
> I looked for some examples of RSS using BPF and only found this:
> https://github.com/Netronome/bpf-samples/blob/master/programmable_rss/rss=
_user.c
> seems to use maps.

Yes and this is also the way we emulate RSS with TUN/TAP via steering
eBPF support for TUN/TAP. The reason is that it needs to emulate not
only the hash but also the indirection. If we only replace the hash
function with the eBPF program but reuse the RSS indirection table, we
don't need maps.

>
>
> > > And it makes sense - if you want
> > > e.g. load balancing you need stats which needs maps.
> >
> > Yes, but we know it's possible to have that (through the XDP offload).
>
> Not without a lot more work to make xdp offload happen.
>

Yes, that's why a simple eBPF RSS hashing program looks much more easier.

Thanks

> > This is impossible with the approach proposed here.
> >
> > >
> > > > We don't need to worry about the security
> > > > because of its simplicity: the eBPF program is only in charge of do=
ing
> > > > classification, no other interactions with the driver and packet
> > > > modification is prohibited. The feature is limited only to the
> > > > VM/bytecode abstraction itself.
> > > >
> > > > What's more, it's a good first step to achieve full eBPF offloading=
 in
> > > > the future.
> > > >
> > > > Thanks
> > > >
> > > > [1] https://www.intel.com/content/www/us/en/architecture-and-techno=
logy/ethernet/dynamic-device-personalization-brief.html
> > >
> > > Dave seems to have nacked this approach, no?
> >
> > I may miss something but looking at kernel commit, there are few
> > patches to support that:
> >
> > E.g
> >
> > commit c7648810961682b9388be2dd041df06915647445
> > Author: Tony Nguyen <anthony.l.nguyen@intel.com>
> > Date:   Mon Sep 9 06:47:44 2019 -0700
> >
> >     ice: Implement Dynamic Device Personalization (DDP) download
> >
> > And it has been used by DPDK drivers.
> >
> > Thanks
> >
> > >
> > > > >
> > > > > --
> > > > > MST
> > > > >
> > >
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

