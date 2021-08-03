Return-Path: <virtio-dev-return-8468-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 393D09863C4
	for <virtio-dev@lists.oasis-open.org>; Tue,  3 Aug 2021 12:52:24 +0000 (UTC)
Date: Tue, 3 Aug 2021 13:52:17 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <20210803125217.GQ6592@e120937-lin>
References: <20210712141833.6628-1-cristian.marussi@arm.com>
 <20210712141833.6628-7-cristian.marussi@arm.com>
 <20210728141746.chqwhspnwviz67xn@bogus>
 <20210728165430.GJ6592@e120937-lin>
 <20210802102425.67bhbvyrgzio7zzg@bogus>
MIME-Version: 1.0
In-Reply-To: <20210802102425.67bhbvyrgzio7zzg@bogus>
Subject: [virtio-dev] Re: [PATCH v6 06/17] firmware: arm_scmi: Introduce monotonically
 increasing tokens
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com, etienne.carriere@linaro.org, vincent.guittot@linaro.org, souvik.chakravarty@arm.com, igor.skalkin@opensynergy.com, peter.hilber@opensynergy.com, alex.bennee@linaro.org, jean-philippe@linaro.org, mikhail.golubev@opensynergy.com, anton.yakovlev@opensynergy.com, Vasyl.Vavrychuk@opensynergy.com, Andriy.Tryshnivskyy@opensynergy.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Aug 02, 2021 at 11:24:25AM +0100, Sudeep Holla wrote:
> On Wed, Jul 28, 2021 at 05:54:30PM +0100, Cristian Marussi wrote:
> > On Wed, Jul 28, 2021 at 03:17:46PM +0100, Sudeep Holla wrote:
> > > On Mon, Jul 12, 2021 at 03:18:22PM +0100, Cristian Marussi wrote:
> 
> [...]
> 

Hi Sudeep,

I'm goignt to post V7 with all the remarks on the series from you and Peter
addressed.  A few notes beow on this patch.

> > > >  
> > > > +#define SCMI_PENDING_XFERS_HT_ORDER_SZ	9
> > > > +
> > > 
> > > Is there any particular reason to choose half the token size as hash bucket
> > > size ? IOW why not 1/3 or 1/4th of it ? I would appreciate a comment here.
> > > I see it is mentioned in the commit log. Also is it not better to associate
> > > or keep it close to MSG_TOKEN_ID_MASK and associated macros.
> > > 
> > 
> > I'll move this in the proper place where associated macros are defined.
> > 
> > The reason for the size choice is tricky (and not sure about its value
> > still...so I have not commented yet :D); the ideal size of this hashtable would
> > be desc->max_msg so equal to the maximum number of inflight messages allowed on
> > the system in order to minimize (probably to zero) collisions on the hashtable:
> > unfortunately max_msg is only finally available at runtime time and the
> > kernel hashtable is statically sized by design....
> > 
> > I tried to play some tricks to define dynamically the size but everything falls
> > apart since a lot of stuff in linux/hashtable.h is based on ARRAY_SIZE() and
> > friends (to speedup all I suppose). Another non-fit (in my opinion)
> > alternative would be using relativistic hashtable (linux/rhashtable.h) but
> > those are definitely overkill in our case since they are hashtables that
> > can be resized completely at runtime while populated O_o. (with even
> > more overhead)
> > 
> > At the end the size that fits all possible in-flight messages minimizing
> > collisions in any possible case that I can set at compile time would be 10,
> > which means really 2^10 1024 HT entries (equal to MAX_MSG_TOKEN) each of which
> > is a struct list_head (*prev,*next 16bytes) i.e. 16KB HT: Peter pointed out
> > that it would be a lot of wasted space on normal systems in which max in-flight
> > messages are far-less than 1024 AND would not even fit in one 4Kb page, so I
> > reduced it to 512 entries but the best would be 256 (8) if we want to
> > fit in one regular 4kb page. The drawback will be a bit of HT collisions on
> > system with more than 256 possible and effective in-flight messages.
> >
> 
> I agree, 256 should be fine for now. Just add a note that it is chosen to
> fit a page and can be updated if required.
> 
> 

Yes I added a comment explaining the situation, but, my bad, the 'good'
size that fits the HT into a 4k page is indeed 512 (9) because the HT array
is made of hlist_head (so only one pointer, good I double checked on myself :P)

> > > >  /**
> > > >   * struct scmi_xfers_info - Structure to manage transfer information
> > > >   *
> > > > - * @xfer_block: Preallocated Message array
> > > >   * @xfer_alloc_table: Bitmap table for allocated messages.
> > > >   *	Index of this bitmap table is also used for message
> > > >   *	sequence identifier.
> > > >   * @xfer_lock: Protection for message allocation
> > > > + * @last_token: A counter to use as base to generate for monotonically
> > > > + *		increasing tokens.
> > > > + * @free_xfers: A free list for available to use xfers. It is initialized with
> > > > + *		a number of xfers equal to the maximum allowed in-flight
> > > > + *		messages.
> > > > + * @pending_xfers: An hashtable, indexed by msg_hdr.seq, used to keep all the
> > > > + *		   currently in-flight messages.
> > > >   */
> > > >  struct scmi_xfers_info {
> > > > -	struct scmi_xfer *xfer_block;
> > > >  	unsigned long *xfer_alloc_table;
> > > >  	spinlock_t xfer_lock;
> > > > +	atomic_t last_token;
> > > 
> > > Can we merge this and transfer_last_id ? Let this be free running like
> > > transfer_last_id and just use [0-9] from this ? I don't see any point
> > > having 2 different monotonically increasing tokens/id.
> > > 
> > 
> > Mmm I was tempted about that, but the reason I did not was that in some
> > rare limit condition as you can see in the ASCII art (:O) I can find a hole in
> > the next available token ids so I have to skip and update last_token itself,
> > not sure if this could cause confusion seeing transfer_ids with holes during
> > tracing if I unify them.
> >
> 
> That should be fine as it won't be used at all.
> 

In V7 I removed mx_info last_token and I'm using last_transfer_id; my
only concern (mostly theoretical I think) is that last_transfer_id is
picked from a global atomic and so it is shared by any platform or
channel instance. (and being global is good for tracing correlation
in fact...)

In particular this means that it is also shared with notifications
(which do not use monotonic seqnums), so that, if a flood of notifs
suddenly kicks in, a lot of transfer_idS would be burnt (for tracing
notifs.. not for seqnums) and any following command will end up picking
a good valid monotonic seqnum BUT far away from the previous one
(i.e. there will be holes in the set of monotonic seqnums): no issue
with that but it could lead, under some very awkward limit conditions,
to an early reuse of seqnums for commands (i.e. a less effective
mitigation of seqnums reusing).

Anyway in my tests on this new version I have see no issues and the
above mentioned case is clearly borderline so I made the change (and
noted the above scenario in a comment)

Thanks,
Cristian


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

