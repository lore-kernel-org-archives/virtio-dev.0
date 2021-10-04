Return-Path: <virtio-dev-return-8772-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A40989862D4
	for <virtio-dev@lists.oasis-open.org>; Mon,  4 Oct 2021 15:05:27 +0000 (UTC)
Date: Mon, 4 Oct 2021 11:05:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20211004110152-mutt-send-email-mst@kernel.org>
References: <20210930012049.3780865-1-pasic@linux.ibm.com>
 <20210930070444-mutt-send-email-mst@kernel.org>
 <87fstm47no.fsf@redhat.com>
 <20211002141351-mutt-send-email-mst@kernel.org>
 <20211003070030.658fc94e.pasic@linux.ibm.com>
 <20211003021027-mutt-send-email-mst@kernel.org>
 <20211003032253-mutt-send-email-mst@kernel.org>
 <87ee912e45.fsf@redhat.com>
 <20211004083455-mutt-send-email-mst@kernel.org>
 <878rz83lx0.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <878rz83lx0.fsf@redhat.com>
Subject: [virtio-dev] Re: [RFC PATCH 1/1] virtio: write back features before verify
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Jason Wang <jasowang@redhat.com>, Xie Yongji <xieyongji@bytedance.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, markver@us.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Oct 04, 2021 at 04:27:23PM +0200, Cornelia Huck wrote:
> On Mon, Oct 04 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Mon, Oct 04, 2021 at 02:01:14PM +0200, Cornelia Huck wrote:
> >> On Sun, Oct 03 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> > @@ -160,6 +163,33 @@ \subsection{Legacy Interface: A Note on Feature
> >> >  Specification text within these sections generally does not apply
> >> >  to non-transitional devices.
> >> >  
> >> > +\begin{note}
> >> > +The device offers different features when used through
> >> > +the legacy interface and when operated in accordance with this
> >> > +specification.
> >> > +\end{note}
> >> > +
> >> > +Transitional drivers MUST use Devices only through the legacy interface
> >> 
> >> s/Devices only through the legacy interface/devices through the legacy
> >> interface only/
> >> 
> >> ?
> >
> > Both versions are actually confused, since how do you
> > find out that device does not offer VIRTIO_F_VERSION_1?
> >
> > I think what this should really say is
> >
> > Transitional drivers MUST NOT accept VIRTIO_F_VERSION_1 through
> > the legacy interface.
> 
> Ok, that makes sense.
> 
> Would it make sense that transitional drivers MUST accept VERSION_1
> through the non-legacy interface? Or is that redundant?

We already have:

A driver MUST accept VIRTIO_F_VERSION_1 if it is offered.


> >
> >
> > Does linux actually satisfy this? Will it accept VIRTIO_F_VERSION_1
> > through the legacy interface if offered?
> 
> I think that the Linux drivers will not operate on feature bit 32+ if
> they are in legacy mode?


Well ... with PCI there's no *way* for host to set bit 32 through
legacy. But it might be possible with MMIO/CCW. Can you tell me
what happens then?


> >> 
> >> Generally, looks good to me.
> >
> > Do we want to also add explanation that features can be
> > changed until FEATURES_OK?
> 
> I always considered that to be implict, as feature negotiation is not
> over until we have FEATURES_OK. Not sure whether we need an extra note.

Well Halil here says once you set a feature bit you can't clear it.
So maybe not ...

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

