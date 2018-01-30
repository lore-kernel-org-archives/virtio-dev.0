Return-Path: virtio-return-2852-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Tue, 30 Jan 2018 18:38:09 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180130183604-mutt-send-email-mst@kernel.org>
References: <1515577653-9336-1-git-send-email-mst@redhat.com>
 <1516665617-30748-4-git-send-email-mst@redhat.com>
 <20180130111659.007465ec.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180130111659.007465ec.cohuck@redhat.com>
Subject: Re: [virtio] [PATCH v7 04/11] content: replace mentions of len with
 used length
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jan 30, 2018 at 11:16:59AM +0100, Cornelia Huck wrote:
> On Tue, 23 Jan 2018 02:01:03 +0200
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > Document buffer used len and use that terminology everywhere in the
> > generic section.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  content.tex | 39 ++++++++++++++++++++-------------------
> >  1 file changed, 20 insertions(+), 19 deletions(-)
> > 
> > diff --git a/content.tex b/content.tex
> > index 3b4579e..4350ecf 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -242,7 +242,8 @@ a used buffer to the queue - i.e. lets the driver
> >  know by marking the buffer as used. Device can then trigger
> >  a device event - i.e. send an interrupt to the driver.
> >  
> > -For queue operation detail, see \ref{sec:Basic Facilities of a Virtio Device / Split Virtqueues}~\nameref{sec:Basic Facilities of a Virtio Device / Split Virtqueues}.
> 
> Why are you dropping this?

That chapter follows immediately so the link is not helpful and it just looks weird:
see split virtqueues - split virtqueues. I'll add text to description
to mention this.

> > +Device reports the number of bytes it has written to memory for
> > +each buffer it uses. This is referred to as ``used length''.
> >  
> >  \input{split-ring.tex}
> >  
> 
> Otherwise, using the term "used length" looks good.

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

