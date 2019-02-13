Return-Path: virtio-dev-return-5423-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 99262985E0C
	for <virtio-dev@lists.oasis-open.org>; Wed, 13 Feb 2019 04:02:28 +0000 (UTC)
Date: Tue, 12 Feb 2019 23:02:19 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190212221738-mutt-send-email-mst@kernel.org>
References: <CAOGAQepzNSZ5c+tB+e-sYRzQMag2Pr+H0ToJhtd-4mLubY9xeA@mail.gmail.com>
 <20190212112547.GC2715@work-vm>
 <20190212144741.60083682.cohuck@redhat.com>
 <20190212090121-mutt-send-email-mst@kernel.org>
 <CAEkmjvW+bDjKeaoQOVm4CDVBfo-0qQf7uhk=sFMgSzeZTMzLKg@mail.gmail.com>
 <20190212164626.GG2715@work-vm>
 <CAEkmjvUU1VAEV+4Uy+QqYxR_atVVhVRR0XULVDyg+YJXwDYwDQ@mail.gmail.com>
 <CAEkmjvVu0r9cpFPNv8xSityiZ1hZLBPy0uyN1Jp_i1CAnu+zJA@mail.gmail.com>
 <20190212135924-mutt-send-email-mst@kernel.org>
 <CAEkmjvVzwfNW4QL8E52=AEXvN_RoeEoOHCODaefsa4wSLOMmZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAEkmjvVzwfNW4QL8E52=AEXvN_RoeEoOHCODaefsa4wSLOMmZg@mail.gmail.com>
Subject: Re: [virtio-dev] Memory sharing device
To: Frank Yang <lfy@google.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Roman Kiryanov <rkir@google.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org, Greg Hartman <ghartman@google.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Feb 12, 2019 at 06:50:29PM -0800, Frank Yang wrote:
>=20
>=20
> On Tue, Feb 12, 2019 at 11:06 AM Michael S. Tsirkin <mst@redhat.com> wrot=
e:
>=20
>     On Tue, Feb 12, 2019 at 09:26:10AM -0800, Frank Yang wrote:
>     > BTW, the other unique aspect is that the ping messages allow a _hos=
t_
>     pointer
>     > to serve as the lump of shared memory;
>     > then there is no need to track buffers in the guest kernel and the =
device
>     > implementation can perform specialize buffer space management.
>     > Because it is also host pointer shared memory, it is also physically
>     contiguous
>     > and there is no scatterlist needed to process the traffic.
>=20
>     Yes at the moment virtio descriptors all pass addresses guest to host.
>=20
>     Ability to reverse that was part of the vhost-pci proposal a while ag=
o.
>     BTW that also at least originally had ability to tunnel
>     multiple devices over a single connection.
>=20
>=20
>=20
> Can there be a similar proposal for virtio-pci without vhsot?
>=20
>     There was nothing wrong with the proposals I think, they
>     just had to be polished a bit before making it into the spec.
>     And that runneling was dropped but I think it can be brought back
>     if desired, we just didn't see a use for it.
>=20
>=20
> Thinking about it more, I think vhost-pci might be too much for us due to=
 the
> vhost requirement (sockets and IPC while we desire a highly process local
> solution)

I agree because the patches try to document a bunch of stuff.
But I really just mean taking the host/guest interface
part from there.


> But there's nothing preventing us from having the same reversals for virt=
io-pci
> devices without vhost, right?

Right. I think that if you build something such that vhost pci
can be an instance of it on top, then it would have
a lot of value.


> That's kind of what's being proposed with the shared memory stuff at the
> moment, though it is not a device type by itself yet (Arguably, it should=
 be).
>=20
>=20
>     How about that? That sounds close to what you were looking for,
>     does it not? That would be something to look into -
>     if your ideas can be used to implement a virtio device
>     backend by code running within a VM, that would be very interesting.
>=20
>=20
> What about a device type, say, virtio-metapci,

I have to say I really dislike that name. It's basically just saying I'm
not telling you what it is.  Let's try to figure it out.  Looks like
although it's not a vsock device it's also trying to support creating
channels with support for passing two types of messages (data and
control) as well as some shared memory access.  And it also has
enumeration so opened channels can be tied to what? strings?  PCI Device
IDs?

Then the vsock device was designed for this problem space.  It might not
be a good fit for you e.g. because of some vsock baggage it has. But one
of the complex issues it does address is controlling host resource usage
so guest socket can't DOS host or starve other sockets by throwing data
at host. Things might slow down but progress will be made. If you are
building a generic kind of message exchange you could do worse than copy
that protocol part.

I don't think the question of why not vsock generally was addressed all
that well. There's discussion of sockets and poll, but that has nothing
to do with virtio which is a host/guest interface. If you are basically
happy with the host/guest interface but want to bind a different driver
to it, with some minor tweaks, we could create a virtio-wsock which is
just like virtio-vsock but has a different id, and use that as a
starting point.  Go wild build a different driver for it.


> that relies on virtio-pci for
> device enumeration and shared memory handling
> (assuming it's going to be compatible with the host pointer shared memory
> implementation),
> so there's no duplication of the concept of device enumeration nor shared
> memory operations.
> But, it works in terms of the ping / event virtqueues, and relies on the =
host
> hypervisor to dispatch to device implementation callbacks.

All the talk about dispatch and device implementation is just adding to
confusion.  This isn't something that belongs in virtio spec anyway, and
e.g. qemu is unlikely to add an in-process plugin support just for this.


> A potential issue is that such metapci device share the same device id
> namespace as other virtio-pci devices...but maybe that's OK?

That's a vague question.
Same device and vendor id needs to imply same driver works.
I think you use the terminology that doesn't match virtio.
words device and driver have a specific meaning and that
doesnt include things like implementation callbacks.


> If this can build on virtio-pci, I might be able to come up with a spec t=
hat
> assumes virtio-pci as the transport,
> and assumes (via the WIP host memory sharing work) that host memory can b=
e used
> as buffer storage.
> The difference is that it will not contain most of the config virtqueue s=
tuff
> (except maybe for create/destroy instance),
> and it should also work with the existing ecosystem around virtio-pci.
> =A0

I still can't say from above whether it's in scope for virtio or not.
All the talk about blobs and controlling both host and guest sounds
out of scope. But it could be that there are pieces that are
inscope, and you would use them for whatever vendor specific
thing you need.

And I spent a lot of time on this by now.

So could you maybe try to extract specifically the host/guest interface
things that you miss? I got the part where you want to take a buffer
within BAR and pass it to guest.  But beyond that I didn't get a lot. E.g.
who is sending most data? host? guest? both? There are control messages
are these coming from guest?  Do you want to know when guest is done
with the buffer host allocated? Can you take a buffer away from guest?

OTOH all the callback discussion is really irrelevant for the virtio tc.
If things can't be described without this they are out of scope
for virtio.

>=20
>     --
>     MST
>=20

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

