Return-Path: <mst@redhat.com>
Date: Fri, 13 Jan 2023 07:00:51 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] [PATCH v2 1/1] virtio-ism: introduce new device
 virtio-ism
Message-ID: <20230113064742-mutt-send-email-mst@kernel.org>
References: <20230111161128.48e6d7e0.pasic@linux.ibm.com>
 <CACGkMEuT5L2DH1ga+HOJb0DHdF04VmvC3viEoRPhraLxc7RCjg@mail.gmail.com>
 <20230112014722-mutt-send-email-mst@kernel.org>
 <87zgaocffm.fsf@redhat.com>
 <1673524110.7417235-2-xuanzhuo@linux.alibaba.com>
 <87r0vzddul.fsf@redhat.com>
 <20230112164132.09d292e5.pasic@linux.ibm.com>
 <1673575104.6515808-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEsm+9FJGm5m_nLkj9z0_vwXei+x9u+E1UxjoH0Ua=+oqw@mail.gmail.com>
 <1673591054.0941749-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1673591054.0941749-1-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, virtio-dev@lists.oasis-open.org, hans@linux.alibaba.com, herongguang@linux.alibaba.com, zmlcc@linux.alibaba.com, dust.li@linux.alibaba.com, tonylu@linux.alibaba.com, zhenzao@linux.alibaba.com, helinguo@linux.alibaba.com, gerry@linux.alibaba.com, Jan Kiszka <jan.kiszka@siemens.com>, wintera@linux.ibm.com, kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com, hca@linux.ibm.com, twinkler@linux.ibm.com, raspl@linux.ibm.com, Cornelia Huck <cohuck@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jan 13, 2023 at 02:24:14PM +0800, Xuan Zhuo wrote:
> On Fri, 13 Jan 2023 10:29:49 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > On Fri, Jan 13, 2023 at 9:59 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > >
> > > On Thu, 12 Jan 2023 16:41:32 +0100, Halil Pasic <pasic@linux.ibm.com> wrote:
> > > > On Thu, 12 Jan 2023 15:30:58 +0100
> > > > Cornelia Huck <cohuck@redhat.com> wrote:
> > > >
> > > > > >>
> > > > > >> I like that: we don't want to talk about hosts/VMMs/etc. as we
> > > > > >> fundamentally deal with devices and drivers, but sharing between guests
> > > > > >> is of course the obvious use case.
> > > > > >>
> > > > > >> I'm just wondering how best to express the uniqueness scope, is it per
> > > > > >> (ISM) device?
> > > > > >
> > > > > > No, each vm has at least one separate device. The devices in a host form
> > > > > > an uniqueness scope.
> > > > >
> > > > > Should we call it a 'group', then? A host would be an example of such a
> > > > > group.
> > > >
> > > > How about 'communication domain'? Devices within a single communication
> > > > domain may be able to speak to each other via SMC and may not have the
> > > > same device_id. Two devices from different communication domains can't
> > > > communicate via ISM, but may have the same device_id.
> > >
> > > I agree.
> > >
> > > >
> > > > I don't like group because it is very generic, and may sound like
> > > > the grouping can be done arbitrarily. E.g. with a shared memory based
> > > > implementation akin to the PoC putting devices on different hosts into
> > > > the same 'group' should be illegal.
> >
> > Any reason why this is illegal?
> 
> The ism device must on the same host.

Fundamentally the limitation is that
the devices must have access to the same memory.
This is what we care about not who runs the VMs there's
no need to mention that at all.


But I feel a bigger question is whether we can avoid making ISM
a migration blocker? E.g.:
- a lone vm is migrated, it's disconnected from memory on source
- a lone vm is migrated, it's connected to memory on destination
- a group of vms is migrated, the memory is migrated with them
  and they remain connected to it

I feel the switch to virtio is a good time to address these
issues, if we don't address this straight away then users
using virtio-ism will have no way to know whether their
VM is migrateable or not.


> >
> > > >
> > > > On the other hand there is also the following question. If we move away
> > > > form the one ID per host model ("The device MUST ensure that the gid on
> > > > the same entity i same and different from the gid on other entity.") then
> > > > we could also allow having more than one communication domains on a
> > > > single host (to limit what entities can use ISM to communicate).
> >
> > Yes, but I think it might not be necessary to say how gid is actually
> > implemented, I can think most of the time it should be provisioned by
> > the the management stack which is probably out of the scope of the
> > spec.
> 
> Imagine that the VMs from two different cloud manufacturers may have the same
> GID (Host-Id). They believed that they can communicate based on ISM Device. This
> is wrong.
> 
> Thanks.

Let's leave all this talk about entities out it just serves to
confuse. Same as with previous discussion, explain the
limitation: two devices can access the same shared memory if and
only if they have the same gid. And give an example of a host
running multiple VMs.


> 
> >
> > Thanks
> >
> > >
> > > Yes, this is a good idea.
> > >
> > > Thanks.
> > >
> > > >
> > > > Regards,
> > > > Halil
> > > >
> > >
> >

