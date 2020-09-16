Return-Path: virtio-comment-return-1457-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Wed, 16 Sep 2020 09:28:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200916092827-mutt-send-email-mst@kernel.org>
References: <159836664741.231431.2775539890399592989.stgit@ahduyck-workstation>
 <159836670239.231431.14835898822569373567.stgit@ahduyck-workstation>
 <fd8d3fed-a92a-4356-7a3d-fb773b04880a@siemens.com>
 <CAKgT0Ud7XfcEVL8jy-6kNQ=BDUJqh-xp94MZ7F2+Vf+mv1vj3Q@mail.gmail.com>
 <2faa1a86-fc9c-f325-00f0-99df49b2421d@siemens.com>
 <CAKgT0UercLR43iY1PQ7LOvEnqt-c2mds7Mv7XS=77Uju-Qdz=g@mail.gmail.com>
 <20200914081355.71f0d3f7.cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200914081355.71f0d3f7.cohuck@redhat.com>
Subject: Re: [virtio-comment] Re: [virtio-dev] [PATCH v8 1/3] content:
 Document balloon feature free page hints
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Cornelia Huck <cohuck@redhat.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, Jan Kiszka <jan.kiszka@siemens.com>, David Hildenbrand <david@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Wang, Wei W" <wei.w.wang@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Sep 14, 2020 at 08:13:55AM +0200, Cornelia Huck wrote:
> On Fri, 11 Sep 2020 08:11:15 -0700
> Alexander Duyck <alexander.duyck@gmail.com> wrote:
> 
> > On Thu, Sep 10, 2020 at 10:28 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
> > >
> > > On 04.09.20 18:56, Alexander Duyck wrote:  
> > > > On Fri, Sep 4, 2020 at 8:20 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:  
> > > >>
> > > >> On 25.08.20 16:45, Alexander Duyck wrote:  
> 
> > > >>> @@ -5042,13 +5049,17 @@ \subsection{Feature bits}\label{sec:Device Types / Memory Balloon Device / Featu
> > > >>>  VIRTIO_BALLOON_F_MUST_TELL_HOST is not negotiated.
> > > >>>
> > > >>>  \subsection{Device configuration layout}\label{sec:Device Types / Memory Balloon Device / Device configuration layout}
> > > >>> -  Both fields of this configuration
> > > >>> -  are always available.
> > > >>> +  \field{num_pages} and \field{actual} are always available.
> > > >>> +
> > > >>> +  \field{free_page_hint_cmd_id} is available if
> > > >>> +    VIRTIO_BALLOON_F_FREE_PAGE_HINT has been negotiated and is read-only by
> > > >>> +    the driver.  
> > > >>
> > > >> This reads at least to me like "...if VIRTIO_BALLOON_F_FREE_PAGE_HINT
> > > >> ... is read-only by the driver". I suspect you rather meant
> > > >> "free_page_hint_cmd_id is read-only...". Maybe split up into two sentences?  
> > > >
> > > > Yes, the intention is:
> > > > 1. free_page_hint_cmd_id is only available if
> > > > VIRTIO_BALLOON_F_FREE_PAGE_HINT has been negotiated
> > > > 2. free_page_hint_cmd_id is read only by the driver
> > > >
> > > > If needed I suppose we could break it up by splitting it into two
> > > > sentences, or adding "the field" after the "and".
> > > >  
> > >
> > > I'm fine with both options but please adjust this - on top (Michael just
> > > opened the voting for this version again due to the formal typo in round 1).
> > >
> > > Jan  
> > 
> > Since the patch set is being voted on is there a preferred method for
> > making this sort of update? I'm just wondering if I should do an
> > additional incremental patch, just submit a replacement for this
> > patch, or make the change and resubmit the entire patch set?
> 
> I think doing an additional patch on top and then doing another vote on
> that is the best way to handle this. (Or maybe it is minor enough to
> simply merge the incremental patch?)

yes, this sounds good to me


This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

