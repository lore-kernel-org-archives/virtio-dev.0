Return-Path: virtio-dev-return-5424-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 32498985E0D
	for <virtio-dev@lists.oasis-open.org>; Wed, 13 Feb 2019 04:19:11 +0000 (UTC)
Date: Tue, 12 Feb 2019 23:19:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190212231458-mutt-send-email-mst@kernel.org>
References: <20190212112547.GC2715@work-vm>
 <20190212144741.60083682.cohuck@redhat.com>
 <20190212090121-mutt-send-email-mst@kernel.org>
 <CAEkmjvW+bDjKeaoQOVm4CDVBfo-0qQf7uhk=sFMgSzeZTMzLKg@mail.gmail.com>
 <20190212164626.GG2715@work-vm>
 <CAEkmjvUU1VAEV+4Uy+QqYxR_atVVhVRR0XULVDyg+YJXwDYwDQ@mail.gmail.com>
 <CAEkmjvVu0r9cpFPNv8xSityiZ1hZLBPy0uyN1Jp_i1CAnu+zJA@mail.gmail.com>
 <20190212135924-mutt-send-email-mst@kernel.org>
 <CAEkmjvVzwfNW4QL8E52=AEXvN_RoeEoOHCODaefsa4wSLOMmZg@mail.gmail.com>
 <20190212221738-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212221738-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-dev] Memory sharing device
To: Frank Yang <lfy@google.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Roman Kiryanov <rkir@google.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org, Greg Hartman <ghartman@google.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Feb 12, 2019 at 11:02:19PM -0500, Michael S. Tsirkin wrote:
> On Tue, Feb 12, 2019 at 06:50:29PM -0800, Frank Yang wrote:
> > 
> > 
> > On Tue, Feb 12, 2019 at 11:06 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > 
> >     On Tue, Feb 12, 2019 at 09:26:10AM -0800, Frank Yang wrote:
> >     > BTW, the other unique aspect is that the ping messages allow a _host_
> >     pointer
> >     > to serve as the lump of shared memory;
> >     > then there is no need to track buffers in the guest kernel and the device
> >     > implementation can perform specialize buffer space management.
> >     > Because it is also host pointer shared memory, it is also physically
> >     contiguous
> >     > and there is no scatterlist needed to process the traffic.
> > 
> >     Yes at the moment virtio descriptors all pass addresses guest to host.
> > 
> >     Ability to reverse that was part of the vhost-pci proposal a while ago.
> >     BTW that also at least originally had ability to tunnel
> >     multiple devices over a single connection.
> > 
> > 
> > 
> > Can there be a similar proposal for virtio-pci without vhsot?
> > 
> >     There was nothing wrong with the proposals I think, they
> >     just had to be polished a bit before making it into the spec.
> >     And that runneling was dropped but I think it can be brought back
> >     if desired, we just didn't see a use for it.
> > 
> > 
> > Thinking about it more, I think vhost-pci might be too much for us due to the
> > vhost requirement (sockets and IPC while we desire a highly process local
> > solution)
> 
> I agree because the patches try to document a bunch of stuff.
> But I really just mean taking the host/guest interface
> part from there.

Tomorrow I'll try to write up a little bit more about the vhost pci
ideas.  The patches on list go deep into envisioned implementation
detail within qemu instead of the actual host/guest interface.
You should then be able to figure out they are relevant for you.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

