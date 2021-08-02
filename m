Return-Path: <virtio-dev-return-8456-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9D03D986275
	for <virtio-dev@lists.oasis-open.org>; Mon,  2 Aug 2021 10:27:34 +0000 (UTC)
Date: Mon, 2 Aug 2021 11:27:27 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <20210802102727.GP6592@e120937-lin>
References: <20210712141833.6628-1-cristian.marussi@arm.com>
 <20210712141833.6628-8-cristian.marussi@arm.com>
 <20210802101032.ozlidylogmdt2zqu@bogus>
MIME-Version: 1.0
In-Reply-To: <20210802101032.ozlidylogmdt2zqu@bogus>
Subject: [virtio-dev] Re: [PATCH v6 07/17] firmware: arm_scmi: Handle concurrent and
 out-of-order messages
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com, etienne.carriere@linaro.org, vincent.guittot@linaro.org, souvik.chakravarty@arm.com, igor.skalkin@opensynergy.com, peter.hilber@opensynergy.com, alex.bennee@linaro.org, jean-philippe@linaro.org, mikhail.golubev@opensynergy.com, anton.yakovlev@opensynergy.com, Vasyl.Vavrychuk@opensynergy.com, Andriy.Tryshnivskyy@opensynergy.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Aug 02, 2021 at 11:10:32AM +0100, Sudeep Holla wrote:
> On Mon, Jul 12, 2021 at 03:18:23PM +0100, Cristian Marussi wrote:
> > Even though in case of asynchronous commands an SCMI platform server is
> 
> Drop the term "server"
> 

Sure.

> > constrained to emit the delayed response message only after the related
> > message response has been sent, the configured underlying transport could
> > still deliver such messages together or in inverted order, causing races
> > due to the concurrent or out-of-order access to the underlying xfer.
> > 
> > Introduce a mechanism to grant exclusive access to an xfer in order to
> > properly serialize concurrent accesses to the same xfer originating from
> > multiple correlated messages.
> > 
> > Add additional state information to xfer descriptors so as to be able to
> > identify out-of-order message deliveries and act accordingly:
> > 
> >  - when a delayed response is expected but delivered before the related
> >    response, the synchronous response is considered as successfully
> >    received and the delayed response processing is carried on as usual.
> > 
> >  - when/if the missing synchronous response is subsequently received, it
> >    is discarded as not congruent with the current state of the xfer, or
> >    simply, because the xfer has been already released and so, now, the
> >    monotonically increasing sequence number carried by the late response
> >    is stale.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> > v5 --> v6
> > - added spinlock comment
> > ---
> >  drivers/firmware/arm_scmi/common.h |  18 ++-
> >  drivers/firmware/arm_scmi/driver.c | 229 ++++++++++++++++++++++++-----
> >  2 files changed, 212 insertions(+), 35 deletions(-)
> > 
> > diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
> > index 2233d0a188fc..9efebe1406d2 100644
> > --- a/drivers/firmware/arm_scmi/common.h
> > +++ b/drivers/firmware/arm_scmi/common.h
> > @@ -19,6 +19,7 @@
> >  #include <linux/module.h>
> >  #include <linux/refcount.h>
> >  #include <linux/scmi_protocol.h>
> > +#include <linux/spinlock.h>
> >  #include <linux/types.h>
> >  
> >  #include <asm/unaligned.h>
> > @@ -145,6 +146,13 @@ struct scmi_msg {
> >   * @pending: True for xfers added to @pending_xfers hashtable
> >   * @node: An hlist_node reference used to store this xfer, alternatively, on
> >   *	  the free list @free_xfers or in the @pending_xfers hashtable
> > + * @busy: An atomic flag to ensure exclusive write access to this xfer
> > + * @state: The current state of this transfer, with states transitions deemed
> > + *	   valid being:
> > + *	    - SCMI_XFER_SENT_OK -> SCMI_XFER_RESP_OK [ -> SCMI_XFER_DRESP_OK ]
> > + *	    - SCMI_XFER_SENT_OK -> SCMI_XFER_DRESP_OK
> > + *	      (Missing synchronous response is assumed OK and ignored)
> > + * @lock: A spinlock to protect state and busy fields.
> >   */
> >  struct scmi_xfer {
> >  	int transfer_id;
> > @@ -156,6 +164,15 @@ struct scmi_xfer {
> >  	refcount_t users;
> >  	bool pending;
> >  	struct hlist_node node;
> > +#define SCMI_XFER_FREE		0
> > +#define SCMI_XFER_BUSY		1
> > +	atomic_t busy;
> > +#define SCMI_XFER_SENT_OK	0
> > +#define SCMI_XFER_RESP_OK	1
> > +#define SCMI_XFER_DRESP_OK	2
> > +	int state;
> > +	/* A lock to protect state and busy fields */
> > +	spinlock_t lock;
> >  };
> >  
> >  /*
> > @@ -392,5 +409,4 @@ bool shmem_poll_done(struct scmi_shared_mem __iomem *shmem,
> >  void scmi_notification_instance_data_set(const struct scmi_handle *handle,
> >  					 void *priv);
> >  void *scmi_notification_instance_data_get(const struct scmi_handle *handle);
> > -
> >  #endif /* _SCMI_COMMON_H */
> > diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> > index 245ede223302..5ef33d692670 100644
> > --- a/drivers/firmware/arm_scmi/driver.c
> > +++ b/drivers/firmware/arm_scmi/driver.c
> > @@ -369,6 +369,7 @@ static struct scmi_xfer *scmi_xfer_get(const struct scmi_handle *handle,
> >  
> >  	if (!IS_ERR(xfer)) {
> >  		refcount_set(&xfer->users, 1);
> > +		atomic_set(&xfer->busy, SCMI_XFER_FREE);
> >  		xfer->transfer_id = atomic_inc_return(&transfer_last_id);
> >  	}
> >  	spin_unlock_irqrestore(&minfo->xfer_lock, flags);
> > @@ -430,6 +431,168 @@ scmi_xfer_lookup_unlocked(struct scmi_xfers_info *minfo, u16 xfer_id)
> >  	return xfer ?: ERR_PTR(-EINVAL);
> >  }
> >  
> > +/**
> > + * scmi_msg_response_validate  - Validate message type against state of related
> > + * xfer
> > + *
> > + * @cinfo: A reference to the channel descriptor.
> > + * @msg_type: Message type to check
> > + * @xfer: A reference to the xfer to validate against @msg_type
> > + *
> > + * This function checks if @msg_type is congruent with the current state of
> > + * a pending @xfer; if an asynchronous delayed response is received before the
> > + * related synchronous response (Out-of-Order Delayed Response) the missing
> > + * synchronous response is assumed to be OK and completed, carrying on with the
> > + * Delayed Response: this is done to address the case in which the underlying
> > + * SCMI transport can deliver such out-of-order responses.
> > + *
> > + * Context: Assumes to be called with xfer->lock already acquired.
> > + *
> > + * Return: 0 on Success, error otherwise
> > + */
> > +static inline int scmi_msg_response_validate(struct scmi_chan_info *cinfo,
> > +					     u8 msg_type,
> > +					     struct scmi_xfer *xfer)
> > +{
> > +	/*
> > +	 * Even if a response was indeed expected on this slot at this point,
> > +	 * a buggy platform could wrongly reply feeding us an unexpected
> > +	 * delayed response we're not prepared to handle: bail-out safely
> > +	 * blaming firmware.
> > +	 */
> > +	if (msg_type == MSG_TYPE_DELAYED_RESP && !xfer->async_done) {
> > +		dev_err(cinfo->dev,
> > +			"Delayed Response for %d not expected! Buggy F/W ?\n",
> > +			xfer->hdr.seq);
> > +		return -EINVAL;
> > +	}
> > +
> > +	switch (xfer->state) {
> > +	case SCMI_XFER_SENT_OK:
> > +		if (msg_type == MSG_TYPE_DELAYED_RESP) {
> > +			/*
> > +			 * Delayed Response expected but delivered earlier.
> > +			 * Assume message RESPONSE was OK and skip state.
> > +			 */
> > +			xfer->hdr.status = SCMI_SUCCESS;
> > +			xfer->state = SCMI_XFER_RESP_OK;
> > +			complete(&xfer->done);
> > +			dev_warn(cinfo->dev,
> > +				 "Received valid OoO Delayed Response for %d\n",
> > +				 xfer->hdr.seq);
> > +		}
> > +		break;
> > +	case SCMI_XFER_RESP_OK:
> > +		if (msg_type != MSG_TYPE_DELAYED_RESP)
> > +			return -EINVAL;
> > +		break;
> > +	case SCMI_XFER_DRESP_OK:
> > +		/* No further message expected once in SCMI_XFER_DRESP_OK */
> 
> Do we really need this case ? If so, how can this happen.
> 

Given that I am checking for state validity I thought to account also
for the case of possible (even though rare) duplicated delayed response.

> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static bool scmi_xfer_is_free(struct scmi_xfer *xfer)
> > +{
> > +	int ret;
> > +
> > +	ret = atomic_cmpxchg(&xfer->busy, SCMI_XFER_FREE, SCMI_XFER_BUSY);
> > +
> > +	return ret == SCMI_XFER_FREE;
> > +}
> > +
> > +/**
> > + * scmi_xfer_command_acquire  -  Helper to lookup and acquire a command xfer
> > + *
> > + * @cinfo: A reference to the channel descriptor.
> > + * @msg_hdr: A message header to use as lookup key
> > + *
> > + * When a valid xfer is found for the sequence number embedded in the provided
> > + * msg_hdr, reference counting is properly updated and exclusive access to this
> > + * xfer is granted till released with @scmi_xfer_command_release.
> > + *
> > + * Return: A valid @xfer on Success or error otherwise.
> > + */
> > +static inline struct scmi_xfer *
> > +scmi_xfer_command_acquire(struct scmi_chan_info *cinfo, u32 msg_hdr)
> > +{
> > +	int ret;
> > +	unsigned long flags;
> > +	struct scmi_xfer *xfer;
> > +	struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
> > +	struct scmi_xfers_info *minfo = &info->tx_minfo;
> > +	u8 msg_type = MSG_XTRACT_TYPE(msg_hdr);
> > +	u16 xfer_id = MSG_XTRACT_TOKEN(msg_hdr);
> > +
> > +	/* Are we even expecting this? */
> > +	spin_lock_irqsave(&minfo->xfer_lock, flags);
> > +	xfer = scmi_xfer_lookup_unlocked(minfo, xfer_id);
> > +	if (IS_ERR(xfer)) {
> > +		dev_err(cinfo->dev,
> > +			"Message for %d type %d is not expected!\n",
> > +			xfer_id, msg_type);
> > +		spin_unlock_irqrestore(&minfo->xfer_lock, flags);
> > +		return xfer;
> > +	}
> > +	refcount_inc(&xfer->users);
> > +	spin_unlock_irqrestore(&minfo->xfer_lock, flags);
> > +
> > +	spin_lock_irqsave(&xfer->lock, flags);
> > +	ret = scmi_msg_response_validate(cinfo, msg_type, xfer);
> > +	/*
> > +	 * If a pending xfer was found which was also in a congruent state with
> > +	 * the received message, acquire exclusive access to it setting the busy
> > +	 * flag.
> > +	 * Spins only on the rare limit condition of concurrent reception of
> > +	 * RESP and DRESP for the same xfer.
> > +	 */
> > +	if (!ret) {
> > +		spin_until_cond(scmi_xfer_is_free(xfer));
> 
> I agree with the discussion between you and Peter around this, so I assume
> it will be renamed or handled accordingly.
> 

Ok I'll rename it.

> > +		xfer->hdr.type = msg_type;
> > +	}
> > +	spin_unlock_irqrestore(&xfer->lock, flags);
> > +
> > +	if (ret) {
> > +		dev_err(cinfo->dev,
> > +			"Invalid message type:%d for %d - HDR:0x%X  state:%d\n",
> > +			msg_type, xfer_id, msg_hdr, xfer->state);
> > +		/* On error the refcount incremented above has to be dropped */
> > +		__scmi_xfer_put(minfo, xfer);
> > +		xfer = ERR_PTR(-EINVAL);
> > +	}
> > +
> > +	return xfer;
> > +}
> > +
> > +static inline void scmi_xfer_command_release(struct scmi_info *info,
> > +					     struct scmi_xfer *xfer)
> > +{
> > +	atomic_set(&xfer->busy, SCMI_XFER_FREE);
> > +	__scmi_xfer_put(&info->tx_minfo, xfer);
> > +}
> > +
> > +/**
> > + * scmi_xfer_state_update  - Update xfer state
> > + *
> > + * @xfer: A reference to the xfer to update
> > + *
> > + * Context: Assumes to be called on an xfer exclusively acquired using the
> > + *	    busy flag.
> > + */
> > +static inline void scmi_xfer_state_update(struct scmi_xfer *xfer)
> > +{
> > +	switch (xfer->hdr.type) {
> > +	case MSG_TYPE_COMMAND:
> > +		xfer->state = SCMI_XFER_RESP_OK;
> > +		break;
> > +	case MSG_TYPE_DELAYED_RESP:
> > +		xfer->state = SCMI_XFER_DRESP_OK;
> > +		break;
> > +	}
> > +}
> 
> Can't this be if () ..  else if(), switch sounds unnecessary for 2 conditions.
> 

Yes indeed I'll rework in V7.

> Other than the things already discussed with you and Peter, don't have much to
> add ATM. I may look at this with fresh eyes once again in the next version.
> 

Thanks for the review.

Cristian


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

