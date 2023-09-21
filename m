Return-Path: <virtio-dev-return-13893-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526F0CD4941
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 03:26:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9789445B2B
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 03:26:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7A010986687
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 03:26:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 600BF983D6F; Thu, 21 Sep 2023 03:26:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4CDB298667C
	for <virtio-dev@lists.oasis-open.org>; Thu, 21 Sep 2023 03:26:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: HbkTyBFSNkSGmKSQqrI4Lw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695266786; x=1695871586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BcbNfWYoNH+pfc128cBsuHZXs2V/nak7njgcgpwyoGM=;
        b=OEdaQtKwqnM9FdmSqxb7YB2Ze2ufHYKJ7CdjfP/CQmTslcYfqW6o4nMZR4BhVTB2Fo
         iIuyCcUQzAHFm2eNc5wgH0H4sMAHD22XsoAykQxtpXUEPPNzTi4QBBi1JUuSkNa0I9Xn
         /jWzGroJeqftvSIie93awRF05Zw4fG+DyloNTvOzA6YA7W1DSl/qDehCxRidagOi4X8I
         nrDTIEUS/1xiV+dOpvX7ra8XUHQvGtBD5bS/0Ifn6KQYH3Ok9VIBNra7v7ZTqCDuo6gZ
         Cl1IMIrYXbeY84dRpqqe6t97kzi/JdMXcGywA0ToE4qe7PCQCD2x8DB00Dsof14JgSYI
         GxFQ==
X-Gm-Message-State: AOJu0YxLGLEzrH1MoOJAUAHLvH/51j+oS3Z7HJA3w3hXYA2FqNgiO2PN
	Ubs7hnQfEf5wFgvMjM4m61imgNXCBvvQhK+78mDoNMFaRwU8EEwHShZockG1KyzZzDyt2iUHp0V
	+9ymsC7GgLiAR0drNsMB4yHygTpNkJg2InqDp1V+8qnwE
X-Received: by 2002:ac2:5f9c:0:b0:500:daec:2817 with SMTP id r28-20020ac25f9c000000b00500daec2817mr4068802lfe.54.1695266786525;
        Wed, 20 Sep 2023 20:26:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjlmGpYhhnTlmFkMdh72MAURmDRt/opkeW0ylaHjv6YCmq8ypxwYNioZzjIyPnOQH3JpIoo1HzXc1xppxkqk0=
X-Received: by 2002:ac2:5f9c:0:b0:500:daec:2817 with SMTP id
 r28-20020ac25f9c000000b00500daec2817mr4068791lfe.54.1695266786206; Wed, 20
 Sep 2023 20:26:26 -0700 (PDT)
MIME-Version: 1.0
References: <PH0PR12MB5481AE8C6E5EAFE9A4ADA6F6DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <f1fe513e-d42d-03a6-348c-5e58aac0a759@intel.com> <PH0PR12MB5481323A3B4D67EB66328476DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5f01772f-eb27-bfe0-7f69-b83fbd90dda0@intel.com> <PH0PR12MB5481ABF4B9BC2082BC54AB1DDCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230918144312-mutt-send-email-mst@kernel.org> <bb402c34-ad07-063a-f4f5-d8c6b3a642c7@intel.com>
 <20230920054836-mutt-send-email-mst@kernel.org> <2f67fb85-2238-9c34-a265-b0f97b7ab7e1@intel.com>
 <20230920075243-mutt-send-email-mst@kernel.org> <20230920084058-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230920084058-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 21 Sep 2023 11:26:14 +0800
Message-ID: <CACGkMEueq-0dsv2Qqu7j2R119e-K68J7ocWmcyw+d8e3Q13ckw@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Zhu, Lingshan" <lingshan.zhu@intel.com>, Parav Pandit <parav@nvidia.com>, 
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq state

On Wed, Sep 20, 2023 at 8:41=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Sep 20, 2023 at 08:05:49AM -0400, Michael S. Tsirkin wrote:
> > On Wed, Sep 20, 2023 at 07:22:32PM +0800, Zhu, Lingshan wrote:
> > >
> > >
> > > On 9/20/2023 6:36 PM, Michael S. Tsirkin wrote:
> > > > On Wed, Sep 20, 2023 at 02:06:13PM +0800, Zhu, Lingshan wrote:
> > > > >
> > > > > On 9/19/2023 2:49 AM, Michael S. Tsirkin wrote:
> > > > > > On Mon, Sep 18, 2023 at 06:41:55PM +0000, Parav Pandit wrote:
> > > > > > > > Please refer to the code for setting FEATURES_OK.
> > > > > > > It wont work when one needs to suspend the device.
> > > > > > > There is no point of doing such work over registers as fundam=
ental framework is over the AQ.
> > > > > > Well not really. It's over admin commands. When these were buil=
t the
> > > > > > intent always was that it's possible to use admin commands thro=
ugh
> > > > > > another interface, other than admin queue. Is there a problem
> > > > > > implementing admin commands over a memory BAR? For example, I c=
an see
> > > > > > an "admin command" capability pointing at a BAR where
> > > > > > commands are supplied, and using a new group type referring to
> > > > > > device itself.
> > > > > I am not sure, if a bar cap would be implemented as a proxy for t=
he admin vq
> > > > > based live migration.
> > > > Not a proxy for a vq in that there's no vq then.
> > > I think if the driver sends admin commands through a VF's bar, then
> > > VF forwards the admin commands to the PF, it acts like a proxy,
> > > or an agent. Anyway it takes admin commands.
> >
> > Why send them to the PF? They are controlling the VF anyway.
> >
> > > So the problems we have discussed still exist.
> > > >
> > > > > then the problems of admin vq LM that we have
> > > > > discussed
> > > > > still exist.
> > > > I freely admit the finer points of this extended flamewar have been=
 lost
> > > > on me, and I wager I'm not the only one. I thought you wanted to mi=
grate
> > > > the device just by accessing the device itself (e.g. the VF) withou=
t
> > > > accessing other devices (e.g. the PF), while Parav wants it in a
> > > > separate device so the whole of the device itself can passed throug=
h to
> > > > guest. Isn't this, fundamentally, the issue?
> > > we are implementing basic facilities for live migration.
> > >
> > > We have pointed out lots of issues, there are many discussions with
> > > Jason and Parav about the problems in migration by admin vq, for exam=
ple:
> > > security, QOS and nested.
> >
> > /me shrugs
> > Thanks for the summary I guess. Same applies to almost any proposal.
> > What would help make progress is an explanation why this has grown into
> > a megathread.  Do you understand Parav's thoughts well enough to
> > summarize them?
>
>
> And Parav same goes for you - can you summarize Zhu Lingshan's position?

The root cause for the long debate is that there are a lot of
misunderstandings between each other. This can be seen from Parav's
reply.

My understanding is it might be better that each side do a summary of
the both proposals.

Thanks


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

