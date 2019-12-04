Return-Path: virtio-dev-return-6456-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AEC0698603B
	for <virtio-dev@lists.oasis-open.org>; Wed,  4 Dec 2019 07:30:57 +0000 (UTC)
Date: Wed, 4 Dec 2019 08:30:51 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20191204073051.5ksfncdq7sifz552@sirius.home.kraxel.org>
References: <20191128131941.25069-1-kraxel@redhat.com>
 <3815f3b3-135a-97ae-8f4a-0eee8cca81bb@opensynergy.com>
 <20191129053658.bwessuw3lrvpjqzk@sirius.home.kraxel.org>
 <CAEkmjvW2LbWSuSixU_YWziFjfMw0pLW-EzCAoGvJ8Er34VkZ1Q@mail.gmail.com>
 <20191203093322.gu2zmmgzuqekho4n@sirius.home.kraxel.org>
 <CAEkmjvWVC_pyBKyco_hKsj7gBW1LW1amBWORAQBkGaUVzCCSdw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAEkmjvWVC_pyBKyco_hKsj7gBW1LW1amBWORAQBkGaUVzCCSdw@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH] virtio-gpu: add shared resource feature
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Frank Yang <lfy@google.com>
Cc: Matti Moell <Matti.Moell@opensynergy.com>, virtio-dev@lists.oasis-open.org, Gurchetan Singh <gurchetansingh@chromium.org>
List-ID: <virtio-dev.lists.oasis-open.org>

  Hi,

> > > Do we already have a mechanism
> > > to import memory to virtio-gpu via importing a bo handle from somewhe=
re
> > > else?
> >
> > Inside the guest?  Import is not working yet, that needs another update
> > (blob resources) due to current virtio-gpu resources requiring a format
> > at creation time and dmabufs not having one.
> >
> >
> Gotcha, I was just poking around related code and it looked like I could
> use a resource w/ R8 format and width =3D bytes.

Yep, that trick might work for some use cases.  But mapping such an
imported dma-buf to a scanout isn't going to work for example ...

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

