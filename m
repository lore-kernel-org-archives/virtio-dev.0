Return-Path: <virtio-dev-return-12221-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A7FC77B6E
	for <virtio-dev@archiver.kernel.org>; Fri, 14 Apr 2023 03:09:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0444C2AEF2
	for <virtio-dev@archiver.kernel.org>; Fri, 14 Apr 2023 03:09:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EFC23986613
	for <virtio-dev@archiver.kernel.org>; Fri, 14 Apr 2023 03:09:49 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E2209983C2D; Fri, 14 Apr 2023 03:09:49 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D1CB6986600
	for <virtio-dev@lists.oasis-open.org>; Fri, 14 Apr 2023 03:09:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: qin8tKPkOEOxvybNu0ne0Q-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681441787; x=1684033787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wpL4Qa4AOKZpHPC6oJ0Kov5AMMa7Gm86QMKtghTfIPk=;
        b=UpJuuhHOGMVyxduZUtSPFnNaV877hcafvcRlrjqJ85sQftxdE+ePJzK2Rz7Q5TwVao
         NvWv7UgJOeB/fchBl5kZUYZg4HWqzhk9T4y5l/kJzp/isAy6SNZ1z6Wf2pIiKFw7hAe5
         nqV2B/Z+8q+wMLd2R4RnxLgN81kQ2Nj4fN0HJf6mZZY8XEs+EbxB9+PkbOpVyrQlE7Dt
         s33k9psXeIT9eT6v3XogP0gi4OkIL4QOXPnWMSq8iAd53KZZmmjMf4Tv1ujcSWKvCgzP
         FohW5qsWuQXtm28xaBzFyaIveNPlN4phy1prU1ValP13iBVMLRdXwdY9Sb+PEwNB44jj
         8U8A==
X-Gm-Message-State: AAQBX9d9YaR4RyBE24I6iF2htt5R2T0kcqLT77XIGjgPHdn7X8ovvnmg
	Wcy4hza9xhAJ993NGvgMNLWxi71vJIJeJ5zDCTJySfnUVAGLiaAGjuZDYgiYyb3QuxrmWR6pQG5
	wSpdYiQblt2eLbs4p/CqZnPRCHSZ75tcW0a70v8EojLug
X-Received: by 2002:a05:6870:c34e:b0:187:89c5:1efa with SMTP id e14-20020a056870c34e00b0018789c51efamr2224177oak.9.1681441787068;
        Thu, 13 Apr 2023 20:09:47 -0700 (PDT)
X-Google-Smtp-Source: AKy350bk+ViZwcvps3JyjyJplX6qkxV0oOhwb+CyApabNcNVJDR23UkU8zgFAFMMDpPGwrWArV2pkAOMM10/SwZ80Fo=
X-Received: by 2002:a05:6870:c34e:b0:187:89c5:1efa with SMTP id
 e14-20020a056870c34e00b0018789c51efamr2224165oak.9.1681441786703; Thu, 13 Apr
 2023 20:09:46 -0700 (PDT)
MIME-Version: 1.0
References: <PH0PR12MB548118F57BB4B4A4F8DC9D7ADC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvYsz1fSPG+fKpRaZ05Ut7ffKwvMPvR8xbRBsXA_6vGQw@mail.gmail.com>
 <PH0PR12MB548137D7A25C99EAA42B4D12DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEshW82qztmGw8YJWJ8=QCoRd6cPxQ+ySazxsO_o+U6c4Q@mail.gmail.com>
 <PH0PR12MB548147CF939CB9C2A0586310DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEu2B_GogDR9HUwB7mT8fkGh+Q_buPLz4nhwhK7h9k6BQQ@mail.gmail.com>
 <PH0PR12MB5481F0CF5A555A6BB2CE856CDC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEuNOYOxvcSzrs0UFEyk+xOkGUpOfhK8rOy_Mebz5b5wdg@mail.gmail.com>
 <a74d3107-d38c-df15-e2ff-f848635f24bd@nvidia.com> <CACGkMEt+bGN7UYEopXPj0+deAnYm1VUNp05VvGHcJnkd8LzbGg@mail.gmail.com>
 <20230413130326-mutt-send-email-mst@kernel.org> <PH0PR12MB54819A5D8FCEC6375D80897DDC989@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB54819A5D8FCEC6375D80897DDC989@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 14 Apr 2023 11:09:35 +0800
Message-ID: <CACGkMEvSSXyXQnRs=OiaSJnSEYHP83chL6-B5ZPCGx6TeW9W5Q@mail.gmail.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, 
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>, 
	Satananda Burla <sburla@marvell.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, 
	Yan Vugenfirer <yan@daynix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI
 MMR dev config registers

On Fri, Apr 14, 2023 at 3:39=E2=80=AFAM Parav Pandit <parav@nvidia.com> wro=
te:
>
>
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Thursday, April 13, 2023 1:20 PM
> >
> > On Thu, Apr 13, 2023 at 01:14:15PM +0800, Jason Wang wrote:
> > > > >>>> The proposed solution in this series enables it and avoid per
> > > > >>>> field sw
> > > > >>> interpretation and mediation in parsing values etc.
> >
> > ... except for reset, notifications, and maybe more down the road.
> >
> Your AQ proposal addresses reset too.
> Nothing extra for the notifications, as comes for free from the device si=
de.
> >
> > > > >>> I don't think it's possible. See the discussion about
> > > > >>> ORDER_PLATFORM and ACCESS_PLATFORM in previous threads.
> > > > >>>
> > > > >> I have read the previous thread.
> > > > >> Hypervisor will be limiting to those platforms where ORDER_PLATF=
ORM
> > is not needed.
> > > > >
> > > > > So you introduce a bunch of new facilities that only work on some
> > > > > specific archs. This breaks the architecture independence of
> > > > > virtio since 1.0.
> > > > The defined spec for PCI device does not work today for transitiona=
l
> > > > device for virtualization. Only works in limited PF case.
> > > > Hence this update.
> > >
> > > I fully understand the motivation. I just want to say
> > >
> > > 1) compare to the MMIO ar BAR0, this proposal doesn't provide much
> > > advantages
> > > 2) mediate on top of modern devices allows us to not worry about the
> > > device design which is hard for legacy
> >
> > I begin to think so, too. When I proposed this it looked like just a si=
ngle
> > capability will be enough, without a lot of mess.  But it seems that ad=
dressing
> > this fully is getting more and more complex.
> > The one thing we can't do in software is different header size for virt=
io net. For
> > starters, let's add a capability to address that?
>
> Hdr bit doesn't solve it because hypervisor is not involved in any trappi=
ng of feature bits, cvq or other vqs.
> It is unified code for 1.x and transitional in hypervisor.
>
> We have two options to satisfy the requirements.
> (partly taken/repeated from Jason's yday email).
>
> 1. AQ (solves reset) + notification for building non transitional device =
that support perform well and it is both backward and forward compat
> Pros:
> a. efficient device reset.
> b. efficient notifications from OS to device
> c. device vendor doesn't need to build transitional configuration space.
> d. works without any mediation in hv for 1.x and non 1.x for all non-lega=
cy interfaces (vqs, config space, cvq, and future features).

Without mediation, how could you forward guest config access to admin
virtqueue? Or you mean:

1) hypervisor medate for legacy
2) otherwise the modern BARs are assigned to the guest

For 2) as we discussed, we can't have such an assumption as

1) spec doesn't enforce the size of a specific structure
2) bing vendor locked thus a blocker for live migration as it mandate
the layout for the guest, mediation layer is a must in this case to
maintain cross vendor compatibility

Hypervisor needs to start from a mediation method and do BAR
assignment only when possible.

> e. can work with non-Linux guest VMs too
>
> Cons:
> a. More AQ commands work in sw

Note that this needs to be done on top of the transport virtqueue. And
we need to carefully design the command sets since they could be
mutually exclusive.

Thanks


> b. Does not work for bare metal PFs
>
> 2. Allowing MMIO BAR0 on transitional device as SHOULD requirement with l=
arger BAR size.
> Pros:
> a. Can work with Linux bare-metal and Linux guest VMs as one of the wider=
 uses case
> b. in-efficient device handling for notifications
> c. Works without mediation like 1.d.
> d. Also works without HV mediation.
>
> Cons:
> a. device reset implementation is very for the hw.
> b. requires transitional device to be built.
> c. Notification performance may suffer.
>
> For Marvell and us #1 works well.
> I am evaluating #2 and get back.
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

