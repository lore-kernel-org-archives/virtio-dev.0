Return-Path: <virtio-dev-return-13482-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD45C00528
	for <virtio-dev@archiver.kernel.org>; Tue,  8 Aug 2023 02:18:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 371852A8EA
	for <virtio-dev@archiver.kernel.org>; Tue,  8 Aug 2023 02:18:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0CFE8986492
	for <virtio-dev@archiver.kernel.org>; Tue,  8 Aug 2023 02:18:32 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E5541984990; Tue,  8 Aug 2023 02:18:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CB849986461
	for <virtio-dev@lists.oasis-open.org>; Tue,  8 Aug 2023 02:18:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 43WOQ8cgNVeDveFu6Qcm1g-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691461107; x=1692065907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/y+guKV+5DohHQ5xg0dN2GAORv02a6Al0dPMDskzpoA=;
        b=JC7TFGatIv2OOeyEL764m1adUSKlfJLO0sMk/GP4dtBgYSKdItuJdpft3P6TNuJeuQ
         ISOt5fF8qSW47cFeXLxfTDY43Roie/X+/o7oJtIA0mX5vxZ+K/PQAu/AaEV6OlW9bvhz
         9yik8MuyK7mBJ8L880hAH1a7XYnkVJNx2T1VLYafzIAlUnNxLv0SNT9bQR9/8e20qG5D
         +HZQn+Zri25IleymdR3h0hnQlYyTq8uCMP2duVxV5/NIdlwF3qAtbHgw6rj/1fDu5uJz
         FbtUjTH3Zc4f1ACoIDHIv5R1rxWX0ZykenWMT4WUPQ+A/KJzAuRrB5RKfTiPiP/eHiy1
         3EHA==
X-Gm-Message-State: AOJu0YwF8arF/cqzZian8igreELCAsuedXf09qNkjvcZ++8NosHv1W2V
	GJs+htlVzoD+dJtb5Dx0WXVj8prLzBHy35pvdMB5g1fbhv4MVzhh99AzEBkdVC8zqFYWlThBhYY
	MvN4i24cN0mQlQV+WvWEtd7IckMsvqPvU2JLg4I0lj8I2
X-Received: by 2002:a2e:8ec8:0:b0:2b9:601d:2ce with SMTP id e8-20020a2e8ec8000000b002b9601d02cemr7431462ljl.35.1691461107644;
        Mon, 07 Aug 2023 19:18:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvxqspn/p7ue8Xh4IZJ/dIN4xJdC0kbHTsWC4OiALUHhxx5IloSK/6EzCRhv6AoK7n+d2QgceG8MzNskZ5LfU=
X-Received: by 2002:a2e:8ec8:0:b0:2b9:601d:2ce with SMTP id
 e8-20020a2e8ec8000000b002b9601d02cemr7431449ljl.35.1691461107270; Mon, 07 Aug
 2023 19:18:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230803083150.46745-1-xuanzhuo@linux.alibaba.com>
 <20230803054333-mutt-send-email-mst@kernel.org> <1691059929.235804-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481B5B3C5366CCACB221083DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691060652.3764465-2-xuanzhuo@linux.alibaba.com> <PH0PR12MB548191AE225B08BACFC0C350DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691061508.9066079-5-xuanzhuo@linux.alibaba.com> <PH0PR12MB5481CB7BE555F4672394A6ECDC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691062204.2378864-7-xuanzhuo@linux.alibaba.com> <PH0PR12MB5481E104793F9E68E1DC95CADC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691062877.0013635-8-xuanzhuo@linux.alibaba.com> <PH0PR12MB5481C3CE21016385BF7D6FF0DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691129914.3255427-1-xuanzhuo@linux.alibaba.com> <PH0PR12MB5481F521F146049E5E483B7DDC09A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691132049.7182267-2-xuanzhuo@linux.alibaba.com> <PH0PR12MB5481BE16AC810CD3A6D64832DC09A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691135097.4908528-3-xuanzhuo@linux.alibaba.com> <20230804053958-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548152A5677F0508A62587AFDC09A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691388171.3192031-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1691388171.3192031-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 8 Aug 2023 10:18:15 +0800
Message-ID: <CACGkMEtKcmvBqSJac4aNQMtvE+fYnOeLxeeXz1vtP5d2PM69bQ@mail.gmail.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Parav Pandit <parav@nvidia.com>, 
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, 
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: RE: RE: RE: RE: [virtio-comment] RE: RE: RE: RE: [RFC]
 virtio-net: support access and control the member devices

On Mon, Aug 7, 2023 at 2:13=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> On Fri, 4 Aug 2023 12:49:04 +0000, Parav Pandit <parav@nvidia.com> wrote:
> >
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Friday, August 4, 2023 4:03 PM
> >
> > > > >
> > > > > At this point to have port for owner device requires creating a d=
edicated
> > > switching object, to be located sometimes side by side inside the own=
er,
> > > sometimes outside.
> > > > > All of these cases to be crafted, please rethink if this is _real=
ly_ needed as
> > > virtio object or not.
> > > >
> >
> > > >
> > > > YES.
> > > >
> > > > We can hear others.
> > > >
> > > > @Jason @Michael
> > > >
> > > >
> > > > Thanks
> > >
> > >
> > > This is so abstract, hard to have any position as I'm not sure what w=
e are
> > > discussing. If some virtio devices have an integrated switch then abi=
lity to
> > > control the switch through virtio seems useful.
> > >
> > True, for us, at this point we do not have plan to expose virtio switch=
 device because users are not blocked on it.
>
>
> Also for us.
>
> But we need to limit the ip of every member device.

This has been discussed somehow before we need probably more like:
spoof check and trust which are already supported by iproute2:

https://lists.oasis-open.org/archives/virtio-comment/202101/msg00047.html

> That is useful for cloud.
> Because the user of each VM is untrustworthy. We must limit the ip traffi=
c of
> every member device.
>
> We have two choose:
>
> 1. add feature to device by cvq of pf(or admin queue?), that can limit th=
e ip(receive and transmit).
> 2. add feature to switch, it can limit the ip for every port. If we choos=
e this
>    way, I will try introduce the simple switch concept to the virtio-net.
>    Because except this we have not more requirement for the switch. So we=
 donot
>    plan to introduce a complex switch.

This requirement (IP limitation) sounds more like a filter feature
which seems not directly related to switch.

Thanks

>
> Thanks.
>
>
> >
> > > Re:queues - it's not by chance that we have multiple admin queues.
> > > So driver can dedicate one queue to filtering commands if that's felt=
 to be
> > > important.
> > >
> > Admin queue currently do not send non admin command of the device.
> > Would you propose admin queue for something else also for rtc or consol=
e or cryto device and indicate its role so device can understand what is co=
ming to it.
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

