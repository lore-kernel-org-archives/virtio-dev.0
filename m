Return-Path: <mst@redhat.com>
Date: Sun, 12 Feb 2023 04:38:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] Re: [PATCH v3] virtio-net: Mention
 VIRTIO_NET_F_HASH_REPORT dependency on VIRTIO_NET_F_CTRL_VQ
Message-ID: <20230212043611-mutt-send-email-mst@kernel.org>
References: <20230206080210.37758-1-alvaro.karsz@solid-run.com>
 <CAJs=3_C5AqOtaKjk_OWrG+U8SUFLSMez=-6M4JQsh3EEazj-KQ@mail.gmail.com>
 <PH0PR12MB54815E20847C0A5EAF4EEC35DCDE9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CAJs=3_B=veAoNPoLKkqtHcApajVn=82UzVfw63gr7YY+0J3m-w@mail.gmail.com>
 <PH0PR12MB5481B1B2F5648D78C618A92BDCDF9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481B1B2F5648D78C618A92BDCDF9@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Alvaro Karsz <alvaro.karsz@solid-run.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Sat, Feb 11, 2023 at 02:03:01PM +0000, Parav Pandit wrote:
> 
> 
> > From: Alvaro Karsz <alvaro.karsz@solid-run.com>
> > Sent: Saturday, February 11, 2023 4:13 AM
> 
> 
> > > Why cannot device say as MUST requirement?
> > >
> > > Let say there is a device out that exposes a F_HASH_REPORT without
> > F_CTRL_VQ.
> > > So driver tried to send a command and failed to issue cmd.
> > > End result, hash config was not successful.
> > > Did driver gain anything from seeing supplied hash in the config space?
> > > No. it just confused driver that device offered feature bit, could see the
> > supposed hash, but still couldn't configure it.
> > >
> > > So, I think the right fix is that device MUST NOT set F_HASH_REPORT without
> > F_CTRL_VQ.
> > >
> > > And driver should .. is fine, because existing driver that followed 1.2 will
> > negotiate, and device will also accept it if it offered without F_CTRL_VQ.
> > >
> > > Any new device that follows 1.3 will not offer F_HAS_REPORT without C_VQ,
> > hence it cannot be negotiated by driver without C_VQ.
> > >
> > > The gain is : device doesn't need to continue offering F_HASH_REPORT
> > without C_VQ. And I doubt if any device would have done it, as it was obvious.
> > > Just the spec was missed out.
> > >
> > > Is MUST/SHOULD big deal here for device? At least not to me, from practical
> > standpoint to me.
> > > Making must just makes the spec consistent with rest without breaking
> > backward compat.
> > 
> > The first version of this patch [1] actually used a bit requirement (which is
> > equivalent to a "MUST" if I understand correctly).
> > Then Michael pointed out that we can't do it since a version was published
> > without this requirement.
> > 
> > It's clear that the control VQ is required to use this feature.
> > In the linux kernel implementation probe will fail if a device offers
> > F_HASH_REPORT without F_CTRL_VQ.
> > 
> This is even better.
> > Ideally we'll add a "MUST", but since we can't, 
> Lets hear Michael's view, why MUST cannot be done.
> Based on our discussion here, I think MUST is possible and cleaner without breaking any existing sw or device.

1.2 is out without this requirement. Making this a MUST at this
point would declare such previously conformant devices non-conformant.
So I'm afraid our hands are tied.

It might be a good idea to start building out a charter documenting
all kind of compat hacks like this such that new devices are
not tempted to do the wrong thing. I am not sure how this
will look exactly though.


> > our options are to have a
> > "SHOULD", or not mention the dependency at all.
> > 
> > [1] https://lists.oasis-open.org/archives/virtio-comment/202302/msg00026.html

