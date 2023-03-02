Return-Path: <virtio-dev-return-11352-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A846C7EE2F
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 07:57:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2AE2F2A8DE
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 07:57:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C33F09866AA
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 07:57:26 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id AD57B983EB8; Thu,  2 Mar 2023 07:57:26 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 822979866D6
	for <virtio-dev@lists.oasis-open.org>; Thu,  2 Mar 2023 07:57:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 0g0UUaubOsORAVZuQxvzxw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=knx2SULpWD5kYAxgHazulQnhhZQBtq/9Op7tVwH6TdQ=;
        b=IolnqTc94uTa2YOEVLjdB8hPiOiv6SO/Fwdlg4fl7GxiIsGSAKbHGsbvSn2jcIt8q4
         baAIk6YYcSsq/G+mFnzMKv4dwb2Gl79PN4a/PB4moBquKqRjLW9KyqyEEVZ2UlD978/H
         95Meq/9FPegCZoajIq9uuGVjIBeK4b0tsvZ/USts/y+JM89aGbg2LYDAEJ4i9uB3NXI3
         uPUSX3M8r8rS7lRi8g292f6vfF2uMe/FP7DtmWoRevmigzMwd6L8ZT0gOFTrxFycJ+BQ
         54d7kgq4zaMIEQijA/tBYkr91eiQgXrCB7msAiFFoy9tO7UR1DOtGlP0e8E7zxH8Fwnp
         1X6g==
X-Gm-Message-State: AO0yUKVFC8S+zjPmjLCwGYOBCulXsPSCpER6carZzaoTONb+SHOCIkyc
	9frhPTT8RjbZlkYPjTwaFwiTYDCu4pJOpJMwmgvds7TI53iDOedlyl+eFVF96StwYuaYgUd3Vh6
	fbQYkJoWTdcIkSSzw9l7W+0UNVWs6TJYKAZV1ZZGfdUje
X-Received: by 2002:a05:6870:b7b2:b0:172:3aea:ecaa with SMTP id ed50-20020a056870b7b200b001723aeaecaamr2818219oab.9.1677743842242;
        Wed, 01 Mar 2023 23:57:22 -0800 (PST)
X-Google-Smtp-Source: AK7set/Z6kUpk8zgJOT1YsF+T6okUXldSW+CVmA9ybN7jPDIw1LfNkHtS7mrELxG/+lNPNsfTDB4i4ITGZynlMPRgzU=
X-Received: by 2002:a05:6870:b7b2:b0:172:3aea:ecaa with SMTP id
 ed50-20020a056870b7b200b001723aeaecaamr2818208oab.9.1677743841938; Wed, 01
 Mar 2023 23:57:21 -0800 (PST)
MIME-Version: 1.0
References: <20230224030509-mutt-send-email-mst@kernel.org>
 <CACGkMEuOu=6qKQO2TJ0B6ZLRH_-rGtZMYVtw7gn+BFbnJgWkrw@mail.gmail.com>
 <20230227023657-mutt-send-email-mst@kernel.org> <CACGkMEtOFC-xygzgECi82j4Q6PacpjVnyPMs1Q6c9PN0RfX5bw@mail.gmail.com>
 <20230227124800-mutt-send-email-mst@kernel.org> <CACGkMEvUaQuzMx4iwkaYg9t9Bz2Ev0eHAwgrWbNEwtQHZOkkvQ@mail.gmail.com>
 <20230228060352-mutt-send-email-mst@kernel.org> <CACGkMEvAGABhk6JX7+F-sDtRM7t1oONEz9wrgKM7iShmyYV34A@mail.gmail.com>
 <20230301053407-mutt-send-email-mst@kernel.org> <CACGkMEsSCGo01WsLvDojB5s8yjqL1mV0s328DnssosnNO=4M4w@mail.gmail.com>
 <20230302024129-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230302024129-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 2 Mar 2023 15:57:10 +0800
Message-ID: <CACGkMEtLRhJ=4xiwRO96hb6HOdO8n1on62Gyu72aV6+MWag2jQ@mail.gmail.com>
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

On Thu, Mar 2, 2023 at 3:42=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Thu, Mar 02, 2023 at 10:57:12AM +0800, Jason Wang wrote:
> > On Wed, Mar 1, 2023 at 6:36=E2=80=AFPM Michael S. Tsirkin <mst@redhat.c=
om> wrote:
> > >
> > > On Wed, Mar 01, 2023 at 10:36:41AM +0800, Jason Wang wrote:
> > > > On Tue, Feb 28, 2023 at 7:05=E2=80=AFPM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> > > > >
> > > > > On Tue, Feb 28, 2023 at 11:04:26AM +0800, Jason Wang wrote:
> > > > > > On Tue, Feb 28, 2023 at 1:49=E2=80=AFAM Michael S. Tsirkin <mst=
@redhat.com> wrote:
> > > > > > >
> > > > > > > On Mon, Feb 27, 2023 at 04:35:09PM +0800, Jason Wang wrote:
> > > > > > > > On Mon, Feb 27, 2023 at 3:39=E2=80=AFPM Michael S. Tsirkin =
<mst@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Mon, Feb 27, 2023 at 12:07:17PM +0800, Jason Wang wrot=
e:
> > > > > > > > > > Btw, this kind of 1:1 hash features seems not scalable =
and flexible.
> > > > > > > > > > It requires an endless extension on bits/fields. Modern=
 NICs allow the
> > > > > > > > > > user to customize the hash calculation, for virtio-net =
we can allow to
> > > > > > > > > > use eBPF program to classify the packets. It seems to b=
e more flexible
> > > > > > > > > > and scalable and there's almost no maintain burden in t=
he spec (only
> > > > > > > > > > bytecode is required, no need any fancy features/intera=
ctions like
> > > > > > > > > > maps), easy to be migrated etc.
> > > > > > > > > >
> > > > > > > > > > Prototype is also easy, tun/tap had an eBPF classifier =
for years.
> > > > > > > > > >
> > > > > > > > > > Thanks
> > > > > > > > >
> > > > > > > > > Yea BPF offload would be great to have. We have been disc=
ussing it for
> > > > > > > > > years though - security issues keep blocking it. *Maybe* =
it's finally
> > > > > > > > > going to be there but I'm not going to block this work wa=
iting for BPF
> > > > > > > > > offload.  And easily migrated is what BPF is not.
> > > > > > > >
> > > > > > > > Just to make sure we're at the same page. I meant to find a=
 way to
> > > > > > > > allow the driver/user to fully customize what it wants to
> > > > > > > > hash/classify. Similar technologies which is based on priva=
te solution
> > > > > > > > has been used by some vendors, which allow user to customiz=
e the
> > > > > > > > classifier[1]
> > > > > > > >
> > > > > > > > ePBF looks like a good open-source solution candidate for t=
his (there
> > > > > > > > could be others). But there could be many kinds of eBPF pro=
grams that
> > > > > > > > could be offloaded. One famous one is XDP which requires ma=
ny features
> > > > > > > > other than the bytecode/VM like map access, tailcall. Start=
ing from
> > > > > > > > such a complicated type is hard. Instead, we can start from=
 a simple
> > > > > > > > type, that is the eBPF classifier. All it needs is to pass =
the
> > > > > > > > bytecode to the device, the device can choose to run it or =
compile it
> > > > > > > > to what it can understand for classifying. We don't need ma=
ps, tail
> > > > > > > > calls and other features.
> > > > > > >
> > > > > > > Until people start asking exactly for maps because they want
> > > > > > > state for their classifier?
> > > > > >
> > > > > > Yes, but let's compare the eBPF without maps with the static fe=
ature
> > > > > > proposed here. It is much more scalable and flexible.
> > > > >
> > > > > I looked for some examples of RSS using BPF and only found this:
> > > > > https://github.com/Netronome/bpf-samples/blob/master/programmable=
_rss/rss_user.c
> > > > > seems to use maps.
> > > >
> > > > Yes and this is also the way we emulate RSS with TUN/TAP via steeri=
ng
> > > > eBPF support for TUN/TAP. The reason is that it needs to emulate no=
t
> > > > only the hash but also the indirection. If we only replace the hash
> > > > function with the eBPF program but reuse the RSS indirection table,=
 we
> > > > don't need maps.
> > >
> > > How? Add a special helper?
> >
> > We can let the eBPF program return the hash:
> >
> > [eBPF hasing] -> hash value -> [indirection table lookup]
> >
> > Note that if we don't consider future full eBPF offloading, we can
> > start with classical BPF.
> >
> > Thanks
>
> So again this is a custom thing not a standard use of BPF.
> Normally value returned is pass/drop.

AFAIK there's no standard here. The semantic of the return value is
determined by the context of the (e)BPF program.

Kernel had already used the eBPF program for hashing, classifying
various types of eBPF program other than XDP/socket filter
(pass/drop).

Thanks

>
> > >
> > > > >
> > > > >
> > > > > > > And it makes sense - if you want
> > > > > > > e.g. load balancing you need stats which needs maps.
> > > > > >
> > > > > > Yes, but we know it's possible to have that (through the XDP of=
fload).
> > > > >
> > > > > Not without a lot more work to make xdp offload happen.
> > > > >
> > > >
> > > > Yes, that's why a simple eBPF RSS hashing program looks much more e=
asier.
> > > >
> > > > Thanks
> > >
> > > Notice that at this point this is no longer a generic BPF - you
> > > are using a special helper. For tunnels I would imagine two tables
> > > could easily turn out to be useful. Then what? Another table?
> > > If yes then I can't say I like where this is going ...
> > >
> > > > > > This is impossible with the approach proposed here.
> > > > > >
> > > > > > >
> > > > > > > > We don't need to worry about the security
> > > > > > > > because of its simplicity: the eBPF program is only in char=
ge of doing
> > > > > > > > classification, no other interactions with the driver and p=
acket
> > > > > > > > modification is prohibited. The feature is limited only to =
the
> > > > > > > > VM/bytecode abstraction itself.
> > > > > > > >
> > > > > > > > What's more, it's a good first step to achieve full eBPF of=
floading in
> > > > > > > > the future.
> > > > > > > >
> > > > > > > > Thanks
> > > > > > > >
> > > > > > > > [1] https://www.intel.com/content/www/us/en/architecture-an=
d-technology/ethernet/dynamic-device-personalization-brief.html
> > > > > > >
> > > > > > > Dave seems to have nacked this approach, no?
> > > > > >
> > > > > > I may miss something but looking at kernel commit, there are fe=
w
> > > > > > patches to support that:
> > > > > >
> > > > > > E.g
> > > > > >
> > > > > > commit c7648810961682b9388be2dd041df06915647445
> > > > > > Author: Tony Nguyen <anthony.l.nguyen@intel.com>
> > > > > > Date:   Mon Sep 9 06:47:44 2019 -0700
> > > > > >
> > > > > >     ice: Implement Dynamic Device Personalization (DDP) downloa=
d
> > > > > >
> > > > > > And it has been used by DPDK drivers.
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > > > >
> > > > > > > > >
> > > > > > > > > --
> > > > > > > > > MST
> > > > > > > > >
> > > > > > >
> > > > >
> > >
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

