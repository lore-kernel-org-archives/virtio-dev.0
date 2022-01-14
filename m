Return-Path: <mst@redhat.com>
Date: Fri, 14 Jan 2022 13:18:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] spec inconsistency: Device Configuration Interrupt
 bit in ISR status
Message-ID: <20220114131802-mutt-send-email-mst@kernel.org>
References: <20220114082838-mutt-send-email-mst@kernel.org>
 <87y23iuvih.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87y23iuvih.fsf@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Zhu, Lingshan" <lingshan.zhu@intel.com>, jasowang@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jan 14, 2022 at 05:33:58PM +0100, Cornelia Huck wrote:
> On Fri, Jan 14 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > It is unfortunate that it does not copy this requirement in more places,
> > and that the non-conformance text is incomplete and does not
> > mention the MSI-X usage at all.
> >
> > I propose to extend 4.1.4.5 ISR status capability and 
> > 4.1.5.4 Notification of Device Configuration Changes
> > to mention the MSI use.
> 
> I agree that it would make sense to be more explicit, especially if
> people have already fallen into this trap.
> 
> My main question is: do we still have time to do this for 1.2? By the
> proposed timeline, we need to have a vote open by Jan 17th (next
> Monday), which is cutting it awfully close.
> 
> [We seem to have quite some last minute stuff, sigh.]

I think the main thing is not to have regressions. This is hardly
one, it's been like this for years. So if no vote by Monday
we just defer.

-- 
MST

