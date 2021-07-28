Return-Path: <virtio-dev-return-8424-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9EF0598647A
	for <virtio-dev@lists.oasis-open.org>; Wed, 28 Jul 2021 16:54:46 +0000 (UTC)
Date: Wed, 28 Jul 2021 17:54:30 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <20210728165430.GJ6592@e120937-lin>
References: <20210712141833.6628-1-cristian.marussi@arm.com>
 <20210712141833.6628-7-cristian.marussi@arm.com>
 <20210728141746.chqwhspnwviz67xn@bogus>
MIME-Version: 1.0
In-Reply-To: <20210728141746.chqwhspnwviz67xn@bogus>
Subject: [virtio-dev] Re: [PATCH v6 06/17] firmware: arm_scmi: Introduce monotonically
 increasing tokens
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com, etienne.carriere@linaro.org, vincent.guittot@linaro.org, souvik.chakravarty@arm.com, igor.skalkin@opensynergy.com, peter.hilber@opensynergy.com, alex.bennee@linaro.org, jean-philippe@linaro.org, mikhail.golubev@opensynergy.com, anton.yakovlev@opensynergy.com, Vasyl.Vavrychuk@opensynergy.com, Andriy.Tryshnivskyy@opensynergy.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jul 28, 2021 at 03:17:46PM +0100, Sudeep Holla wrote:
> On Mon, Jul 12, 2021 at 03:18:22PM +0100, Cristian Marussi wrote:
> > Tokens are sequence numbers embedded in the each SCMI message header: they
> > are used to correlate commands with responses (and delayed responses), but
> > their usage and policy of selection is entirely up to the caller (usually
> > the OSPM agent), while they are completely opaque to the callee (SCMI
> > server platform) which merely copies them back from the command into the
> > response message header.
> > This also means that the platform does not, can not and should not enforce
> > any kind of policy on received messages depending on the contained sequence
> > number: platform can perfectly handle concurrent requests carrying the same
> > identifiying token if that should happen.
> > 
> > Moreover the platform is not required to produce in-order responses to
> > agent requests, the only constraint in these regards is that in case of
> > an asynchronous message the delayed response must be sent after the
> > immediate response for the synchronous part of the command transaction.
> > 
> > Currenly the SCMI stack of the OSPM agent selects a token for the egressing
> > commands picking the lowest possible number which is not already in use by
> > an existing in-flight transaction, which means, in other words, that we
> > immediately reuse any token after its transaction has completed or it has
> > timed out: this policy indeed does simplify management and lookup of tokens
> > and associated xfers.
> > 
> > Under the above assumptions and constraints, since there is really no state
> > shared between the agent and the platform to let the platform know when a
> > token and its associated message has timed out, the current policy of early
> > reuse of tokens can easily lead to the situation in which a spurious or
> > late received response (or delayed_response), related to an old stale and
> > timed out transaction, can be wrongly associated to a newer valid in-flight
> > xfer that just happens to have reused the same token.
> > 
> > This misbehaviour on such ghost responses is more easily exposed on those
> > transports that naturally have an higher level of parallelism in processing
> > multiple concurrent in-flight messages.
> >

Hi,

> 
> The term ghost is used here without any reference to what it means. That
> could make it difficult to follow if someone unaware of it is trying to
> understand.
> 

Right, I'll reword this.

> > This commit introduces a new policy of selection of tokens for the OSPM
> > agent: each new command transfer now gets the next available, monotonically
> > increasing token, until tokens are exhausted and the counter rolls over.
> > 
> > Such new policy mitigates the above issues with ghost responses since the
> > tokens are now reused as late as possible (when they roll back ideally)
> > and so it is much easier to identify such ghost responses to stale timed
> > out transactions: this also helps in simplifying the specific transports
> > implementation since stale transport messages can be easily identified
> > and discarded early on in the rx path without the need to cross check
> > their actual state with the core transport layer.
> > This mitigation is even more effective when, as is usually the case, the
> > maximum number of pending messages is capped by the platform to a much
> > lower number than the whole possible range of tokens values (2^10).
> > 
> > This internal policy change in the core SCMI transport layer is fully
> > transparent to the specific transports so it has not and should not have
> > any impact on the transports implementation.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> > v4 --> V5
> > - removed empirical profiling info from commit msg
> > - do NOT use monotonic tokens and pending HT for notifications (not needed)
> > - release xfer_lock later in scmi_xfer_get
> > ---
> >  drivers/firmware/arm_scmi/common.h |  25 +++
> >  drivers/firmware/arm_scmi/driver.c | 260 +++++++++++++++++++++++++----
> >  2 files changed, 249 insertions(+), 36 deletions(-)
> > 
> > diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
> > index 6bb734e0e3ac..2233d0a188fc 100644
> > --- a/drivers/firmware/arm_scmi/common.h
> > +++ b/drivers/firmware/arm_scmi/common.h
> > @@ -14,7 +14,10 @@
> >  #include <linux/device.h>
> >  #include <linux/errno.h>
> >  #include <linux/kernel.h>
> > +#include <linux/hashtable.h>
> > +#include <linux/list.h>
> >  #include <linux/module.h>
> > +#include <linux/refcount.h>
> >  #include <linux/scmi_protocol.h>
> >  #include <linux/types.h>
> >  
> > @@ -138,6 +141,10 @@ struct scmi_msg {
> >   *	buffer for the rx path as we use for the tx path.
> >   * @done: command message transmit completion event
> >   * @async_done: pointer to delayed response message received event completion
> > + * @users: A refcount to track the active users for this xfer
> > + * @pending: True for xfers added to @pending_xfers hashtable
> > + * @node: An hlist_node reference used to store this xfer, alternatively, on
> > + *	  the free list @free_xfers or in the @pending_xfers hashtable
> >   */
> >  struct scmi_xfer {
> >  	int transfer_id;
> > @@ -146,8 +153,26 @@ struct scmi_xfer {
> >  	struct scmi_msg rx;
> >  	struct completion done;
> >  	struct completion *async_done;
> > +	refcount_t users;
> > +	bool pending;
> > +	struct hlist_node node;
> >  };
> >  
> > +/*
> > + * An helper macro to lookup an xfer from the @pending_xfers hashtable
> > + * using the message sequence number token as a key.
> > + */
> > +#define XFER_FIND(__ht, __k)					\
> > +({								\
> > +	typeof(__k) k_ = __k;					\
> > +	struct scmi_xfer *xfer_ = NULL;				\
> > +								\
> > +	hash_for_each_possible((__ht), xfer_, node, k_)		\
> > +		if (xfer_->hdr.seq == k_)			\
> > +			break;					\
> > +	xfer_;							\
> > +})
> > +
> >  struct scmi_xfer_ops;
> >  
> >  /**
> > diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> > index 4c77ee13b1ad..245ede223302 100644
> > --- a/drivers/firmware/arm_scmi/driver.c
> > +++ b/drivers/firmware/arm_scmi/driver.c
> > @@ -21,6 +21,7 @@
> >  #include <linux/io.h>
> >  #include <linux/kernel.h>
> >  #include <linux/ktime.h>
> > +#include <linux/hashtable.h>
> >  #include <linux/list.h>
> >  #include <linux/module.h>
> >  #include <linux/of_address.h>
> > @@ -65,19 +66,29 @@ struct scmi_requested_dev {
> >  	struct list_head node;
> >  };
> >  
> > +#define SCMI_PENDING_XFERS_HT_ORDER_SZ	9
> > +
> 
> Is there any particular reason to choose half the token size as hash bucket
> size ? IOW why not 1/3 or 1/4th of it ? I would appreciate a comment here.
> I see it is mentioned in the commit log. Also is it not better to associate
> or keep it close to MSG_TOKEN_ID_MASK and associated macros.
> 

I'll move this in the proper place where associated macros are defined.

The reason for the size choice is tricky (and not sure about its value
still...so I have not commented yet :D); the ideal size of this hashtable would
be desc->max_msg so equal to the maximum number of inflight messages allowed on
the system in order to minimize (probably to zero) collisions on the hashtable:
unfortunately max_msg is only finally available at runtime time and the
kernel hashtable is statically sized by design....

I tried to play some tricks to define dynamically the size but everything falls
apart since a lot of stuff in linux/hashtable.h is based on ARRAY_SIZE() and
friends (to speedup all I suppose). Another non-fit (in my opinion)
alternative would be using relativistic hashtable (linux/rhashtable.h) but
those are definitely overkill in our case since they are hashtables that
can be resized completely at runtime while populated O_o. (with even
more overhead)

At the end the size that fits all possible in-flight messages minimizing
collisions in any possible case that I can set at compile time would be 10,
which means really 2^10 1024 HT entries (equal to MAX_MSG_TOKEN) each of which
is a struct list_head (*prev,*next 16bytes) i.e. 16KB HT: Peter pointed out
that it would be a lot of wasted space on normal systems in which max in-flight
messages are far-less than 1024 AND would not even fit in one 4Kb page, so I
reduced it to 512 entries but the best would be 256 (8) if we want to
fit in one regular 4kb page. The drawback will be a bit of HT collisions on
system with more than 256 possible and effective in-flight messages.

So, best of all would be runtime sizing of the HT, which is not possible
with current statically sized Kernel hashtable.h (even though I started looking
into that I have to admit :D), or sizing to 8 (256 entries 4k) to fit in a page,
or 10 (1024 entries 16kb) to minimize any possible collision if we do
not care about wasted memory and/or page boundary.

> >  /**
> >   * struct scmi_xfers_info - Structure to manage transfer information
> >   *
> > - * @xfer_block: Preallocated Message array
> >   * @xfer_alloc_table: Bitmap table for allocated messages.
> >   *	Index of this bitmap table is also used for message
> >   *	sequence identifier.
> >   * @xfer_lock: Protection for message allocation
> > + * @last_token: A counter to use as base to generate for monotonically
> > + *		increasing tokens.
> > + * @free_xfers: A free list for available to use xfers. It is initialized with
> > + *		a number of xfers equal to the maximum allowed in-flight
> > + *		messages.
> > + * @pending_xfers: An hashtable, indexed by msg_hdr.seq, used to keep all the
> > + *		   currently in-flight messages.
> >   */
> >  struct scmi_xfers_info {
> > -	struct scmi_xfer *xfer_block;
> >  	unsigned long *xfer_alloc_table;
> >  	spinlock_t xfer_lock;
> > +	atomic_t last_token;
> 
> Can we merge this and transfer_last_id ? Let this be free running like
> transfer_last_id and just use [0-9] from this ? I don't see any point
> having 2 different monotonically increasing tokens/id.
> 

Mmm I was tempted about that, but the reason I did not was that in some
rare limit condition as you can see in the ASCII art (:O) I can find a hole in
the next available token ids so I have to skip and update last_token itself,
not sure if this could cause confusion seeing transfer_ids with holes during
tracing if I unify them.

> > +	struct hlist_head free_xfers;
> > +	DECLARE_HASHTABLE(pending_xfers, SCMI_PENDING_XFERS_HT_ORDER_SZ);
> >  };
> >  
> >  /**
> > @@ -190,45 +201,177 @@ void *scmi_notification_instance_data_get(const struct scmi_handle *handle)
> >  	return info->notify_priv;
> >  }
> >  
> > +/**
> > + * scmi_xfer_token_set  - Reserve and set new token for the xfer at hand
> > + *
> > + * @minfo: Pointer to Tx/Rx Message management info based on channel type
> > + * @xfer: The xfer to act upon
> > + *
> > + * Pick the next unused monotonically increasing token and set it into
> > + * xfer->hdr.seq: picking a monotonically increasing value avoids immediate
> > + * reuse of freshly completed or timed-out xfers, thus mitigating the risk
> > + * of incorrect association of a late and expired xfer with a live in-flight
> > + * transaction, both happening to re-use the same token identifier.
> > + *
> > + * Since platform is NOT required to answer our request in-order we should
> > + * account for a few rare but possible scenarios:
> > + *
> > + *  - exactly 'next_token' may be NOT available so pick xfer_id >= next_token
> > + *    using find_next_zero_bit() starting from candidate next_token bit
> > + *
> > + *  - all tokens ahead upto (MSG_TOKEN_ID_MASK - 1) are used in-flight but we
> > + *    are plenty of free tokens at start, so try a second pass using
> > + *    find_next_zero_bit() and starting from 0.
> > + *
> > + *  X = used in-flight
> > + *
> > + * Normal
> > + * ------
> > + *
> > + *		|- xfer_id picked
> > + *   -----------+----------------------------------------------------------
> > + *   | | |X|X|X| | | | | | ... ... ... ... ... ... ... ... ... ... ...|X|X|
> > + *   ----------------------------------------------------------------------
> > + *		^
> > + *		|- next_token
> > + *
> > + * Out-of-order pending at start
> > + * -----------------------------
> > + *
> > + *	  |- xfer_id picked, last_token fixed
> > + *   -----+----------------------------------------------------------------
> > + *   |X|X| | | | |X|X| ... ... ... ... ... ... ... ... ... ... ... ...|X| |
> > + *   ----------------------------------------------------------------------
> > + *    ^
> > + *    |- next_token
> > + *
> > + *
> > + * Out-of-order pending at end
> > + * ---------------------------
> > + *
> > + *	  |- xfer_id picked, last_token fixed
> > + *   -----+----------------------------------------------------------------
> > + *   |X|X| | | | |X|X| ... ... ... ... ... ... ... ... ... ... |X|X|X||X|X|
> > + *   ----------------------------------------------------------------------
> > + *								^
> > + *								|- next_token
> > + *
> > + * Context: Assumes to be called with @xfer_lock already acquired.
> > + *
> > + * Return: 0 on Success or error
> > + */
> > +static int scmi_xfer_token_set(struct scmi_xfers_info *minfo,
> > +			       struct scmi_xfer *xfer)
> > +{
> > +	unsigned long xfer_id, next_token;
> > +
> > +	/* Pick a candidate monotonic token in range [0, MSG_TOKEN_MAX - 1] */
> > +	next_token = (atomic_inc_return(&minfo->last_token) &
> > +		      (MSG_TOKEN_MAX - 1));
> > +
> > +	/* Pick the next available xfer_id >= next_token */
> > +	xfer_id = find_next_zero_bit(minfo->xfer_alloc_table,
> > +				     MSG_TOKEN_MAX, next_token);
> > +	if (xfer_id == MSG_TOKEN_MAX) {
> > +		/*
> > +		 * After heavily out-of-order responses, there are no free
> > +		 * tokens ahead, but only at start of xfer_alloc_table so
> > +		 * try again from the beginning.
> > +		 */
> > +		xfer_id = find_next_zero_bit(minfo->xfer_alloc_table,
> > +					     MSG_TOKEN_MAX, 0);
> > +		/*
> > +		 * Something is wrong if we got here since there can be a
> > +		 * maximum number of (MSG_TOKEN_MAX - 1) in-flight messages
> > +		 * but we have not found any free token [0, MSG_TOKEN_MAX - 1].
> > +		 */
> > +		if (WARN_ON_ONCE(xfer_id == MSG_TOKEN_MAX))
> > +			return -ENOMEM;
> > +	}
> > +
> > +	/* Update +/- last_token accordingly if we skipped some hole */
> > +	if (xfer_id != next_token)
> > +		atomic_add((int)(xfer_id - next_token), &minfo->last_token);
> > +
> > +	/* Set in-flight */
> > +	set_bit(xfer_id, minfo->xfer_alloc_table);
> > +	xfer->hdr.seq = (u16)xfer_id;
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * scmi_xfer_token_clear  - Release the token
> > + *
> > + * @minfo: Pointer to Tx/Rx Message management info based on channel type
> > + * @xfer: The xfer to act upon
> > + */
> > +static inline void scmi_xfer_token_clear(struct scmi_xfers_info *minfo,
> > +					 struct scmi_xfer *xfer)
> > +{
> > +	clear_bit(xfer->hdr.seq, minfo->xfer_alloc_table);
> > +}
> > +
> >  /**
> >   * scmi_xfer_get() - Allocate one message
> >   *
> >   * @handle: Pointer to SCMI entity handle
> >   * @minfo: Pointer to Tx/Rx Message management info based on channel type
> > + * @set_pending: If true a monotonic token is picked and the xfer is added to
> > + *		 the pending hash table.
> >   *
> >   * Helper function which is used by various message functions that are
> >   * exposed to clients of this driver for allocating a message traffic event.
> >   *
> > - * This function can sleep depending on pending requests already in the system
> > - * for the SCMI entity. Further, this also holds a spinlock to maintain
> > - * integrity of internal data structures.
> > + * Picks an xfer from the free list @free_xfers (if any available) and, if
> > + * required, sets a monotonically increasing token and stores the inflight xfer
> > + * into the @pending_xfers hashtable for later retrieval.
> > + *
> > + * The successfully initialized xfer is refcounted.
> > + *
> > + * Context: Holds @xfer_lock while manipulating @xfer_alloc_table and
> > + *	    @free_xfers.
> >   *
> >   * Return: 0 if all went fine, else corresponding error.
> >   */
> >  static struct scmi_xfer *scmi_xfer_get(const struct scmi_handle *handle,
> > -				       struct scmi_xfers_info *minfo)
> > +				       struct scmi_xfers_info *minfo,
> > +				       bool set_pending)
> >  {
> > -	u16 xfer_id;
> > +	int ret;
> > +	unsigned long flags;
> >  	struct scmi_xfer *xfer;
> > -	unsigned long flags, bit_pos;
> > -	struct scmi_info *info = handle_to_scmi_info(handle);
> >  
> > -	/* Keep the locked section as small as possible */
> >  	spin_lock_irqsave(&minfo->xfer_lock, flags);
> > -	bit_pos = find_first_zero_bit(minfo->xfer_alloc_table,
> > -				      info->desc->max_msg);
> > -	if (bit_pos == info->desc->max_msg) {
> > +	if (hlist_empty(&minfo->free_xfers)) {
> >  		spin_unlock_irqrestore(&minfo->xfer_lock, flags);
> >  		return ERR_PTR(-ENOMEM);
> >  	}
> > -	set_bit(bit_pos, minfo->xfer_alloc_table);
> > -	spin_unlock_irqrestore(&minfo->xfer_lock, flags);
> >  
> > -	xfer_id = bit_pos;
> > +	/* grab an xfer from the free_list */
> > +	xfer = hlist_entry(minfo->free_xfers.first, struct scmi_xfer, node);
> > +	hlist_del_init(&xfer->node);
> > +
> > +	if (set_pending) {
> > +		/* Pick and set monotonic token */
> > +		ret = scmi_xfer_token_set(minfo, xfer);
> > +		if (!ret) {
> > +			hash_add(minfo->pending_xfers, &xfer->node,
> > +				 xfer->hdr.seq);
> > +			xfer->pending = true;
> > +		} else {
> > +			dev_err(handle->dev,
> > +				"Failed to get monotonic token %d\n", ret);
> > +			hlist_add_head(&xfer->node, &minfo->free_xfers);
> > +			xfer = ERR_PTR(ret);
> > +		}
> > +	}
> >  
> > -	xfer = &minfo->xfer_block[xfer_id];
> > -	xfer->hdr.seq = xfer_id;
> > -	xfer->transfer_id = atomic_inc_return(&transfer_last_id);
> > +	if (!IS_ERR(xfer)) {
> > +		refcount_set(&xfer->users, 1);
> > +		xfer->transfer_id = atomic_inc_return(&transfer_last_id);
> > +	}
> > +	spin_unlock_irqrestore(&minfo->xfer_lock, flags);
> >  
> >  	return xfer;
> >  }
> > @@ -239,6 +382,9 @@ static struct scmi_xfer *scmi_xfer_get(const struct scmi_handle *handle,
> >   * @minfo: Pointer to Tx/Rx Message management info based on channel type
> >   * @xfer: message that was reserved by scmi_xfer_get
> >   *
> > + * After refcount check, possibly release an xfer, clearing the token slot,
> > + * removing xfer from @pending_xfers and putting it back into free_xfers.
> > + *
> >   * This holds a spinlock to maintain integrity of internal data structures.
> >   */
> >  static void
> > @@ -246,16 +392,44 @@ __scmi_xfer_put(struct scmi_xfers_info *minfo, struct scmi_xfer *xfer)
> >  {
> >  	unsigned long flags;
> >  
> > -	/*
> > -	 * Keep the locked section as small as possible
> > -	 * NOTE: we might escape with smp_mb and no lock here..
> > -	 * but just be conservative and symmetric.
> > -	 */
> >  	spin_lock_irqsave(&minfo->xfer_lock, flags);
> > -	clear_bit(xfer->hdr.seq, minfo->xfer_alloc_table);
> > +	if (refcount_dec_and_test(&xfer->users)) {
> 
> The introduction of users in this patch seems useless. I am assuming there are
> multiple users and this is to prevent some race. I was about to ask if we can
> manage without it, but seeing some additional use of it in later patches, I
> will comment later. It may still make sense to move this to later patch as
> it doesn't add anything here ?
> 

Indeed I was not sure about introducing it here, the problem that addresses is
as follows: a normal cmd flow is xfer_get/send/rx/xfer_put ... but if a command
times out on the TX path BEFORE is finally xfer_put() by the invoking protocol,
the MSG is still valid (as state) and pending for a while and if something is
received in the RX path concurrently, the transport calls scmi_rx_callback and
the risk would be that the xfer would be acquired just fine and processed by RX
(still has to be xfer_put as said) and then be suddendly vanished by the final
xfer_put on the TX path while RX is working on it. (or worst released while RX
is working on it and then picked from the free_list and reused for send while
RX is still processing it...ok bit of unlucky case I have to admit..)

So xfer->users is meant to avoid the xfer being vanished by the xfer_put() in
the TX path while rx_callback is still working on it....in such a case the
rx_callback will be allowed to process safely the xfer (even though it timed
out in TX) till the end of its RX-processing and the result will be then finally
discarded at the end with the final __scmi_xfer_put inside handle_response
that at the end releases the xfer once for all.

Using a refcount allows me to avoid bigger spinlocked critical sections (or at least
was the idea :D)

> > +		if (xfer->pending) {
> > +			scmi_xfer_token_clear(minfo, xfer);
> > +			hash_del(&xfer->node);
> > +			xfer->pending = false;
> > +		}
> > +		hlist_add_head(&xfer->node, &minfo->free_xfers);
> > +	}
> >  	spin_unlock_irqrestore(&minfo->xfer_lock, flags);
> >  }
> >  
> > +/**
> > + * scmi_xfer_lookup_unlocked  -  Helper to lookup an xfer_id
> > + *
> > + * @minfo: Pointer to Tx/Rx Message management info based on channel type
> > + * @xfer_id: Token ID to lookup in @pending_xfers
> > + *
> > + * Refcounting is untouched.
> > + *
> > + * Context: Assumes to be called with @xfer_lock already acquired.
> > + *
> > + * Return: A valid xfer on Success or error otherwise
> > + */
> > +static struct scmi_xfer *
> > +scmi_xfer_lookup_unlocked(struct scmi_xfers_info *minfo, u16 xfer_id)
> > +{
> > +	struct scmi_xfer *xfer = NULL;
> > +
> > +	if (xfer_id >= MSG_TOKEN_MAX)
> > +		return ERR_PTR(-EINVAL);
> > +
> 
> Is this really needed ? I guess we always use MSG_XTRACT_TOKEN(hdr) to
> fetch the xfer_id, no ?
> 

Right, indeed comes from a MSG_XTRACT_TOKEN, I'll drop it.

Thanks,
Cristian


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

