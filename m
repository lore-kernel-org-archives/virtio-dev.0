Return-Path: <virtio-dev-return-13517-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54835C001DB
	for <virtio-dev@archiver.kernel.org>; Mon, 14 Aug 2023 12:39:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id AD0B166DCA
	for <virtio-dev@archiver.kernel.org>; Mon, 14 Aug 2023 12:39:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A4CCF9863A4
	for <virtio-dev@archiver.kernel.org>; Mon, 14 Aug 2023 12:39:22 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 99DB0983F78; Mon, 14 Aug 2023 12:39:22 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 83E6798633D;
	Mon, 14 Aug 2023 12:39:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VpnE.kH_1692016752;
Message-ID: <1692014460.4123554-3-xuanzhuo@linux.alibaba.com>
Date: Mon, 14 Aug 2023 20:01:00 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Satananda Burla <sburla@marvell.com>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
References: <1691481880.8297818-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEtfHvg5YAi1Cz0PZV2w_CqU70hQA3XU3gwYx0Gg2Ke+RQ@mail.gmail.com>
In-Reply-To: <CACGkMEtfHvg5YAi1Cz0PZV2w_CqU70hQA3XU3gwYx0Gg2Ke+RQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [virtio-comment] virtio-net ip restriction.

On Thu, 10 Aug 2023 15:04:17 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, Aug 8, 2023 at 4:09=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
> >
> > ## Background
> >
> > For cloud, the ip restriction is important. Because the user of the vm =
is
> > untrustworthy. One user may use the ip of another to config the netdevi=
ce to
> > receive and send packets. So we need to restrict the ip traffic of the =
device(or port).
> >
> > ## Implement
> > Now we have these choice:
> >
> > 1. introduce the switch(as the part of pf or as a separate device under=
 all PF
> >    and VFs ), the switch support rx/tx filter
> > 2. the virtio-net device support the ip restriction
>
> I think they are not contradictory, we can have both. I'd suggest
> starting from 2 as it's simple without new dependencies.

I agree.


>
> One question though, besides ip restriction, how did you implement the
> trust and spoof checking?

Do you we mean how do we implement ip restriction without the virtio spec?

On the cloud, ip restricttion is the default function out of the spec.

Thanks.


>
> Thanks
>
> >
> >
> > Parav wrote:
> > > I understood that you for some reason do not need restrictions for th=
e PF.
> > > I do not know why you don't need it. :)
> > > Most cloud setups that I came across so far, needs it, but ok...
> >
> > PF is used by the administrator, so the ip restriction for the PF is
> > not important. But we can have this feature.
> >
> > > The design for the switch object needs to cover the PF as well, even =
though it may not be done initially.
> > > (hint: an abstraction of switch port to be done, instead of doing thi=
ngs directly on the group member id).
> > >
> > > We are seeing use cases reducing of having switch located on the PF f=
or its VFs.
> >
> > So for you, we should introduce a switching PF?
> >
> > > So please reconsider.
> > > I remember you mentioned in past in other thread, that mac etc is con=
trolled from the infrastructure side.
> >
> > YES.
> >
> > > So, I repeatedly ask if you _really_ need to have the switch object a=
s part of the owner PF or not.
> >
> > For me, that are all ok.
> > Could you explain the difference between these?
> > So I would to know which one is better and which one is simper?
> >
> > > Which sort of contradicts with locating the administrative switch on =
the owner PF.
> >
> > Why?
> >
> > For us, all is on the DPU.
> >
> > >
> > > If it does, flow filters vq that is being worked with Heng, Satananda=
, David
> > > and others seems right direction to implement simple->complex switch =
object
> > > progressively.
> >
> > Great!!
> >
> >
> > Thanks.
> >
> > This publicly archived list offers a means to provide input to the
> > OASIS Virtual I/O Device (VIRTIO) TC.
> >
> > In order to verify user consent to the Feedback License terms and
> > to minimize spam in the list archive, subscription is required
> > before posting.
> >
> > Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> > Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> > List help: virtio-comment-help@lists.oasis-open.org
> > List archive: https://lists.oasis-open.org/archives/virtio-comment/
> > Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.p=
df
> > List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing=
-lists
> > Committee: https://www.oasis-open.org/committees/virtio/
> > Join OASIS: https://www.oasis-open.org/join/
> >
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

