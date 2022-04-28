Return-Path: <jasowang@redhat.com>
MIME-Version: 1.0
References: <CACGkMEsDEJS0awDfFzR7a1aOr3+TQ6iDse5R=LRAYGxgNs4bpQ@mail.gmail.com>
 <PH0PR12MB5481FA61532231E61C96F692DCFA9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220427111713-mutt-send-email-mst@kernel.org> <PH0PR12MB5481CBB7E506E3DCEB11A7BFDCFA9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220427114055-mutt-send-email-mst@kernel.org> <PH0PR12MB5481AC52975356341A964314DCFA9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB548121654DFF8442593FF26DDCFA9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <9a932876-1a5e-8166-57fd-f41bf4f153f5@redhat.com> <PH0PR12MB5481E73A95F36A3CE63EEA8FDCFD9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsWMxXEyNKue7f8cu4m5CkUmZNexbjzK6ha5eDFCmhR1w@mail.gmail.com> <20220428022714-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220428022714-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 28 Apr 2022 14:56:15 +0800
Message-ID: <CACGkMEtgpoY54hX-KF0-2wMtbGaTtdjd0h25CrV3g5ZRgvHeDA@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH v2] virtio: Improve queue_reset polarity to
 match to default reset state
Content-Type: text/plain; charset="UTF-8"
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Cornelia Huck <cohuck@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Apr 28, 2022 at 2:30 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Apr 28, 2022 at 02:13:42PM +0800, Jason Wang wrote:
> > > queue_reset removal has far more editorial changes.
> > > Before I update the v4 to incorporate, please discuss/sync with Michael or others what is best course of action from spec timing perspective.
> > >  I am ok either way to draft either by
> > > (a) removal of queue_reset register and allow queue_disable by replacing RING_RESET definition in v4
> > > Or
> > > (b) fixing the polarity as done in v3
> >
> > Ok.
> >
> > Thanks
>
> So Jason, what is your take?

I don't object Parav's idea. Just want to seek if there's something better.

> I am inclined to keep queue reset register
> and just flip the polarity. Less spec work and semantics are more or
> less clear. Not helpful for migration - limited to queue
> resize, watchdog and similar uses - but if we are expanding
> scope to migration that makes it imo not 1.2 material.

That's fine consider queue_reset has more users than just migration.

Thanks

>
> --
> MST
>

