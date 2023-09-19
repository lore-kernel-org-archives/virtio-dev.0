Return-Path: <virtio-dev-return-13809-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 017DDCD3438
	for <virtio-dev@archiver.kernel.org>; Tue, 19 Sep 2023 04:26:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5BE3942C5D
	for <virtio-dev@archiver.kernel.org>; Tue, 19 Sep 2023 04:26:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 538AF986566
	for <virtio-dev@archiver.kernel.org>; Tue, 19 Sep 2023 04:26:16 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4637D98637D; Tue, 19 Sep 2023 04:26:16 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2FBB29864C2
	for <virtio-dev@lists.oasis-open.org>; Tue, 19 Sep 2023 04:26:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 6mTcGsHcOwKcMjT96X67Aw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695097570; x=1695702370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LcnZIS54VlJ4orNY/u5Nex3m1sMdJ9X0RD2sigI9TmU=;
        b=X5P8a/pxPsm97n0tGKhGChXetfdWDMnJKL5WnztD0LLqHQ2pOaSQzaxFqBLxhOtoNU
         ZF1T8CS9S6h2s7LvmTG8KaO7BP21RHJUk4Ns7e/+O5ctQ3dlX/PLrJpdl0AfG0YvDWEw
         dqZrCfxIpHyMvgUVC3KWgZ9UISDkfuCZDy89GYtUCXw6jHMut32ZNuXqN0PrC+kMvUZH
         FUIRJjxQXrv7ofdCz6iQ3m/T0SvV6O1687BiSVxv/18mBj78+VIWVl94LuCeBeXOXUQ1
         yBTAa4PDzbl2LxzkgNtCe/LLdA5ZLQfJlG4+StCFLLznWB+sZceqYlohoepeqsSX8pxJ
         11sw==
X-Gm-Message-State: AOJu0YyPsBVF17cfvhygzdyoQq/75SWvbS3VnO3UKYunkqOQkNea/2ig
	hCr6dIUB6YmtkSjG6rv1udRvoD5B1+ZYICflfR0Xt0zS8bPI/7IOaBmhkkD4W/gqg7VZizetlNs
	GU+zuv8sczLyCYK2BHnU9wNSH7cLOIYaVoEoGu2w+d/HV
X-Received: by 2002:ac2:592f:0:b0:500:b64e:4f40 with SMTP id v15-20020ac2592f000000b00500b64e4f40mr9432772lfi.41.1695097570076;
        Mon, 18 Sep 2023 21:26:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE95hzY431SakZ2fkmgxjD4z+9592+4dbvAPSt4XUIKm8iOewRjlBiLueV1Bw/PpRFx0MeCb1/RLsM/xi8z5gw=
X-Received: by 2002:ac2:592f:0:b0:500:b64e:4f40 with SMTP id
 v15-20020ac2592f000000b00500b64e4f40mr9432760lfi.41.1695097569758; Mon, 18
 Sep 2023 21:26:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <20230906081637.32185-6-lingshan.zhu@intel.com> <20230906043016-mutt-send-email-mst@kernel.org>
 <CACGkMEu4R_nUFmpoNesmjJ-PtoE5brpWh8NLruWhEWycm2K4yg@mail.gmail.com>
 <PH0PR12MB5481A50B1B13CE1756B98D0DDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtMmwWGJDYe5BLvLCcetThv-yfPR2QbphNuuh+bp-+ikg@mail.gmail.com>
 <PH0PR12MB5481ED8DC23DC6D42665FB8EDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEt9ATuU_OwtE_9rF1XHKCd9GavWCHx6_dFXCZibMKzJjA@mail.gmail.com>
 <PH0PR12MB5481D538B4F3F76B393C5757DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEs+5AjGzeDbWZYSkOMw65d6g6oDfgbOapa1G3EbtLUy7A@mail.gmail.com>
 <PH0PR12MB54811C3EC1618E413695D8FDDCF0A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtMz3KShVbxpf_DLSx8qde=8JAdPPYOnA_udEfQ8UU+uQ@mail.gmail.com> <PH0PR12MB5481EB8FFDE1915271D3CA4ADCF4A@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481EB8FFDE1915271D3CA4ADCF4A@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 19 Sep 2023 12:25:58 +0800
Message-ID: <CACGkMEvmPh3-kWY0FmnnR+7RS3pFWtU=e_3BexkJRk3Spc8Zjg@mail.gmail.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Zhu Lingshan <lingshan.zhu@intel.com>, 
	"eperezma@redhat.com" <eperezma@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>, 
	"stefanha@redhat.com" <stefanha@redhat.com>, 
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, 
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [virtio-comment] [PATCH 5/5] virtio-pci: implement VIRTIO_F_QUEUE_STATE

On Sun, Sep 17, 2023 at 1:29=E2=80=AFPM Parav Pandit <parav@nvidia.com> wro=
te:
>
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Thursday, September 14, 2023 8:42 AM
> >
> > On Wed, Sep 13, 2023 at 12:46=E2=80=AFPM Parav Pandit <parav@nvidia.com=
> wrote:
> > >
> > > > From: Jason Wang <jasowang@redhat.com>
> > > > Sent: Wednesday, September 13, 2023 10:14 AM
> > >
> > > > It's not about how many states in a single state machine, it's abou=
t
> > > > how many state machines that exist for device status. Having more
> > > > than one creates big obstacles and complexity in the device. You
> > > > need to define the interaction of each state otherwise you leave un=
defined
> > behaviours.
> > > The device mode has zero relation to the device status.
> >
> > You will soon get this issue when you want to do nesting.
> >
> I don=E2=80=99t think so. One needs to intercept it when one wants to do =
trap+emulation which seems to fullfil the nesting use case.

Well, how can you trap it? You have admin vq in L0, it means the
suspending is never exposed to L1 unless you assign the owner to L1.
Is this what you want?

>
> > > It does not mess with it at all.
> > > In fact the new bits in device status is making it more complex for t=
he device
> > to handle.
> >
> > Are you challenging the design of the device status? It's definitely to=
o late to do
> > this.
> >
> No. I am saying the extending device_status with yet another state is equ=
ally complex and its core of the device.

You never explain why.

>
> > This proposal increases just one bit and that worries you? Or you think=
 one
> > more state is much more complicated than a new state machine with two
> > states?
>
> It is mode and not state. And two modes are needed for supporting P2P dev=
ice.

You keep saying you are migrating the core virtio devices but then you
are saying it is required for PCI. And you never explain why it can't
be done by reusing the device status bit.

> When one wants to do with mediation, there also two states are needed.
>
> The key is modes are not interacting

You need to explain why they are not interacting. It touches the
virtio facility which (partially) overlaps the function of the device
status for sure. You invent a new state machine, and leave the vendors
to guess how or why they are not interacting with the existing one.
There are just too many corner cases that need to be figured out.

For example:

How do you define stop? Is it a virtio level stop, transport level or
a mixing of them both? Is the device allowed to stop in the middle or
reset, feature negotiation or even transport specific things like FLR?
If yes, how about other operations and who defines and maintains those
transitional states? If not, why and how long would a stop wait for an
operation? Can a stop fail? What happens if the driver wants to reset
but the device is stopped by the admin commands? Who suppresses who
and why?

This demonstrates the complexity of your proposal and I don't see any
of the above were clearly stated in your series. Reusing the existing
device status machine, everything would be simplified.

> with the device_status because device_status is just another register of =
the virtio.

Let's don't do layer violation, device status is the basic facility of
the virtio device which is not coupled with any transport so it is not
necessarily implemented via registers.

Thanks


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

