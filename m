Return-Path: <virtio-dev-return-8426-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 777D798647A
	for <virtio-dev@lists.oasis-open.org>; Wed, 28 Jul 2021 17:41:39 +0000 (UTC)
Date: Wed, 28 Jul 2021 18:41:32 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <20210728174132.GM6592@e120937-lin>
References: <20210712141833.6628-1-cristian.marussi@arm.com>
 <20210712141833.6628-11-cristian.marussi@arm.com>
 <20210728143418.5lton6l7t2oa6rtz@bogus>
MIME-Version: 1.0
In-Reply-To: <20210728143418.5lton6l7t2oa6rtz@bogus>
Subject: [virtio-dev] Re: [PATCH v6 10/17] firmware: arm_scmi: Make polling mode optional
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com, etienne.carriere@linaro.org, vincent.guittot@linaro.org, souvik.chakravarty@arm.com, igor.skalkin@opensynergy.com, peter.hilber@opensynergy.com, alex.bennee@linaro.org, jean-philippe@linaro.org, mikhail.golubev@opensynergy.com, anton.yakovlev@opensynergy.com, Vasyl.Vavrychuk@opensynergy.com, Andriy.Tryshnivskyy@opensynergy.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jul 28, 2021 at 03:34:18PM +0100, Sudeep Holla wrote:
> On Mon, Jul 12, 2021 at 03:18:26PM +0100, Cristian Marussi wrote:
> > Add a check for the presence of .poll_done transport operation so that
> > transports that do not need to support polling mode have no need to provide
> > a dummy .poll_done callback either and polling mode can be disabled in the
> > SCMI core for that tranport.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---

Hi,

> >  drivers/firmware/arm_scmi/driver.c | 43 ++++++++++++++++++------------
> >  1 file changed, 26 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> > index a952b6527b8a..4183d25c9289 100644
> > --- a/drivers/firmware/arm_scmi/driver.c
> > +++ b/drivers/firmware/arm_scmi/driver.c
> > @@ -777,25 +777,34 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
> >  	}
> >  
> >  	if (xfer->hdr.poll_completion) {
> > -		ktime_t stop = ktime_add_ns(ktime_get(), SCMI_MAX_POLL_TO_NS);
> > -
> > -		spin_until_cond(scmi_xfer_done_no_timeout(cinfo, xfer, stop));
> > -
> > -		if (ktime_before(ktime_get(), stop)) {
> > -			unsigned long flags;
> > -
> > -			/*
> > -			 * Do not fetch_response if an out-of-order delayed
> > -			 * response is being processed.
> > -			 */
> > -			spin_lock_irqsave(&xfer->lock, flags);
> > -			if (xfer->state == SCMI_XFER_SENT_OK) {
> > -				info->desc->ops->fetch_response(cinfo, xfer);
> > -				xfer->state = SCMI_XFER_RESP_OK;
> > +		if (info->desc->ops->poll_done) {
> > +			ktime_t stop = ktime_add_ns(ktime_get(),
> > +						    SCMI_MAX_POLL_TO_NS);
> > +
> > +			spin_until_cond(scmi_xfer_done_no_timeout(cinfo, xfer,
> > +								  stop));
> > +
> > +			if (ktime_before(ktime_get(), stop)) {
> > +				unsigned long flags;
> > +
> > +				/*
> > +				 * Do not fetch_response if an out-of-order delayed
> > +				 * response is being processed.
> > +				 */
> > +				spin_lock_irqsave(&xfer->lock, flags);
> > +				if (xfer->state == SCMI_XFER_SENT_OK) {
> > +					info->desc->ops->fetch_response(cinfo,
> > +									xfer);
> > +					xfer->state = SCMI_XFER_RESP_OK;
> > +				}
> > +				spin_unlock_irqrestore(&xfer->lock, flags);
> > +			} else {
> > +				ret = -ETIMEDOUT;
> >  			}
> > -			spin_unlock_irqrestore(&xfer->lock, flags);
> >  		} else {
> > -			ret = -ETIMEDOUT;
> > +			dev_warn_once(dev,
> > +				      "Polling mode is not supported by transport.\n");
> > +			ret = EINVAL;
> 
> Can't we just return this error as early as possible if the user isn't
> expected to use polling with this transport ? That would simplify the patch
> (as most of it is due to indentation which can go away) as you need not
> check it later ?
> 

Yes, indeed at first it was something like

if (xfer->hdr.poll_completion && !info->desc->ops->poll_done)
	return -EINVAL;

at the very beginning of do_xfer(), even before attempting to send
anything...and I liked much more but then I thought I would have run such
if-test for each and every command do_xfer() attempted...but maybe it's
just irrelevant and instead much more tidy if done as above.

I'll fix it as above.

Thanks,
Cristian

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

