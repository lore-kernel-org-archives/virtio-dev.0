Return-Path: virtio-dev-return-3304-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id AB076581912A
	for <virtio-dev@lists.oasis-open.org>; Tue, 27 Feb 2018 11:56:07 -0800 (PST)
Date: Tue, 27 Feb 2018 21:56:04 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180227215553-mutt-send-email-mst@kernel.org>
References: <61ea318df06f6e50c5f9cfffaaae85aa51ae5b58.1519045824.git.tgolembi@redhat.com>
 <20180220171544.GC12161@stefanha-x1.localdomain>
 <20180221001135.41bc13a1@fiorina>
 <20180221113328.GB19501@stefanha-x1.localdomain>
 <20180221184417.7d5bf2df@fiorina>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180221184417.7d5bf2df@fiorina>
Subject: Re: [virtio-dev] [PATCH] content: document balloon memory statistics
To: =?utf-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org, Jonathan Helman <jonathan.helman@oracle.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Feb 21, 2018 at 06:44:17PM +0100, Tomáš Golembiovský wrote:
> On Wed, 21 Feb 2018 11:33:28 +0000
> Stefan Hajnoczi <stefanha@redhat.com> wrote:
> 
> > On Wed, Feb 21, 2018 at 12:11:35AM +0100, Tomáš Golembiovský wrote:
> > > On Tue, 20 Feb 2018 17:15:44 +0000
> > > Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > > 
> > > > On Mon, Feb 19, 2018 at 02:10:29PM +0100, Tomáš Golembiovský wrote:
> > > > > +\item[VIRTIO_BALLOON_S_CACHES (7)] The amount of memory currently used for
> > > > > +  caching files and other data from disk (in bytes).
> > > > >  \end{description}  
> > > > 
> > > > This one is somewhat vague.  I'm not sure if it means guest page cache
> > > > specifically or something more general.
> > > > 
> > > > On the other hand, the numbers tend to be OS specific...
> > > 
> > > We should come up with a definition that is as definite as possible
> > > while leaving room for all systems to substitute a value that is
> > > natively available. So if anyone has a better formulation then please
> > > advise. The original intent was not to create a Linux specific field.
> > > 
> > > On Linux the value corresponds to Buffers + Cached + SwapCached memory
> > > stats. Correct me if I'm wrong but that should be all clean pages that
> > > have a counterpart on disk and can be quickly reclaimed and used for
> > > something else (without additional IO).
> > 
> > Thanks for clarifying.  Based on what you posted, how about:
> > 
> > "The amount of memory, in bytes, that can be quickly reclaimed without
> > additional I/O.  Typically these pages are used for caching files from
> > disk."
> > 
> > ?
> 
> Sounds reasonable, thanks
> 
>     Tomas

OK - will you post v2 then?

> 
> > 
> > > On Windows this roughly corresponds to the standby list. Or maybe
> > > standby list plus something else. I suppose there may be some
> > > alternative on BSD too.
> > > 
> > >     Tomas
> > > 
> > > 
> > > -- 
> > > Tomáš Golembiovský <tgolembi@redhat.com>
> 
> 
> -- 
> Tomáš Golembiovský <tgolembi@redhat.com>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

