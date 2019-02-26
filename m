Return-Path: virtio-dev-return-5533-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 44CB2985DC5
	for <virtio-dev@lists.oasis-open.org>; Tue, 26 Feb 2019 19:51:09 +0000 (UTC)
Date: Tue, 26 Feb 2019 14:51:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190226145002-mutt-send-email-mst@kernel.org>
References: <20190226162553.30231-1-stefanha@redhat.com>
 <20190226180903.497cccaa.cohuck@redhat.com>
 <20190226174416.GA2339@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226174416.GA2339@stefanha-x1.localdomain>
Subject: Re: [virtio-dev] [PATCH] virtio-blk: clarify semantics of
 multi-segment discard/write zeroes commands
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, virtio-dev@lists.oasis-open.org, Jan Kiszka <jan.kiszka@siemens.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Feb 26, 2019 at 05:44:16PM +0000, Stefan Hajnoczi wrote:
> On Tue, Feb 26, 2019 at 06:09:03PM +0100, Cornelia Huck wrote:
> > On Tue, 26 Feb 2019 16:25:53 +0000
> > Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > 
> > > Describe the failure case and maximum number of segments in a
> > > multi-segment discard/write zeroes command.
> > > 
> > > Fixes: https://github.com/oasis-tcs/virtio-spec/issues/34
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > ---
> > > I would like to request a vote on this.
> > 
> > Only one minor nit from me, below.
> > 
> > > 
> > >  content.tex | 23 +++++++++++++++++++++--
> > >  1 file changed, 21 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/content.tex b/content.tex
> > > index c5fdc34..7bfcc78 100644
> > > --- a/content.tex
> > > +++ b/content.tex
> > > @@ -3967,8 +3967,10 @@ read from the block device (in multiples of 512 bytes).  VIRTIO_BLK_T_OUT
> > >  requests write the contents of \field{data} to the block device (in multiples
> > >  of 512 bytes).
> > >  
> > > -The \field{data} used for discard or write zeroes command is described
> > > -by one or more virtio_blk_discard_write_zeroes structs:
> > > +The \field{data} used for discard or write zeroes commands consists of one or
> > > +more segments.  The maximum number of segments is \field{max_discard_seg} for
> > > +discard commands and \field{max_write_zeroes_seg} for write zeroes commands.
> > > +Each segment is of form:
> > 
> > Maybe s/of form/of the form/ ?
> 
> I wanted to stay consistent with the existing text above it:
> 
>   The driver queues requests to the virtqueue, and they are used by
>   the device (not necessarily in order). Each request is of form:
> 
>   ...



OK so I will cancel the vote on this version for now?

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

