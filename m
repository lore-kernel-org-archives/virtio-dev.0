Return-Path: virtio-return-2768-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Wed, 12 Jul 2017 11:44:10 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170712114355.43e80981@dhcp-192-215.str.redhat.com>
In-Reply-To: <20170712093520.GB6923@stefanha-x1.localdomain>
References: <20170711115129.18828-1-cohuck@redhat.com>
	<20170712093520.GB6923@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [virtio] Re: [virtio-dev] [PATCH] virtio-net: fix virtqueue numbering error
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 12 Jul 2017 10:35:20 +0100
Stefan Hajnoczi <stefanha@redhat.com> wrote:

> On Tue, Jul 11, 2017 at 01:51:29PM +0200, Cornelia Huck wrote:
> > receiveq(n) is at position 2(n-1)+1. Same error for transmitq(n)
> > and controlq.
> > 
> > VIRTIO-161
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >  content.tex | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/content.tex b/content.tex
> > index d8bde3a..2319729 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -3064,9 +3064,9 @@ features.
> >  \item[0] receiveq1
> >  \item[1] transmitq1
> >  \item[\ldots]
> > -\item[2N] receiveqN
> > -\item[2N+1] transmitqN
> > -\item[2N+2] controlq
> > +\item[2(N-1)] receiveqN
> > +\item[2(N-1)+1] transmitqN
> > +\item[2(N-1)+2] controlq  
> 
> There is still only one controlq overall.  Therefore I suggest:
> 
>   \item[2N] controlq
> 
> This seems clearer to me since "\item[2(N-1)+2] controlq" makes it look
> like the controlq is repeated along with rx and tx queues.

Indeed, that is easier to parse. Will update.

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

