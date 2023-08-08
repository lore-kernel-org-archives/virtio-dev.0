Return-Path: <virtio-dev-return-13486-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C2AFC001B0
	for <virtio-dev@archiver.kernel.org>; Tue,  8 Aug 2023 03:09:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B0F262AD57
	for <virtio-dev@archiver.kernel.org>; Tue,  8 Aug 2023 03:09:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7FB2198646D
	for <virtio-dev@archiver.kernel.org>; Tue,  8 Aug 2023 03:09:19 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 59D4F984990; Tue,  8 Aug 2023 03:09:19 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4507C986466
	for <virtio-dev@lists.oasis-open.org>; Tue,  8 Aug 2023 03:09:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: ZdRjg5gGPxiJoCZSHRzKuA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691464155; x=1692068955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dW6cCshMKDzl4UMTn3gVdnvbklTQzx5lrsmpbPA23+c=;
        b=M37/betbW+KLyXhqaDf3LGtEnN42b+HCne41+aoMWJWfN0ZUtQ0oi8apYq3b9ELB+z
         i6pzeWFv5BqemQ8Th+xRKIAk9Li6LoX3xvmA6Z9QWNKMrcTJb8UgAIPRRiRrN252/NhY
         k+lv4nCQWKyjk+HVWHoJkpjP1JSHhntjxGz/tXUV+e566bkTtwvL9Gv0h+G7rqJAHk0O
         FgFUy++dsJNEc1ZoteFirvSAwuO39A3hDkiVG6wnDVxmCa9N2svXBiWLC0zDtEDeroUb
         0126lnPiQ+JZ3/zL1r7LbsrDnG7QCoz8vmk7Gb8FIjeMfB3FTBACWgRBXfYG7IybUqIQ
         SRUA==
X-Gm-Message-State: AOJu0YxyQWtChtH09eRUt6xvmBqr8J12GZi1H9CW9tGv1OAvpprlj4Le
	m0qBo0k6+ZXhlnsXrODvMVs/SQgl1THeX5ghZLOT0FgkEaXaVUJjCjyMHzJ+k1nvI8A9q3sEiz4
	Isa28kEyGeD898Pu6h3/nSTiubBlbxyjtaW5B2QqRXYhJ
X-Received: by 2002:a2e:9d86:0:b0:2b7:339c:f791 with SMTP id c6-20020a2e9d86000000b002b7339cf791mr8081524ljj.25.1691464154830;
        Mon, 07 Aug 2023 20:09:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQahDiRtb3vidmm33x4hm6fclfn5x76kag4fV6UEqM5YLh5RxelsQYqU3SUzajenVryjqz1Wr6xZNtDadiR4Y=
X-Received: by 2002:a2e:9d86:0:b0:2b7:339c:f791 with SMTP id
 c6-20020a2e9d86000000b002b7339cf791mr8081513ljj.25.1691464154552; Mon, 07 Aug
 2023 20:09:14 -0700 (PDT)
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
 <1691388171.3192031-1-xuanzhuo@linux.alibaba.com> <CACGkMEtKcmvBqSJac4aNQMtvE+fYnOeLxeeXz1vtP5d2PM69bQ@mail.gmail.com>
 <1691462188.324996-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1691462188.324996-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 8 Aug 2023 11:09:03 +0800
Message-ID: <CACGkMEszg7nUNH2bW+EQLVxnPvUzT66D8=V8x7JKw+DL=RzsiQ@mail.gmail.com>
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

On Tue, Aug 8, 2023 at 10:46=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Tue, 8 Aug 2023 10:18:15 +0800, Jason Wang <jasowang@redhat.com> wrote=
:
> > On Mon, Aug 7, 2023 at 2:13=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibab=
a.com> wrote:
> > >
> > > On Fri, 4 Aug 2023 12:49:04 +0000, Parav Pandit <parav@nvidia.com> wr=
ote:
> > > >
> > > >
> > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > Sent: Friday, August 4, 2023 4:03 PM
> > > >
> > > > > > >
> > > > > > > At this point to have port for owner device requires creating=
 a dedicated
> > > > > switching object, to be located sometimes side by side inside the=
 owner,
> > > > > sometimes outside.
> > > > > > > All of these cases to be crafted, please rethink if this is _=
really_ needed as
> > > > > virtio object or not.
> > > > > >
> > > >
> > > > > >
> > > > > > YES.
> > > > > >
> > > > > > We can hear others.
> > > > > >
> > > > > > @Jason @Michael
> > > > > >
> > > > > >
> > > > > > Thanks
> > > > >
> > > > >
> > > > > This is so abstract, hard to have any position as I'm not sure wh=
at we are
> > > > > discussing. If some virtio devices have an integrated switch then=
 ability to
> > > > > control the switch through virtio seems useful.
> > > > >
> > > > True, for us, at this point we do not have plan to expose virtio sw=
itch device because users are not blocked on it.
> > >
> > >
> > > Also for us.
> > >
> > > But we need to limit the ip of every member device.
> >
> > This has been discussed somehow before we need probably more like:
> > spoof check and trust which are already supported by iproute2:
> >
> > https://lists.oasis-open.org/archives/virtio-comment/202101/msg00047.ht=
ml
>
>
> Sorry, I do not think that the above patch is match for us.
>
> In our case, one VM user may use the IP of another VM user to send/receiv=
e
> packets.
>
> So if the above idea is useful to our case, cloud you explain more?
>
> >
> > > That is useful for cloud.
> > > Because the user of each VM is untrustworthy. We must limit the ip tr=
affic of
> > > every member device.
> > >
> > > We have two choose:
> > >
> > > 1. add feature to device by cvq of pf(or admin queue?), that can limi=
t the ip(receive and transmit).
> > > 2. add feature to switch, it can limit the ip for every port. If we c=
hoose this
> > >    way, I will try introduce the simple switch concept to the virtio-=
net.
> > >    Because except this we have not more requirement for the switch. S=
o we donot
> > >    plan to introduce a complex switch.
> >
> > This requirement (IP limitation) sounds more like a filter feature
> > which seems not directly related to switch.
>
> Yes, this can be a filter feature. But we also need to limit the tx traff=
ic.
>
> For receive traffic, many net cards support that the flowdirector(or RFF)=
 can
> steer the traffic to the VF.
>
> https://dpdk.readthedocs.io/en/v17.11/howto/flow_bifurcation.html
>
> But for us, that is just work for the receive traffic,
> we also need to limit the tx traffic.
>
> So we want to introduce as the feature of the device.

Yes, but even for TX, would it be better to filter the IP as early as
possible in the TX path other than depend on the switch to do that?

Thanks

>
> Thanks
>
>
>
> >
> > Thanks
> >
> > >
> > > Thanks.
> > >
> > >
> > > >
> > > > > Re:queues - it's not by chance that we have multiple admin queues=
.
> > > > > So driver can dedicate one queue to filtering commands if that's =
felt to be
> > > > > important.
> > > > >
> > > > Admin queue currently do not send non admin command of the device.
> > > > Would you propose admin queue for something else also for rtc or co=
nsole or cryto device and indicate its role so device can understand what i=
s coming to it.
> > >
> >
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

